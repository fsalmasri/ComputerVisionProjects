function [localExtrema] = DetectLocalExtrema(pyramid)
%     THRESHOLD = 
    localExtrema = {};
    count = 0;
    for octaveNum=1:size(pyramid,2)     % Iterate through the octaves
        for scaleNum=1:size(pyramid{1},2)-2  % Iterate through the scales
            [h,w] = size(pyramid{octaveNum}{scaleNum});
            for row=2:h-1    % Iterate through rows
                for col=2:w-1   % Iterate through cols
                    count = count + 1;
                    temp = CompareNeighbors(pyramid, octaveNum, scaleNum, row, col);
                    if ~isempty(temp)
                        localExtrema(end+1) = temp;
                    end
                end
            end
        end
    end 
    count
end

% Compares the neighbors for all the pixels
function [localExtrema] = CompareNeighbors(pyramid, octaveNum, scaleNum, row, col)
    % Compare the 26 neighbors
    for i=-1:1:1
        for j=-1:1:1
            for k=0:2
                if pyramid{octaveNum}{scaleNum+1}(row,col) < ...
                    pyramid{octaveNum}{scaleNum+k}(row+i,col+j)
                    localExtrema = {};
                    return;
                end
            end
        end
    end
    localExtrema = {[row,col]};
    
end
