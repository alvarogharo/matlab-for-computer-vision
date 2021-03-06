clc;
im =  imread('lena_bw.png');
gridSize = 8;

%% Mostrando algunos de los posibles valores de la mascara de compresion

plot = 1;
for n = (1:2:((gridSize*2)-1))
    [image, compressionRate] = compress(im, gridSize, n);
    subplot(2,4,plot);
    imshow(image);
    title("CR: " + num2str(compressionRate));
    plot = plot+1;
end

%% % Mostrando todos los posibles valores de la mascara de compresion

plot = 1;
for n = (1:((gridSize*2)-1))
    [image, compressionRate] = compress(im, gridSize, n);
    subplot(3,5,plot);
    imshow(image);
    title("CR: " + num2str(compressionRate));
    plot = plot+1;
end
