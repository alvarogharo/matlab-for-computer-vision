leftI1 = imread('images/leftImage1.png');
rightI1 = imread('images/rightImage1.png');

leftI1 = imresize(leftI1, 0.25);
rightI1 = imresize(rightI1, 0.25);

blockSize=11;
maxd=15;
disp1=blockmatching(leftI1,rightI1,blockSize,maxd);

leftI2 = imread('images/leftImage2.ppm');
rightI2 = imread('images/rightImage2.ppm');

blockSize=11;
maxd=15;
disp2=blockmatching(leftI2,rightI2,blockSize,maxd);

leftI3 = imread('images/leftImage3.png');
rightI3 = imread('images/rightImage3.png');

blockSize=11;
maxd=15;
disp3=blockmatching(leftI3,rightI3,blockSize,maxd);
%%
subplot(3,3,1);
imshow(leftI1);
title("Left image");
subplot(3,3,2);
imshow(rightI1);
title("Right image");
subplot(3,3,3);
imshow(disp1);
title("Disparity");

subplot(3,3,4);
imshow(leftI2);
subplot(3,3,5);
imshow(rightI2);
subplot(3,3,6);
imshow(disp2);

subplot(3,3,7);
imshow(leftI3);
subplot(3,3,8);
imshow(rightI3);
subplot(3,3,9);
imshow(disp3);

