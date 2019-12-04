clear all
close all
clc
imagenesr=[];
imagenesg=[];
imagenesb=[];
Xcentros=[];
Ycentros=[];
xtot=[];
ytot=[];

distancias=[];
angulos=[];
vid=videoinput('winvideo',4,'YUY2_640x480');
videoRes = get(vid, 'VideoResolution');
numberOfBands = get(vid, 'NumberOfBands');
figure(1)
hImage = image(zeros([videoRes(2), videoRes(1),numberOfBands]));
preview(vid,hImage)
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
 figure(8)
 imshow(imgprom)
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
% ang1=acos((sum([Xc12 Yc12].*[Xch Ych])/(distancia_referencia*distancia_horas)));
% ang2=acos((sum([Xc12 Yc12].*[Xcm Ycm])/(distancia_referencia*distancia_minutos)));
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
hora=floor(ang1/30);
minutos=floor(ang2/6);
