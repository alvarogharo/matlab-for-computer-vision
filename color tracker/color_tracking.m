function color_tracking(inputFolder,upperThres,lowerThres)
images = dir(inputFolder);
for k=1:length(images)
   image = images(k).name;
   upper = upperThres ./ 255;
   lower = lowerThres ./ 255;
   areaThres = 600;
   if image ~= "." && image ~= ".."
       path = char(inputFolder + '/' + image);
       im = imread(path);
       imBlurred = imgaussfilt(im,1);
       imBlurredHSV = rgb2hsv(imBlurred);
       hMask = imBlurredHSV(:,:,1);
       hMask = bitand(hMask <= upper(1), hMask > lower(1));
       sMask = imBlurredHSV(:,:,2);
       sMask = bitand(sMask <= upper(2),sMask > lower(2));
       vMask = imBlurredHSV(:,:,3);
       vMask = bitand(vMask <= upper(3),vMask > lower(3));
       finalMask = bitand(hMask, sMask);
       finalMask = bitand(finalMask, vMask);
       erodeFilter = strel('rectangle',[3 3]);
       procesedMask = imerode(finalMask, erodeFilter);
       procesedMask = imerode(procesedMask, erodeFilter);
       procesedMask = imdilate(procesedMask, erodeFilter);
       procesedMask = imdilate(procesedMask, erodeFilter);
       stats = regionprops('table', procesedMask, 'Area', 'Centroid', 'BoundingBox');
       statsMat = table2array(stats);
       [M,I] = max(statsMat(:,1));
       centroid = [statsMat(I,2), statsMat(I,3)];
       bBox = [statsMat(I,4), statsMat(I,5), statsMat(I,6), statsMat(I,7)];
       imshow(im);
       hold on;
       if M > areaThres
           rectangle('Position',bBox, 'EdgeColor', 'yellow', 'LineWidth', 4);
           viscircles(centroid,2,'Color','red', 'LineWidth', 10);
       end
       pause(0.033);
end
end

