function blurdetection(inputFolder)
images = dir(inputFolder);
threshold = 10;
for k=1:length(images)
   image = images(k).name;
   if image ~= "." && image ~= ".."
       path = char(inputFolder + '/' + image);
       im = imread(path);
       filter = fspecial('laplacian');
       imFiltered = imfilter(im, filter);
       imFiltered = im2double(rgb2gray(imFiltered));
       variance = var(imFiltered);
       variance = mat2gray(variance);
       meanVariance = mean(variance) * 100;
       subplot(1,1,1);
       imshow(im);
       if meanVariance <= threshold
           text(30,30,'Enfocada. Varianza media normalizada: ','Color','blue','FontSize',24);
           text(30,100,num2str(meanVariance),'Color','blue','FontSize',24);
       else if meanVariance > threshold
           text(30,30,'Desenfocada. Varianza media normalizada: ','Color','red','FontSize',24); 
           text(30,100,num2str(meanVariance),'Color','red','FontSize',24);
           end
       end
       w = waitforbuttonpress;
end
end

