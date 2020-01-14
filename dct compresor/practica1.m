clc;
im =  imread('lena_bw.png');
gridSize = 8;

for n = (1:((gridSize*2)-1))
    [image, compressionRate] = compress(im, gridSize, n);
    subplot(gridSize/2,gridSize/2,n);
    imshow(image);
    title("CR: " + num2str(compressionRate));
end
