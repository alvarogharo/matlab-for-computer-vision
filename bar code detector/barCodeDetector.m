function barCodeDetector(inputImagePath)
gradThres = 200 / 255;
im = imread(inputImagePath);
resizedImage = imresize(im,0.25);
grayIm = rgb2gray(resizedImage);
gMod = imgradient(im2double(grayIm));
kernel = ones(3) ./ 9;
gModMask = imfilter(gMod, kernel);
thresMask = gModMask > gradThres;
closeFilter = strel('rectangle',[21 7]);
closedMask = imclose(thresMask, closeFilter);
erodeFilter = strel('rectangle',[3 3]);
procesedMask = imerode(closedMask, erodeFilter);
procesedMask = imerode(procesedMask, erodeFilter);
procesedMask = imerode(procesedMask, erodeFilter);
procesedMask = imerode(procesedMask, erodeFilter);
procesedMask = imdilate(procesedMask, erodeFilter);
procesedMask = imdilate(procesedMask, erodeFilter);
procesedMask = imdilate(procesedMask, erodeFilter);
procesedMask = imdilate(procesedMask, erodeFilter);
stats = regionprops('table', procesedMask, 'Area', 'BoundingBox');
statsMat = table2array(stats);
[M,I] = max(statsMat(:,1));
bBox = [statsMat(I,2), statsMat(I,3), statsMat(I,4), statsMat(I,5)];
imshow(resizedImage);
hold on;
rectangle('Position',bBox, 'EdgeColor', 'yellow', 'LineWidth', 4);
end