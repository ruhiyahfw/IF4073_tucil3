% RGB = imread("../img/banana.png");
% I = rgb2gray(RGB);
% imwrite(I, "../img/banana-1-gray.bmp");

if true
  a=imread("../img/banana.png");
  figure(1),imshow(a);
  im=rgb2gray(a);
  figure(2),imshow(im);
  im= imadjust(im);
  %filtering for removing artifacts..
  im=medfilt2(im);
  figure(3),imshow(im);
  %DullRazor technique for hair removal
  se = strel('disk',5);
  hairs = imbothat(im,se);
  BW = hairs > 15;
  BW2 = imdilate(BW,strel('disk',2));
  replacedImage = roifill(im,BW2);
  figure(4),imshow(replacedImage);
  %thresholding ....
  level=graythresh(replacedImage);
  a=im2bw(replacedImage,level);
  figure(5),imshow(a);
  %hole fills...
  %a=imfill(a,'holes');
  %figure(4),imshow(a);
  %counting objects...(1st approach)
  cc = bwconncomp(a,4);
  number  = cc.NumObjects;
  display(number);
  %counting objects...(2nd approach)
  s  = regionprops(a, 'Area');
  N_objects = numel(s);
  display(N_objects);
  %display the object area
  for i=1:N_objects
     display(s(i).Area);
  end  
  %closing operation..
  se = strel('disk',5);
  closeBW = imclose(a,se);
  figure(6), imshow(closeBW);
  %counting objects after closing operation...
  cc = bwconncomp(closeBW,4);
  number  = cc.NumObjects;
  display(number);
  %counting objects after closing operation...
  s  = regionprops(closeBW, 'Area');
  N_objects = numel(s);
  display(N_objects);
  %display the object area after closing
  for i=1:N_objects
     display(s(i).Area);
  end 
  %selecting the biggest region ..
  I=bwareaopen(closeBW,s(1).Area);
  figure(7),imshow(I);
  s  = regionprops(I, 'Area');
  N_objects = numel(s);
  display(N_objects);
end