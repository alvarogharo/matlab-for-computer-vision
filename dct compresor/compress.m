function [compressedImage, compressionRate] = compress(originalImage, gridSize, maskSize)
    originalImage = im2double(originalImage);

    mask = triu(ones(maskSize));
    zero = zeros(gridSize);

    if gridSize >= maskSize
        mask = padarray(rot90(mask),[gridSize-size(mask,1),gridSize-size(mask,1)],0,'post') + zero;
    else
        mask = rot90(mask);
        mask = mask(1:gridSize, 1:gridSize);
    end
    compressionRate = sum(mask(:) == 1)/(gridSize*gridSize);
    disp(sprintf('Compresion rate: %d/%d', sum(mask(:) == 1),gridSize*gridSize));

    dct = @(block) dct2(block.data);
    idct = @(block) idct2(block.data);
    compresion = @(block) block.data .* mask;
    
    finalImage = blockproc(originalImage,[gridSize gridSize],dct);
    finalImage = blockproc(finalImage,[gridSize gridSize],compresion);
    finalImage = blockproc(finalImage,[gridSize gridSize],idct);
    compressedImage = finalImage;
end

