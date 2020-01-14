function disparityImg = blockmatching(leftImage,rightImage,blockSize,maxd)

if length(size(leftImage)) == 3
    % Conversion a escala de grises
    leftImage = rgb2gray(leftImage);
    rightImage = rgb2gray(rightImage);
    
    halfBlock=fix(blockSize/2);
    
    % Inicialización de la imagen de disparidad y numero de iteraciones
    disparityImg = zeros(size(rightImage));
    iterationsI = halfBlock+1:size(leftImage,1)-halfBlock;
    iterationsJ = halfBlock+1:size(leftImage,2)-halfBlock;
    for i = iterationsI
        for j = iterationsJ
            
            % Bloque de la imagen derecha
            rightBlock=rightImage(i-halfBlock:i+halfBlock,j-halfBlock:j+halfBlock);

            blockDiff=[];
            
            % Ventana deslizante y calculo de diferencias entre bloques
            for k=0:min(maxd,size(leftImage,2)-halfBlock-j)
                leftBlock=leftImage(i-halfBlock:i+halfBlock,j-halfBlock+k:j+halfBlock+k);
                blockDiff(k+1, 1) = sum(abs(leftBlock(:) - rightBlock(:)));           
            end
            
            % Busqueda de iteracion con diferencia minima
            [minimum minIndex]=min(blockDiff);
            
            % Asignacion del valor de disparidad
            disparityImg(i, j) = (minIndex-1);
        end
        disp(((i-halfBlock)/(length(iterationsI))) * 100 + "%")
    end
    % Normalización del resultado
    disparityImg = disparityImg./max(disparityImg);
elseif length(size(leftImage)) ~= 3 & length(size(leftImage)) ~= 1
    % Error en caso de obtener imagenes con farmato erroneo
    disp ("Numero de canales en la imagen incorrecto. Solo se aceptan imagenes rgb o en escala de grises");
    disparityImg = zeros(size(rightImage));
end