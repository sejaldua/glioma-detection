function varargout = errorAnalysisGUI(varargin)
% ERRORANALYSISGUI MATLAB code for errorAnalysisGUI.fig
%      ERRORANALYSISGUI, by itself, creates a new ERRORANALYSISGUI or raises the existing
%      singleton*.
%
%      H = ERRORANALYSISGUI returns the handle to a new ERRORANALYSISGUI or the handle to
%      the existing singleton*.
%
%      ERRORANALYSISGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ERRORANALYSISGUI.M with the given input arguments.
%
%      ERRORANALYSISGUI('Property','Value',...) creates a new ERRORANALYSISGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before errorAnalysisGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to errorAnalysisGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help errorAnalysisGUI

% Last Modified by GUIDE v2.5 10-May-2018 18:51:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @errorAnalysisGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @errorAnalysisGUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT



% --- Executes just before errorAnalysisGUI is made visible.
function errorAnalysisGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to errorAnalysisGUI (see VARARGIN)

% Choose default command line output for errorAnalysisGUI
handles.output = hObject;
handles.counter = 0;
handles.counter1 = 0;
handles.counter2 = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes errorAnalysisGUI wait for user response (see UIRESUME)

% --- Outputs from this function are returned to the command line.
function varargout = errorAnalysisGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function checkbox2_Callback(hObject, eventdata, handles)

function checkbox3_Callback(hObject, eventdata, handles)

function checkbox4_Callback(hObject, eventdata, handles)

function checkbox5_Callback(hObject, eventdata, handles)

function checkbox6_Callback(hObject, eventdata, handles)

function checkbox7_Callback(hObject, eventdata, handles)

function checkbox8_Callback(hObject, eventdata, handles)

function checkbox9_Callback(hObject, eventdata, handles)

function checkbox10_Callback(hObject, eventdata, handles)

function checkbox11_Callback(hObject, eventdata, handles)

function checkbox12_Callback(hObject, eventdata, handles)

function checkbox13_Callback(hObject, eventdata, handles)

function checkbox14_Callback(hObject, eventdata, handles)

function checkbox15_Callback(hObject, eventdata, handles)

function checkbox16_Callback(hObject, eventdata, handles)

function pushbutton1_Callback(hObject, eventdata, handles)

    hCheckboxes = [handles.checkbox2 ; handles.checkbox3 ; handles.checkbox4 ; ....
        handles.checkbox5 ; handles.checkbox6 ; handles.checkbox7 ; ....
        handles.checkbox8 ; handles.checkbox9 ; handles.checkbox10 ; ....
        handles.checkbox11 ; handles.checkbox12 ; handles.checkbox13 ; ....
        handles.checkbox14 ; handles.checkbox15 ; handles.checkbox16];
    checkboxValues = get(hCheckboxes, 'Value');
    assignin('base', 'checkboxValues', checkboxValues);
    customErrorAnalysis(checkboxValues);
    handles.counter = handles.counter + 1;


function pushbutton2_Callback(hObject, eventdata, handles)    
    load('guiPlotting.mat', 'PCpct', 'MCpct', 'FApct', 'thresholds');
    axes(handles.axes1)
    plot(thresholds, PCpct, 'b')
    hold on;
    plot(thresholds, MCpct, 'r')
    plot(thresholds, FApct, 'g');
    hold off;
    title('Performance Analysis of Logistic Regression Classifier');
    xlabel('Density Threshold');
    ylabel('Classification Rates');
    legend('Perfect Classification', 'Missed Classification', 'False Alarm',  'Location', 'northwest');
    handles.counter1 = handles.counter1 + 1;
    if (handles.counter1 == 1)
        set(handles.pushbutton2,'String','Update Graph');
    end

function pushbutton3_Callback(hObject, eventdata, handles)
    load('guiPlotting.mat', 'PI', 'sens', 'spec', 'accuracy', 'thresholds');
    axes(handles.axes2)
    plot(thresholds, PI, 'b');
    hold on;
    plot(thresholds, sens, 'g');
    plot(thresholds, spec, 'r');
    plot(thresholds, accuracy, 'k');
    hold off;
    title('Performance Analysis of Logistic Regression Classifier');
    xlabel('Density Threshold');
    ylabel('Performance Analysis Statistics');
    legend('Performance Index', 'Sensitivity', 'Specificity', 'Accuracy',  'Location', 'northwest');
    handles.counter2 = handles.counter2 + 1;
    if (handles.counter2 == 1)
        set(handles.pushbutton3,'String','Update Graph');
    end
    
