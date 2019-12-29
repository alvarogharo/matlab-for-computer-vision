function blurrer(inputFolder,outputFolder)
images = dir(inputFolder);
filterSizes = [5, 15, 21];
for k=1:length(images)
   image = images(k).name;
   if image ~= "." && image ~= ".."
       path = char(inputFolder + '/' + image);
       im = imread(path);
       filterSize = filterSizes(randi([1, 3], [1,1]));
       imBlurred = imgaussfilt(im,filterSize);
       imwrite(imBlurred, char(outputFolder + "/" + image));
end
end

