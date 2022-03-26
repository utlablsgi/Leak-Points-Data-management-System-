%% Author: Ray Kwong Wai,Chang %%

function varargout = PAR_lnc_loop2020(varargin)
% PAR_LNC_LOOP2020 MATLAB code for PAR_lnc_loop2020.fig
%      PAR_LNC_LOOP2020, by itself, creates a new PAR_LNC_LOOP2020 or raises the existing
%      singleton*.
%
%      H = PAR_LNC_LOOP2020 returns the handle to a new PAR_LNC_LOOP2020 or the handle to
%      the existing singleton*.
%
%      PAR_LNC_LOOP2020('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAR_LNC_LOOP2020.M with the given input arguments.
%
%      PAR_LNC_LOOP2020('Property','Value',...) creates a new PAR_LNC_LOOP2020 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PAR_lnc_loop2020_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PAR_lnc_loop2020_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% threshold_edit the above text to modify the response to help PAR_lnc_loop2020

% Last Modified by GUIDE v2.5 28-Apr-2021 17:41:32

% Begin initialization code - DO NOT THRESHOLD_EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PAR_lnc_loop2020_OpeningFcn, ...
    'gui_OutputFcn',  @PAR_lnc_loop2020_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT THRESHOLD_EDIT


% --- Executes just before PAR_lnc_loop2020 is made visible.
function PAR_lnc_loop2020_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PAR_lnc_loop2020 (see VARARGIN)


handles.path = '../';
handles.path2 = '../'; 
handles.file5 = '';
handles.file4 = '';
set(hObject,'toolbar','figure');
set(hObject,'Menubar','figure');
% Choose default command line output for PAR_lnc_loop2020
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PAR_lnc_loop2020 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PAR_lnc_loop2020_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in file4_pushbutton.
function file4_pushbutton_Callback(hObject, eventdata, handles)
path2 = handles.path2;
if (isempty(path2) | (path2==0))    
    [file4,path2] = uigetfile('*.wav','Wave1 File');
    return
else
    [file4,path2] = uigetfile('*.wav','Wave1 File',path2);
    if (isempty(file4)|(file4==0))
        return
    else
        handles.fullFile4 = fullfile(path2,file4);
    end
end
handles.path2 = path2;
handles.file4 = file4;
guidata(hObject,handles);
% hObject    handle to file4_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in file5_pushbutton.
function file5_pushbutton_Callback(hObject, eventdata, handles)
path2 = handles.path2;
if (isempty(path2) | (path2==0))
    [file5,path2] = uigetfile('*.wav','Wave2 File');
    return
else
    [file5,path2] = uigetfile('*.wav','Wave2 File',path2);
    if(isempty(file5)|(file5==0))
        return
    else
        handles.fullFile5 = fullfile(path2,file5);
    end
end
handles.path2 = path2;
handles.file5 = file5;
guidata(hObject,handles);
% hObject    handle to file5_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in file6_pushbutton.
function file6_pushbutton_Callback(hObject, eventdata, handles)
path2 = handles.path2;
if (isempty(path2) | (path2==0))
    [file6,path2] = uigetfile('*.wav','Yellow Pump File');
else
    [file6,path2] = uigetfile('*.wav','Yellow Pump File',path2);
end
handles.fullFile6 = fullfile(path2,file6);
handles.path2 = path2;
guidata(hObject,handles);
% hObject    handle to file6_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in waveRemoveLoop_pushbutton.
function waveRemoveLoop_pushbutton_Callback(hObject, eventdata, handles)

%========================================================================%%
path2 = handles.path2;
name1 = handles.file4;
name2 = handles.file5;
align2 = get(handles.align2_checkbox,'Value');
isFFT = get(handles.isFFT_checkbox,'Value');
if isempty(name1)||isequal(name1,0)
    warndlg('No file is selected for Wave1');
else
    if isempty(name2)||isequal(name2,0);
        warndlg('No file is selected for Wave2');
    else
        
        yWave1 = audioread(handles.fullFile4);
        info1 = audioinfo(handles.fullFile4);
        yWave2 = audioread(handles.fullFile5);
        info2 = audioinfo(handles.fullFile5);
        %Check which file is the shortest length
        resolution = floor(info1.SampleRate/4);
        L1 = length(yWave1);
        L2 = length(yWave2);
        if (L1 >= L2)
            L = L2;
        else
            L = L1;
        end
        
        if(~isFFT)
            if(~align2)
                %Just Wave1-Wave2
                nWave = yWave1(1:L) - yWave2(1:L);
            else
                %Amplitude alignment
                yWave1_rms = rms(yWave1);
                if (yWave1_rms==0)
                    warndlg('The wave rms is zero. Do not tick Amplitude Alignment');
                    return
                end
                yWave2_rms = rms(yWave2);
                if (yWave2_rms==0)
                    warndlg('The wave rms is zero. Do not tick Amplitude Alignment');
                    return
                end
                if (yWave1_rms >=yWave2_rms)
                    yWave2 = yWave2*yWave1_rms/yWave2_rms;
                else
                    yWave1 = yWave1*yWave2_rms/yWave1_rms;
                end
                nWave = yWave1(1:L) - yWave2(1:L);
            end
        else
            if(~align2)
                %FFT all signals
                nWave=[];
                for n=0:floor(L/resolution)-1
                    YWave1 = fft(yWave1(1+n*resolution:resolution+n*resolution));
                    YWave2 = fft(yWave2(1+n*resolution:resolution+n*resolution));
                    YWave12 = (YWave1)-(YWave2);
                    nWave_temp = ifft(YWave12);
                    nWave(end+1:end+resolution,1)= nWave_temp;
                end
            else
                %Amplitude alignment
                yWave1_rms = rms(yWave1);
                if yWave1_rms==0
                    warndlg('The wave rms is zero. Do not tick Amplitude Alignment');
                    return
                end
                
                yWave2_rms = rms(yWave2);
                if yWave2_rms==0
                    warndlg('The wave rms is zero. Do not tick Amplitude Alignment');
                    return
                end
                if(yWave1_rms >= yWave2)
                    yWave2 = yWave2*yWave1_rms/yWave2_rms;
                else
                    yWave1 = yWave1*yWave2_rms/yWave1_rms;
                end
                YWave2 = (fft(yWave2,L));
                YWave1 = (fft(yWave1,L));
                nWave = ifft(YWave1-YWave2);
            end
        end

      %***************************************%
        c = {path2,name1};
        path3 = strjoin(c,{'new_'});
      %***************************************%
        [nfname,npath] = uiputfile('*.wav','Save New Red Sound',path3);
        if isequal(nfname,0)||isequal(npath,0)
            warndlg('No File is saved');
        else
            nFullFile = fullfile(npath,nfname);
            audiowrite(nFullFile,nWave,info1.SampleRate,'BitsPerSample',info1.BitsPerSample);
            nWave_fft = (fft(nWave));
            yWave1_fft = (fft(yWave1,resolution));
            yWave2_fft = (fft(yWave2,resolution));
            
            spectrumPlot(nWave_fft,info1.SampleRate,handles.axes1,'g');
            title('Spectrum of Resulted signal(Wave1-Wave2)','Color','k');
            axesProperties();
            spectrumPlot(yWave1_fft,info1.SampleRate,handles.axes2,'m');
            title('Spectrum of Wave1','Color','k');
            axesProperties();
            spectrumPlot(yWave2_fft,info2.SampleRate,handles.axes3,'c');
            title('Spectrum of Wave2','Color','k');
            axesProperties();
        end
    end    
end



function lowPass_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lowPass_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowPass_edit as text
%        str2double(get(hObject,'String')) returns contents of lowPass_edit as a double


% --- Executes during object creation, after setting all properties.
function lowPass_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowPass_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hPass_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hPass_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hPass_edit as text
%        str2double(get(hObject,'String')) returns contents of hPass_edit as a double


% --- Executes during object creation, after setting all properties.
function hPass_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hPass_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fOrder_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fOrder_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fOrder_edit as text
%        str2double(get(hObject,'String')) returns contents of fOrder_edit as a double


% --- Executes during object creation, after setting all properties.
function fOrder_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fOrder_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in noise_checkbox.
function noise_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to noise_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noise_checkbox


% --- Executes on button press in bandPass_checkbox.
function bandPass_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to bandPass_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%


function lowerF1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lowerF1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerF1_edit as text
%        str2double(get(hObject,'String')) returns contents of lowerF1_edit as a double


% --- Executes during object creation, after setting all properties.
function lowerF1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerF1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperF1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to upperF1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperF1_edit as text
%        str2double(get(hObject,'String')) returns contents of upperF1_edit as a double


% --- Executes during object creation, after setting all properties.
function upperF1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperF1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerF2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lowerF2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerF2_edit as text
%        str2double(get(hObject,'String')) returns contents of lowerF2_edit as a double


% --- Executes during object creation, after setting all properties.
function lowerF2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerF2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperF2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to upperF2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperF2_edit as text
%        str2double(get(hObject,'String')) returns contents of upperF2_edit as a double


% --- Executes during object creation, after setting all properties.
function upperF2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperF2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerF3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lowerF3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerF3_edit as text
%        str2double(get(hObject,'String')) returns contents of lowerF3_edit as a double


% --- Executes during object creation, after setting all properties.
function lowerF3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerF3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperF3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to upperF3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperF3_edit as text
%        str2double(get(hObject,'String')) returns contents of upperF3_edit as a double


% --- Executes during object creation, after setting all properties.
function upperF3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperF3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerF4_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lowerF4_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerF4_edit as text
%        str2double(get(hObject,'String')) returns contents of lowerF4_edit as a double


% --- Executes during object creation, after setting all properties.
function lowerF4_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerF4_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperF4_edit_Callback(hObject, eventdata, handles)
% hObject    handle to upperF4_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperF4_edit as text
%        str2double(get(hObject,'String')) returns contents of upperF4_edit as a double


% --- Executes during object creation, after setting all properties.
function upperF4_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperF4_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setZeroLoop_pushbutton.
function setZeroLoop_pushbutton_Callback(hObject, eventdata, handles)
%% Get input values in panel "Set Zero Filter"
cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);
pause(0.000001);
noiseLv = 0;
lowerF1 = str2double(get(handles.lowerF1_edit,'String'));
lowerF2 = str2double(get(handles.lowerF2_edit,'String'));
lowerF3 = str2double(get(handles.lowerF3_edit,'String'));
lowerF4 = str2double(get(handles.lowerF4_edit,'String'));
upperF1 = str2double(get(handles.upperF1_edit,'String'));
upperF2 = str2double(get(handles.upperF2_edit,'String'));
upperF3 = str2double(get(handles.upperF3_edit,'String'));
upperF4 = str2double(get(handles.upperF4_edit,'String'));
%Get all the inputs in WaveRead panel:
%%get the length of pipe, noise text_velocity and calculate the sample length
temp_length=str2double(get(handles.length_edit,'String'));
temp_velocity=str2double(get(handles.edit_diameter,'String'));
ham = str2double(get(handles.hamming_edit,'String'));
fullS = get(handles.fullSignal_checkbox,'Value');
thresholdQ = str2double(get(handles.qFactor_edit,'String'));
threshold = str2double(get(handles.threshold_edit,'String'));
align = get(handles.align_checkbox,'Value');
%%%get the multiple of sample length desire from input
cycle=str2double(get(handles.cycle_edit,'String'));
shift1 = str2double(get(handles.shift1_edit,'String'));
redBox=get(handles.red_checkbox,'Value');
blueBox=get(handles.blue_checkbox,'Value');
yellowBox=get(handles.yellow_checkbox,'Value');
%%check the checkbox value, if ture, read the wav and plot it on the graph
if(blueBox)
    if(redBox)
        [yBlueFull,handles.Fs] = audioread(handles.fullFile2);
        [yRedFull] = audioread(handles.fullFile1);
        % All variables need Fs
        sectorLength=round(temp_length/temp_velocity*handles.Fs);
        %%%calculate the range to be read and convert to double format
        doubleRange=round(sectorLength*cycle);
        doubleShift=round(shift1*handles.Fs);
        %-----------------------------------------------------------------%
        ifft_RedFull = setZeroFilterLoop(yRedFull,lowerF1,upperF1,lowerF2,upperF2,...
            lowerF3,upperF3,lowerF4,upperF4,handles.Fs,noiseLv);
        ifft_BlueFull = setZeroFilterLoop(yBlueFull,lowerF1,upperF1,lowerF2,upperF2,...
            lowerF3,upperF3,lowerF4,upperF4,handles.Fs,noiseLv);
        %Amplitude alignment
        if(align)            
            ifft_RedFull_rms = rms(ifft_RedFull);
            ifft_BlueFull_rms = rms(ifft_BlueFull);
            [ifft_RedFull] = ifft_RedFull*(ifft_BlueFull_rms/ifft_RedFull_rms);
        else
            [ifft_RedFull] = ifft_RedFull;
        end
        % Check length of 2 signals
        LB = length(ifft_BlueFull);
        LR = length(ifft_RedFull);
        if(LB>=LR)
            L = LR;
        else
            L = LB;
        end
        repeat = round(L/doubleRange-doubleShift)-2;
        delayArr = [];
        QFactArr = [];
        for n=0:repeat
            [ifft_Blue] = ifft_BlueFull(1+doubleShift+n*doubleRange:...
                doubleRange+doubleShift+n*doubleRange);
            [ifft_Red] = ifft_RedFull(1+doubleShift+n*doubleRange:...
                doubleRange+doubleShift+n*doubleRange);
            
            % To calculate the lag time different between red and blue
            [timeDiff,xcorrMax,QFactor] = xcorrLoop(ifft_Blue,ifft_Red,handles.Fs,...
                thresholdQ,handles.axes1,threshold);
            if (isempty(timeDiff))
                delayArr(end+1,1)= NaN;
                delayArr(end,2)=NaN;
            else
                delayArr(end+1,1)=timeDiff;
                delayArr(end,2)=xcorrMax;
            end
            if(isempty(QFactor))
                QFactArr = QFactArr;
            else
                QFactArr(end+1) = QFactor;
            end
                  
            set(handles.iteration_text,'String',num2str(n+1));
        end
        title('Cross-correlation above the threshold of Blue-Red with set zero','Color','k');
        if(fullS)
            loopPlotAll(ifft_BlueFull,ifft_RedFull,handles.Fs,...
                handles.axes3,'b','r',ham,handles.axes2);
        else
            loopPlotAll(ifft_Blue,ifft_Red,handles.Fs,...
                handles.axes3,'b','r',ham,handles.axes2);
        end
    end
end
% Blue and Yellow setZero
if(blueBox)
    if(yellowBox)
        [yBlueFull,handles.Fs] = audioread(handles.fullFile2);
        [yYellowFull] = audioread(handles.fullFile3);
        % All variables need Fs
        sectorLength=round(temp_length/temp_velocity*handles.Fs);
        %%%calculate the range to be read and convert to double format
        doubleRange=round(sectorLength*cycle);
        doubleShift=round(shift1*handles.Fs);
        %-----------------------------------------------------------------%
        ifft_YellowFull = setZeroFilterLoop(yYellowFull,lowerF1,upperF1,lowerF2,upperF2,...
            lowerF3,upperF3,lowerF4,upperF4,handles.Fs,noiseLv);
        ifft_BlueFull = setZeroFilterLoop(yBlueFull,lowerF1,upperF1,lowerF2,upperF2,...
            lowerF3,upperF3,lowerF4,upperF4,handles.Fs,noiseLv);
        %Amplitude alignment
        if(align)            
            ifft_YellowFull_rms = rms(ifft_YellowFull);
            ifft_BlueFull_rms = rms(ifft_BlueFull);
            [ifft_YellowFull] = ifft_YellowFull*(ifft_BlueFull_rms/ifft_YellowFull_rms);
        else
            [ifft_YellowFull] = ifft_YellowFull;
        end
        % Check length of 2 signals
        LB = length(ifft_BlueFull);
        LR = length(ifft_YellowFull);
        if(LB>=LR)
            L = LR;
        else
            L = LB;
        end
        repeat = round(L/doubleRange-doubleShift)-2;
        delayArr = [];
        QFactArr = [];
        for n=0:repeat
            [ifft_Blue] = ifft_BlueFull(1+doubleShift+n*doubleRange:...
                doubleRange+doubleShift+n*doubleRange);
            [ifft_Yellow] = ifft_YellowFull(1+doubleShift+n*doubleRange:...
                doubleRange+doubleShift+n*doubleRange);
            
            % To calculate the lag time different between red and blue
            [timeDiff,xcorrMax,QFactor] = xcorrLoop(ifft_Blue,ifft_Yellow,handles.Fs,...
                thresholdQ,handles.axes1,threshold);
            if (isempty(timeDiff))
                delayArr(end+1,1)= NaN;
                delayArr(end,2)=NaN;
            else
                delayArr(end+1,1)=timeDiff;
                delayArr(end,2)=xcorrMax;
            end
            if(isempty(QFactor))
                QFactArr = QFactArr;
            else
                QFactArr(end+1) = QFactor;
            end
                  
            set(handles.iteration_text,'String',num2str(n+1));
        end
        title('Cross-correlation above the threshold of Blue-Yellow with set zero','Color','k');
        if(fullS)
            loopPlotAll(ifft_BlueFull,ifft_YellowFull,handles.Fs,...
                handles.axes3,'b','r',ham,handles.axes2);
        else
            loopPlotAll(ifft_Blue,ifft_Yellow,handles.Fs,...
                handles.axes3,'b','r',ham,handles.axes2);
        end
    end
end

Mean = mean(delayArr(:,1),'omitnan');
[Mode,F] = mode(delayArr(:,1));
[Max,I] = max(delayArr(:,2),[],'omitnan');
MaxXcorrDelay = delayArr(I,1);
SD = std(delayArr,'omitnan');
%Display the delay in time (sec)
set(handles.delay_text,'String',num2str((temp_length+temp_velocity*Mean)/2));
set(handles.mode_text,'String',num2str((temp_length+temp_velocity*Mode)/2));
set(handles.max_text,'String',num2str((temp_length+temp_velocity*MaxXcorrDelay)/2));
%Calculate the frequency of mode and passing rate at this threshold.
set(handles.aboveTh_text,'String',num2str(F));
pass = sum(delayArr(:,1)==delayArr(:,1),1);
set(handles.pass_text,'String',num2str(pass));
%Display SD
set(handles.sd_text,'String',num2str(SD));
%Display QFactor
set(handles.qFactor_text,'String',num2str(mean(QFactArr)));


% hObject    handle to setZeroLoop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%
function length_edit_Callback(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of length_edit as text
%        str2double(get(hObject,'String')) returns contents of length_edit as a double


% --- Executes during object creation, after setting all properties.
function length_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function shift1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to shift1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shift1_edit as text
%        str2double(get(hObject,'String')) returns contents of shift1_edit as a double


% --- Executes during object creation, after setting all properties.
function shift1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shift1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cycle_edit_Callback(hObject, eventdata, handles)
% hObject    handle to cycle_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cycle_edit as text
%        str2double(get(hObject,'String')) returns contents of cycle_edit as a double


% --- Executes during object creation, after setting all properties.
function cycle_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cycle_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hamming_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hamming_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hamming_edit as text
%        str2double(get(hObject,'String')) returns contents of hamming_edit as a double


% --- Executes during object creation, after setting all properties.
function hamming_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hamming_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in red_checkbox.
function red_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to red_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of red_checkbox


% --- Executes on button press in blue_checkbox.
function blue_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to blue_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blue_checkbox


% --- Executes on button press in yellow_checkbox.
function yellow_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to yellow_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of yellow_checkbox


% --- Executes on button press in file1_pushbutton.
function file1_pushbutton_Callback(hObject, eventdata, handles)
% Check the path if it is empty and direct to the last path if it is no,
% direct to working directory if it is empty
path = handles.path;
if (isempty(path) | (path==0))
    [file1,path] = uigetfile('*.wav','Red File');
else
    [file1,path] = uigetfile('*.wav','Red File',path);
end
handles.fullFile1 = fullfile(path,file1);
handles.path = path;
handles.file1 = file1;
guidata(hObject,handles);
% hObject    handle to file1_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in file2_pushbutton.
function file2_pushbutton_Callback(hObject, eventdata, handles)
path = handles.path;
if (isempty(path) | (path==0))
    [file2,path] = uigetfile('*.wav','Blue File');
else
    [file2,path] = uigetfile('*.wav','Blue File',path);
end
handles.fullFile2 = fullfile(path,file2);
handles.file2 = file2;
handles.path = path;
guidata(hObject,handles);
% hObject    handle to file2_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in file3_pushbutton.
function file3_pushbutton_Callback(hObject, eventdata, handles)
path = handles.path;
if (isempty(path) | (path==0))
    [file3,path] = uigetfile('*.wav','Yellow File');
else
    [file3,path] = uigetfile('*.wav','Yellow File',path);
end
handles.fullFile3 = fullfile(path,file3);
handles.path = path;
guidata(hObject,handles);
% hObject    handle to file3_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in wavReadLoop_pushbutton.
function wavReadLoop_pushbutton_Callback(hObject, eventdata, handles)
%%

cla(handles.axes1,'reset');
cla(handles.axes2);
cla(handles.axes3);
pause(0.000001);
%Get all the inputs in WaveRead panel:
%%get the length of pipe, noise text_velocity and calculate the sample length
temp_length=str2double(get(handles.length_edit,'String'));

temp_diameter=str2double(get(handles.edit_diameter,'String'));
temp_material= get(handles.popupmenu_material,'value');
temp_velocity= lookupVelocity(temp_material, temp_diameter);
set(handles.text_velocity,'String',num2str(temp_velocity));

fullS = get(handles.fullSignal_checkbox,'Value');
thresholdQ = str2double(get(handles.qFactor_edit,'String'));
threshold = str2double(get(handles.threshold_edit,'String'));
align = get(handles.align_checkbox,'Value');
loop = floor(str2double(get(handles.loop_edit,'String')));
%%%get the multiple of sample length desire from input
cycle=str2double(get(handles.cycle_edit,'String'));
shift1 = str2double(get(handles.shift1_edit,'String'));
%%check the checkbox value, if ture, read the wav and plot it on the graph
redBox=get(handles.red_checkbox,'Value');
blueBox=get(handles.blue_checkbox,'Value');
yellowBox=get(handles.yellow_checkbox,'Value');
ham = str2double(get(handles.hamming_edit,'String'));
%Display left and right receivers file name
set(handles.left_rx,'String',handles.file1);
set(handles.right_rx,'String',handles.file2);
%Get the checkbox value of bandPass_checkbox
bandPassAdd = get(handles.bandPass_checkbox,'Value');

if(blueBox)
    if(redBox)
        %Loop for wave read
        [yBlueFull,handles.Fs] = audioread(handles.fullFile2);
        [yRedFull] = audioread(handles.fullFile1);
        if(bandPassAdd)
            [yRedFullF,yBlueFullF] = bandPass(yRedFull,yBlueFull,handles);
            yRedFull = yRedFullF;
            yBlueFull = yBlueFullF;
        else
        end
        % All variables need Fs
        sectorLength=round(temp_length/temp_velocity*handles.Fs);
        %%%calculate the range to be read and convert to double format
        doubleRange=round(sectorLength*cycle);
        doubleShift=round(shift1*handles.Fs);
        %Amplitude alignment
        if(align)
            yRedFull_rms = rms(yRedFull);
            yBlueFull_rms = rms(yBlueFull);
            [yRedFull] = yRedFull*(yBlueFull_rms/yRedFull_rms);
        else
            [yRedFull] = yRedFull;
        end
        % Check length of 2 signals
        LB = length(yBlueFull);
        LR = length(yRedFull);
        if (LB >= LR)
            L = LR;
        else
            L = LB;
        end
        
%         repeat = floor(L/doubleRange-doubleShift)-1;
        repeat = loop;
        delayArr = [];
        QFactArr = [];
%         xline(sectorLength/handles.Fs*1000);
%         xline(sectorLength/handles.Fs*-1000);
        for n=1:repeat
%             [yBlue] = yBlueFull(1+doubleShift+floor((n-0.5)*doubleRange):...
%                 doubleShift+floor((n+1.5)*doubleRange));
            [yRed] = yRedFull(1+doubleShift+n*doubleRange:...
                doubleRange+doubleShift+n*doubleRange);
            [yBlue] = yBlueFull(1+doubleShift+n*doubleRange:...
                doubleRange+doubleShift+n*doubleRange);
% % %             a=1+doubleShift+n*doubleRange
% % %             b=doubleRange+doubleShift+n*doubleRange
                % To calculate the lag time different between red and blue
            [timeDiff,xcorrMax,QFactor] = xcorrLoop(yRed,yBlue,handles.Fs,...
                thresholdQ,handles.axes1,threshold,sectorLength);
            if (isempty(timeDiff))
                delayArr(end+1,1)= NaN;
                delayArr(end,2)=NaN;
            else
                delayArr(end+1,1)=timeDiff;
                delayArr(end,2)=xcorrMax;
            end
            if(isempty(QFactor))
                QFactArr = QFactArr;
            else
                QFactArr(end+1) = QFactor;
            end
            set(handles.iteration_text,'String',num2str(n));

            handles.leakArr = (temp_length+temp_velocity/1000.*delayArr(:,1))/2;
            plot(handles.axes2,handles.leakArr,'*','MarkerEdgeColor','red'); 
            axis(handles.axes2,[0 repeat 0 temp_length]);
            hold on
%             if(fullS)
%                 loopPlotAll(yBlueFull,yRedFull,handles.Fs,...
%                     handles.axes3,'b','r',ham,handles.axes2);
%             else
%                 loopPlotAll(yBlue,yRed,handles.Fs,...
%                     handles.axes3,'b','r',ham,handles.axes2);
%             end
            
        end
%         title('Cross-correlation above the threshold of Red-Blue','Color','k');
        
    end
end
if(blueBox)
    if(yellowBox)
        %Loop for wave read
        [yBlueFull,handles.Fs] = audioread(handles.fullFile2);
        [yYellowFull] = audioread(handles.fullFile3);
        % All variables need Fs
        sectorLength=round(temp_length/temp_velocity*handles.Fs);
        %%%calculate the range to be read and convert to double format
        doubleRange=round(sectorLength*cycle);
        doubleShift=round(shift1*handles.Fs);
        %Amplitude alignment
        if(align)
            yYellowFull_rms = rms(yYellowFull);
            yBlueFull_rms = rms(yBlueFull);
            [yYellowFull] = yYellowFull*(yBlueFull_rms/yYellowFull_rms);
        else
            [yYellowFull] = yYellowFull;
        end
        % Check length of 2 signals
        LB = length(yBlueFull);
        LR = length(yYellowFull);
        if (LB >= LR)
            L = LR;
        else
            L = LB;
        end
        
        repeat = loop;
        delayArr = [];
        QFactArr = [];
%         xline(sectorLength/handles.Fs*1000);
%         xline(sectorLength/handles.Fs*-1000);
        for n=0:repeat
            [yBlue] = yBlueFull(1+doubleShift+n*doubleRange:...
                doubleRange+doubleShift+n*doubleRange);
            [yYellow] = yYellowFull(1+doubleShift+n*doubleRange:...
                doubleRange+doubleShift+n*doubleRange);
            
            % To calculate the lag time different between red and blue
            [timeDiff,xcorrMax,QFactor] = xcorrLoop(yBlue,yYellow,handles.Fs,...
                thresholdQ,handles.axes1,threshold,sectorLength);
            if (isempty(timeDiff))
                delayArr(end+1,1)= NaN;
                delayArr(end,2)=NaN;
            else
                delayArr(end+1,1)=timeDiff;
                delayArr(end,2)=xcorrMax;
            end
            if(isempty(QFactor))
                QFactArr = QFactArr;
            else
                QFactArr(end+1) = QFactor;
            end
            set(handles.iteration_text,'String',num2str(n));

%             if(fullS)
%                 loopPlotAll(yBlueFull,yYellowFull,handles.Fs,...
%                     handles.axes3,'b','r',ham,handles.axes2);
%             else
%                 loopPlotAll(yBlue,yYellow,handles.Fs,...
%                     handles.axes3,'b','r',ham,handles.axes2);
%             end
        end
%         title('Cross-correlation above the threshold of Blue-Yellow','Color','k');
        
    end
end

axes(handles.axes2);
title('Distribution of leak point','color','black');
xlabel('Number of calculation');
ylabel('Distance(m) from LHS sensor');
axes(handles.axes3);
h=histogram(handles.leakArr,'BinWidth',handles.bin);
title('Histogram of leak point');
xlabel('Distance(m) from LHS sensor');
ylabel('Frequency(#)');
Mean = mean(delayArr(:,1),'omitnan');
[Mode,F,C] = mode(delayArr(:,1));
Mode = Mode;
[Max,I] = max(delayArr(:,2),[],'omitnan');
MaxXcorrDelay = delayArr(I,1)/1000;
%Standard deviation of all delays
SD = std(delayArr(:,1),'omitnan');
%Display the delay in time (sec)
set(handles.delay_text,'String',num2str(Mode,'%.3f'));
set(handles.mode_text,'String',num2str((temp_length+temp_velocity*Mode/1000)/2,'%.3f'));
set(handles.max_text,'String',num2str((temp_length+temp_velocity*MaxXcorrDelay)/2,'%.3f'));
%Calculate the frequency of mode and passing rate at this threshold.
set(handles.aboveTh_text,'String',num2str(F));
pass = sum(delayArr(:,1)==delayArr(:,1),1);
set(handles.pass_text,'String',num2str(pass));
%Display SD
set(handles.sd_text,'String',num2str(SD,'%.3g'));
%Display QFactor
set(handles.qFactor_text,'String',num2str(mean(QFactArr)));
%Display sampling freq.
set(handles.text_sampling,'String',handles.Fs);
handles.yRedFull = yRedFull;
handles.yBlueFull = yBlueFull;
handles.ham = ham;
handles.h = h;
handles.temp_length = temp_length;
handles.temp_velocity = temp_velocity;
handles.delayArr = delayArr;
guidata(hObject,handles);


% hObject    handle to wavReadLoop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function vel = lookupVelocity(temp_material, temp_diameter)
if temp_material == 1
    f = msgbox('Please select a pipe material','Error', 'error');
elseif temp_material == 2
    if temp_diameter > 0 & temp_diameter <= 60
        vel = 1320;
    elseif temp_diameter > 60 & temp_diameter <= 110
        vel = 1280;
    elseif temp_diameter > 110 & temp_diameter <= 260
        vel = 1210;
    elseif temp_diameter > 260 & temp_diameter <= 360
        vel = 1180;
    elseif temp_diameter > 360 & temp_diameter <= 560
        vel = 1130;
    elseif temp_diameter > 560 & temp_diameter <= 760
        vel = 1110;
    elseif temp_diameter > 760 & temp_diameter <= 960
        vel = 1070;
    elseif temp_diameter > 960
        vel = 1050;
    else
        f = msgbox('Cannot find a correct velocity','Error', 'error');
    end
elseif temp_material == 3
    if temp_diameter > 0 & temp_diameter <= 10
        vel = 1140;
    elseif temp_diameter > 10 & temp_diameter <= 460
        vel = 1120;
    elseif temp_diameter > 460 & temp_diameter <= 710
        vel = 1100;
    elseif temp_diameter > 710 & temp_diameter <= 960
        vel = 1050;
    elseif temp_diameter > 960
        vel = 1010;
    else
        f = msgbox('Cannot find a correct velocity','Error', 'error');
    end
elseif temp_material == 4
    if temp_diameter > 0 & temp_diameter <= 10
        vel = 660;
    elseif temp_diameter > 10 & temp_diameter <= 60
        vel = 540;
    elseif temp_diameter > 60 & temp_diameter <= 160
        vel = 530;
    elseif temp_diameter > 160
        vel = 520;
    else
        f = msgbox('Cannot find a correct velocity','Error', 'error');
    end
elseif temp_material == 5
    if temp_diameter > 0 & temp_diameter <= 10
        vel = 1390;
    elseif temp_diameter > 10 & temp_diameter <= 60
        vel = 1330;
    elseif temp_diameter > 60 & temp_diameter <= 160
        vel = 1200;
    elseif temp_diameter > 160 & temp_diameter <= 260
        vel = 1150;
    elseif temp_diameter > 260 & temp_diameter <= 460
        vel = 1060;
    elseif temp_diameter > 460 & temp_diameter <= 710
        vel = 1020;
    elseif temp_diameter > 710 & temp_diameter <= 860
        vel = 980;
    elseif temp_diameter > 860
        vel = 910;
    else
        f = msgbox('Cannot find a correct velocity','Error', 'error');
    end
elseif temp_material == 6
    if temp_diameter >0 & temp_diameter <= 10
        vel = 1290;
    elseif temp_diameter >10
        vel = 1110;
    else
       f = msgbox('Cannot find a correct velocity','Error', 'error')
    end
end
% --- Executes on button press in isFFT_checkbox.
function isFFT_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to isFFT_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isFFT_checkbox


% --- Executes on button press in fullSignal_checkbox.
function fullSignal_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to fullSignal_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fullSignal_checkbox



function qFactor_edit_Callback(hObject, eventdata, handles)
% hObject    handle to qFactor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qFactor_edit as text
%        str2double(get(hObject,'String')) returns contents of qFactor_edit as a double


% --- Executes during object creation, after setting all properties.
function qFactor_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qFactor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in align_checkbox.
function align_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to align_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of align_checkbox


% --- Executes on button press in align2_checkbox.
function align2_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to align2_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of align2_checkbox



function threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: threshold_edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loop_edit_Callback(hObject, eventdata, handles)
% hObject    handle to loop_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loop_edit as text
%        str2double(get(hObject,'String')) returns contents of loop_edit as a double


% --- Executes during object creation, after setting all properties.
function loop_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loop_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu_material.
function popupmenu_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_material


% --- Executes during object creation, after setting all properties.
function popupmenu_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in FFTbutton.
function FFTbutton_Callback(hObject, eventdata, handles)
figure
ax1 = subplot(2,2,1);
ax2 = subplot(2,2,2);
ax3 = subplot(2,2,3);
ax4 = subplot(2,2,4);
loopPlotAll(handles.yRedFull,handles.yBlueFull,handles.Fs,...
                    ax1,ax2,ax3,ax4,'r','b');
% hObject    handle to FFTbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function binsize_Callback(hObject, eventdata, handles)
% hObject    handle to binsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.bin = str2double(get(hObject,'String'));
h=histogram(handles.leakArr,'BinWidth',handles.bin);
title('Histogram of leak point');
xlabel('Distance(m) from LHS sensor');
ylabel('Frequency(#)');
handles.h = h;
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of binsize as text
%        str2double(get(hObject,'String')) returns contents of binsize as a double


% --- Executes during object creation, after setting all properties.
function binsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to binsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.bin = str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in modeSD_button.
function modeSD_button_Callback(hObject, eventdata, handles)
% hObject    handle to modeSD_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Retrive the varibales
h = handles.h;
binWidth = h.BinWidth;
binLimits = h.BinLimits;
values = h.Values;
temp_length = handles.temp_length;
temp_velocity = handles.temp_velocity;
delayArr = handles.delayArr;

[Max,i] = max(values);
modeRange = [binLimits(1)+(i-1)*binWidth,binLimits(1)+i*binWidth];
modeTime = (modeRange*2-temp_length)/temp_velocity*1000;
result = find(delayArr(:,1)>=modeTime(1)& delayArr(:,1)<=modeTime(2));
delayArr2 = delayArr(result);
modeSD = std(delayArr2);
figure
plot(delayArr2,'-*')
title('Time diff.(delay) with highest Freq. in histogram');
xlabel('number (#)');
ylabel('Time diff.(ms) (LHS-RHS)');
f = msgbox({'Standard deviation of selected delay(ms)';num2str(modeSD)});
