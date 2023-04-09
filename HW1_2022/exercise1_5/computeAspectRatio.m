function [aRatio,position] = computeAspectRatio(image)
    [num_rows, num_cols] = size(image);
    % Fill your code
    vector_x = [];
    vector_y = [];
    %image = squeeze(train_C1_images(5,:,:));
    for x = 1:num_rows
        for y =1:num_cols
            if image(x,y)~=0 
                vector_x(end + 1) =  x;
                vector_y(end + 1) =  y;
            end    
        end
    end
    min_x = min(vector_x);
    min_y = min(vector_y);
    max_x = max(vector_x);
    max_y = max(vector_y);
    
    width = max_y - min_y + 1  ;  
    height = max_x - min_x +1 ;
    
    aRatio = width/height;
    position = [(min_y-0.5) (min_x-0.5) width height];
end

