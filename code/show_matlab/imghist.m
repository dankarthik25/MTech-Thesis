% % function imghist
% [y_red,x_red]     = imhist(img(:,:,1));
% [y_green,x_green] = imhist(img(:,:,2));
% [y_blue,x_blue]   = imhist(img(:,:,3));
I = img1;
height = 128;
%RGBHIST   Histogram of RGB values.

nBins = 256;

rHist = imhist(I(:,:,1), nBins);
gHist = imhist(I(:,:,2), nBins);
bHist = imhist(I(:,:,3), nBins);

max_v = max([rHist ;gHist;bHist]);

result = zeros(height,nBins,3);
% for red
for b = 1:nBins
  h1 = uint8(height*rHist(b)/max_v );
    if(h1>0)
        result(height-h1+1:height,b,1) =  b-1;
    end
    h2 = uint8(height*gHist(b)/max_v );
    if(h1>0)
        result(height-h2+1:height,b,2) =  b-1;
    end
    h3 = uint8(height*bHist(b)/max_v );
    if(h3>0)
        result(height-h3+1:height,b,3) =  b-1;
    end
    if(h1>=h2)
        if(h1>=h3)
            h_max = h1;
        else
            h_max = h3;
        end
    else
        if(h2>=h3)
            h_max = h2;
        else
            h_max = h3;
        end
    end
    result(1:height-h_max,b,:)=200;
end
figure(02);
imshow(uint8(result));

% 
% hFig = figure;
% h(1) = stem(1:256, rHist);
% h(2) = stem(1:256 + 1/3, gHist);
% h(3) = stem(1:256 + 2/3, bHist);
% 
% set(h, 'marker', 'none')
% set(h(1), 'color', [1 0 0])
% set(h(2), 'color', [0 1 0])
% set(h(3), 'color', [0 0 1])