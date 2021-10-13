function varargout = Fruit_Detection_System(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fruit_Detection_System_OpeningFcn, ...
                   'gui_OutputFcn',  @Fruit_Detection_System_OutputFcn, ...
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




% --- Executes just before Fruit_Detection_System is made visible.
function Fruit_Detection_System_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fruit_Detection_System (see VARARGIN)



% axes(handles.axes3);
% imshow('photo2.jpg');


% Choose default command line output for Fruit_Detection_System
handles.output = hObject;

% Update handles structure

guidata(hObject, handles);

% UIWAIT makes Fruit_Detection_System wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fruit_Detection_System_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[a, b] = uigetfile('*.jpg');
x1 = strcat(b, a);
x1 = imread(x1);
axes(handles.axes4);
imshow(x1);
handles.x1 = x1;

% Update handles structure

guidata(hObject, handles);

set(handles.status_size, 'String', '-');
set(handles.status_size, 'Background', 'white');
set(handles.status_size, 'Foreground', 'black');

set(handles.status_quality, 'String', '-');
set(handles.status_quality, 'Background', 'white');
set(handles.status_quality, 'Foreground', 'black');

set(handles.status_color, 'String', '-');
set(handles.status_color, 'Background', 'white');
set(handles.status_color, 'Foreground', 'black');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%imshow('photo2.jpg');


% --- Executes on button press in pushbutton3 color detect part.....


%...Praveen...
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = handles.x1;

gray_x = rgb2gray(x);%convert image to grayscale
 
red = x( : , : , 1);%extract red & green plane
green = x( : , : , 2);
 
object =red;%object is result of the color detect part

 if object == green;
     
     sub_obj = imsubtract(object, gray_x);
     graythresh_level = 0.03;%Thresholding part
     sub_objbw = im2bw (sub_obj,graythresh_level);  
     
 else
     
     object = green;   
     sub_obj = imsubtract(object, gray_x);
     graythresh_level = 0.03;%Thresholding part
     sub_objbw = im2bw (sub_obj,graythresh_level); 
     
 end
 
clean_img = bwareaopen(sub_objbw, 1000);%Avoid the small objects
BW_filled=imfill(clean_img,'holes');
axes(handles.axes7);%This axes use to plot the outputs
imshow(gray_x); pause(0.5);
imshow(object); pause(0.5);

if object == red;
    imshow(sub_obj); pause(0.5);
    imshow(sub_objbw); pause(0.5);
else
    imshow(sub_obj); pause(0.5);
    imshow(sub_objbw); pause(0.5);
end

imshow(clean_img); pause(0.2);
imshow(BW_filled); pause(0.2);

area = bwarea(BW_filled);%Calculate the area of the bounded image
Rounded_Area = round(area);%Round the area value

BW1 = edge(BW_filled,'Canny');%This 'Canny' method uses two thresholds to detect strong and weak edges,
%including weak edges in the output if they are connected to strong edges
imshow(BW1); pause(0.2);

if object == red;
    imshow(BW1); title('Bounded Image-Size Detected!');
    map = [0 0 0;1 0 0]; % Using red color to map
    colormap(map);
else
    imshow(BW1); title('Bounded Image-Size Detected!');
    map = [0 0 0;0 1 0]; %Using green color to map
    colormap(map);
end

%Static Text Update conditions
if object == red
    if Rounded_Area >= 20000
        set(handles.status_size, 'String', 'Large');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif Rounded_Area >= 15000
        set(handles.status_size, 'String', 'Medium');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif Rounded_Area >= 9500
        set(handles.status_size, 'String', 'Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    else
        set(handles.status_size, 'String', 'Too Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    end 
else   
    if Rounded_Area >= 17000
        set(handles.status_size, 'String', 'Large');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif Rounded_Area >= 13000
        set(handles.status_size, 'String', 'Medium');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif Rounded_Area >= 9500
        set(handles.status_size, 'String', 'Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    else
        set(handles.status_size, 'String', 'Too Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    end     
end

%========== MAHELA CODE  



%======== 
if object == red
    if Rounded_Area >= 20000
        set(handles.Statustext3, 'String', 'Pass');
        set(handles.Statustext3, 'Background', [0.275 0.424 1.0]);
        set(handles.Statustext3, 'Foreground', 'white');
        
    elseif Rounded_Area >= 15000
        set(handles.Statustext3, 'String', 'Pass');
        set(handles.Statustext3, 'Background', [0.275 0.424 1.0]);
        set(handles.Statustext3, 'Foreground', 'white');
        
    elseif Rounded_Area >= 9500
        set(handles.Statustext3, 'String', 'Pass');
        set(handles.Statustext3, 'Background', [0.275 0.424 1.0]);
        set(handles.Statustext3, 'Foreground', 'white');
        
    else 
        set(handles.Statustext3, 'String', 'Fail');
        set(handles.Statustext3, 'Background', [1.0 0.0 0.0]);
        set(handles.Statustext3, 'Foreground', 'white');
    end 
    
else   
    if Rounded_Area >= 17000
        set(handles.Statustext3, 'String', 'Pass');
        set(handles.Statustext3, 'Background', [0.275 0.424 1.0]);
        set(handles.Statustext3, 'Foreground', 'white');
        
    elseif Rounded_Area >= 13000
        set(handles.Statustext3, 'String', 'Pass');
        set(handles.Statustext3, 'Background', [0.275 0.424 1.0]);
        set(handles.Statustext3, 'Foreground', 'white');
        
    elseif Rounded_Area >= 9500
        set(handles.Statustext3, 'String', 'Pass');
        set(handles.Statustext3, 'Background', [0.275 0.424 1.0]);
        set(handles.Statustext3, 'Foreground', 'white');
        
    else
        set(handles.Statustext3, 'String', 'Fail');
        set(handles.Statustext3, 'Background',[1.0 0.0 0.0]);
        set(handles.Statustext3, 'Foreground', 'white');
        
    end     
end



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y = handles.x1;

axes(handles.axes5);
%
GRAY_SCALE_IMAGE = rgb2gray(y);                    %convert rgb image to gray scale image
%
DISK_MASK = strel('disk',5);                       %create a disk type filter;
%
MASKED_IMAGE = imerode(GRAY_SCALE_IMAGE,DISK_MASK);%add mask
%
BLACK_AND_WHITE = MASKED_IMAGE < 85;              %convert gray scale image to black and white image
%
imshow(y);
pause(0.5);
%
imshow(GRAY_SCALE_IMAGE);
pause(0.5);
%
imshow(MASKED_IMAGE);
pause(0.5);
%
imshow(BLACK_AND_WHITE);
pause(0.5);
%
imshow(y);
pause(0.5);
title('Surface Detected!');

[a b] = bwlabel(BLACK_AND_WHITE);                   %count number of objects
C = b - 1;
  
if C <= 2
    set(handles.status_quality, 'String', 'Good!');
    set(handles.status_size, 'Background', [0.275 0.424 1.0]);
    set(handles.status_size, 'Foreground', 'white');          
      
else
    set(handles.status_quality, 'String', 'Damaged!');
    set(handles.status_size, 'Background', [0.275 0.424 1.0]);
    set(handles.status_size, 'Foreground', 'white'); 
   % msgbox('Damaged Fruit Detected! ')
    pause(0.2);
    %closereq();


end

%%%%%%%%%%%%%%% Mahela %%%%%%%%%%%%%%%%%%%%%%%%%%
if C <= 2
    set(handles.Statustext1, 'String', 'Pass');
    set(handles.Statustext1, 'Background', [0.275 0.424 1.0]);
    set(handles.Statustext1, 'Foreground', 'white');         
      
else
    set(handles.Statustext1, 'String', 'Fail');
    set(handles.Statustext1, 'Background', [0.275 0.424 1.0]);
    set(handles.Statustext1, 'Foreground', 'white'); 
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Statustext1_Callback(hObject, eventdata, handles)
% hObject    handle to Statustext1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Statustext1 as text
%        str2double(get(hObject,'String')) returns contents of Statustext1 as a double


% --- Executes during object creation, after setting all properties.
function Statustext1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Statustext1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Statustext3_Callback(hObject, eventdata, handles)
% hObject    handle to Statustext3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Statustext3 as text
%        str2double(get(hObject,'String')) returns contents of Statustext3 as a double


% --- Executes during object creation, after setting all properties.
function Statustext3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Statustext3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function axes3_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq(); 
Fruit_Detection_System;
