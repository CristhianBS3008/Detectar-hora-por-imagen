function varargout = EXP2_LAB2(varargin)
% EXP2_LAB2 MATLAB code for EXP2_LAB2.fig
%      EXP2_LAB2, by itself, creates a new EXP2_LAB2 or raises the existing
%      singleton*.
%
%      H = EXP2_LAB2 returns the handle to a new EXP2_LAB2 or the handle to
%      the existing singleton*.
%
%      EXP2_LAB2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXP2_LAB2.M with the given input arguments.
%
%      EXP2_LAB2('Property','Value',...) creates a new EXP2_LAB2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EXP2_LAB2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EXP2_LAB2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EXP2_LAB2

% Last Modified by GUIDE v2.5 04-Nov-2019 10:53:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EXP2_LAB2_OpeningFcn, ...
                   'gui_OutputFcn',  @EXP2_LAB2_OutputFcn, ...
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


% --- Executes just before EXP2_LAB2 is made visible.
function EXP2_LAB2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EXP2_LAB2 (see VARARGIN)

% Choose default command line output for EXP2_LAB2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EXP2_LAB2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EXP2_LAB2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in CAPTURAR.
function CAPTURAR_Callback(hObject, eventdata, handles)
% hObject    handle to CAPTURAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
closepreview;
vid=videoinput('winvideo',4,'YUY2_640x480');
videoRes = get(vid, 'VideoResolution');
numberOfBands = get(vid, 'NumberOfBands');
hImage = image(zeros([videoRes(2), videoRes(1),numberOfBands]));
axes(handles.CAMARA)
preview(vid,hImage)
set(handles.MUESTRA_HORA,'String',"    ");
set(handles.MUESTRA_MINUTO,'String',"     ");
% --- Executes on button press in MOSTRAR.
function MOSTRAR_Callback(hObject, eventdata, handles)
% hObject    handle to MOSTRAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
imagenesr=[];
imagenesg=[];
imagenesb=[];
Xcentros=[];
Ycentros=[];
xtot=[];
ytot=[];

distancias=[];
angulos=[];
%vid=videoinput('winvideo',4,'YUY2_640x480');
%videoRes = get(vid, 'VideoResolution');
%numberOfBands = get(vid, 'NumberOfBands');
%figure(1)
%hImage = image(zeros([videoRes(2), videoRes(1),numberOfBands]));
%preview(vid,hImage)
for i=1:10
    image=getsnapshot(vid);
    imagenesr(:,:,i)=image(:,:,1);
    imagenesg(:,:,i)=image(:,:,2);
    imagenesb(:,:,i)=image(:,:,3);    
end
imager=round((imagenesr(:,:,1)+imagenesr(:,:,2)+imagenesr(:,:,3)+imagenesr(:,:,4)+imagenesr(:,:,5)+imagenesr(:,:,6)+imagenesr(:,:,7)+imagenesr(:,:,8)+imagenesr(:,:,9)+imagenesr(:,:,10))/10);
imageb=round((imagenesb(:,:,1)+imagenesb(:,:,2)+imagenesb(:,:,3)+imagenesb(:,:,4)+imagenesb(:,:,5)+imagenesb(:,:,6)+imagenesb(:,:,7)+imagenesb(:,:,8)+imagenesb(:,:,9)+imagenesb(:,:,10))/10);
imageg=round((imagenesg(:,:,1)+imagenesg(:,:,2)+imagenesg(:,:,3)+imagenesg(:,:,4)+imagenesg(:,:,5)+imagenesg(:,:,6)+imagenesg(:,:,7)+imagenesg(:,:,8)+imagenesg(:,:,9)+imagenesg(:,:,10))/10);
imgprom(:,:,1)=imager;
imgprom(:,:,2)=imageg;
imgprom(:,:,3)=imageb;
%figure(2)
imgprom=uint8(imgprom);
%imshow(imgprom);
%figure(3)
imgprom=ycbcr2rgb(imgprom);
image3=imgprom;
%imshow(imgprom)
%figure(4)
imgprom=im2bw(imgprom,0.45);
%imshow(imgprom)
%figure(5)
for i=1:2
    imgprom=medfilt2(imgprom);
end
%imshow(imgprom)
%figure(6)
imageprom= imfill(imgprom,'holes');
imageprom= imfill(imgprom,'holes');
imageprom= imfill(imgprom,'holes');
imageprom= imfill(imgprom,'holes');

%imshow(imgprom)
% figure(7)
imgprom=not(imgprom);
% imshow(imgprom)
etiquetas = bwlabel(imgprom,4);
objetos = max(max(etiquetas));
for i = 1:objetos
    aux=size(find(etiquetas==i));
    if(aux(1)>1000)
        imgprom(find(etiquetas==i))=0;
    end
end
 %figure(8)
 %imshow(imgprom)
etiquetasR = bwlabel(imgprom,4);
objetosR = max(max(etiquetasR));
imgaux=imgprom;
%imgaux(etiquetasR~=2)=0;
for m = 1:objetosR
     imgaux=imgprom;
     aux1=size(find(etiquetasR==m))
     if(aux1(1)>21)
        imgaux(etiquetasR~=m)=0;
        [M,N] = size(imgaux);
        suma = sum(sum(imgaux));
        Xm = 1:M;
        Ym = 1:N;
        Xm = Xm';
        Ym = Ym';
        Yc_ref = round(sum(imgaux*Ym)/suma);
        Xc_ref = round(sum(imgaux'*Xm)/suma);
     elseif(aux1(1)<20)
        imgaux(etiquetasR~=m)=0;
        [M,N] = size(imgaux);
        suma = sum(sum(imgaux));
        Xm = 1:M;
        Ym = 1:N;
        Xm = Xm';
        Ym = Ym';
        Yc_refe = round(sum(imgaux*Ym)/suma);
        Ycentros=[Ycentros Yc_refe];
        Xc_refe = round(sum(imgaux'*Xm)/suma);
        Xcentros=[Xcentros Xc_refe];    
     end
     imgaux(etiquetasR~=m)=0;
        [M2,N2] = size(imgaux);
        suma2 = sum(sum(imgaux));
        Xm2 = 1:M2;
        Ym2 = 1:N2;
        Xm2 = Xm2';
        Ym2 = Ym2';
        Yt = round(sum(imgaux*Ym2)/suma2);
        Xt = round(sum(imgaux'*Xm2)/suma2);
        xtot=[xtot Xt];
        ytot=[ytot Yt];
end
for b=1:3
    distancia=sqrt((Xc_ref-Xcentros(b))^2 + (Yc_ref-Ycentros(b))^2);
    distancias=[distancias distancia];
end
 for k=1:3
     if (distancias(k)~=min(distancias) && distancias(k)~=max(distancias))
         distancia_minutos=distancias(k);
     end
 end
distancia_horas=min(distancias);
distancia_referencia=max(distancias);
Xc12=Xcentros(find(distancias==max(distancias)));
Yc12=Ycentros(find(distancias==max(distancias)));
for i=1:length(Xcentros)
    if(distancias(i)==max(distancias))
        Xc12=Xcentros(i);
        Yc12=Ycentros(i);
    elseif(distancias(i)==min(distancias))
        Xch=Xcentros(i);
        Ych=Ycentros(i);
    else
        Xcm=Xcentros(i);
        Ycm=Ycentros(i);
    end
end
%Xch=Xcentros(find(distancias==min(distancias)));
%Ych=Ycentros(find(distancias==min(distancias)));

%Xcm=Xcentros(find(distancias~=min(distancias) && distancias~=max(distancias)));
%Ycm=Ycentros(find(distancias~=min(distancias) && distancias~=max(distancias)));
xx_1=Xc12-Xc_ref;
yy_1=Yc12-Yc_ref;
xx_11=Xch-Xc_ref;
yy_11=Ych-Yc_ref;

xx_2=Xc12-Xc_ref;
yy_2=Yc12-Yc_ref;
xx_22=Xcm-Xc_ref;
yy_22=Ycm-Yc_ref;
if (xx_1>0 && yy_1<0 && xx_11>0 && yy_11 > 0 && xx_2>0 && yy_2<0 && xx_22>0 && yy_22 > 0)
    ang1=acos((sum([xx_1 yy_1].*[xx_11 yy_11])/(distancia_referencia*distancia_horas)));
    ang2=acos((sum([xx_2 yy_2].*[xx_22 yy_22])/(distancia_referencia*distancia_minutos)));
    ang1=360-radtodeg(ang1);
    ang2=360-radtodeg(ang2);
else
    ang1=acos((sum([xx_1 yy_1].*[xx_11 yy_11])/(distancia_referencia*distancia_horas)));
    ang2=acos((sum([xx_2 yy_2].*[xx_22 yy_22])/(distancia_referencia*distancia_minutos)));
    ang1=radtodeg(ang1);
    ang2=radtodeg(ang2);
end
hora=round(ang1/30);
minutos=round(ang2/6);

set(handles.MUESTRA_HORA,'String',num2str(hora));
set(handles.MUESTRA_MINUTO,'String',num2str(minutos));

function MUESTRA_HORA_Callback(hObject, eventdata, handles)
% hObject    handle to MUESTRA_HORA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MUESTRA_HORA as text
%        str2double(get(hObject,'String')) returns contents of MUESTRA_HORA as a double


% --- Executes during object creation, after setting all properties.
function MUESTRA_HORA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MUESTRA_HORA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MUESTRA_MINUTO_Callback(hObject, eventdata, handles)
% hObject    handle to MUESTRA_MINUTO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MUESTRA_MINUTO as text
%        str2double(get(hObject,'String')) returns contents of MUESTRA_MINUTO as a double


% --- Executes during object creation, after setting all properties.
function MUESTRA_MINUTO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MUESTRA_MINUTO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
