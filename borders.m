function res_im = borders(im, thickness)
    [height, width, ~] = size(im);
    res_im = im;
    
    for x = 1:thickness
        for i = 1:height
            for j = 1:width
                if i == 1 || i == height || j == 1 || j == width
                    res_im(i, j, :) = 0;
                elseif  ~isequal(res_im(i, j, :), res_im(i, j+1, :))
                    res_im(i, j, :) = 0;
                elseif ~isequal(res_im(i, j, :), res_im(i+1, j, :))
                    res_im(i, j, :) = 0;
                elseif ~isequal(res_im(i, j, :), res_im(i+1, j+1, :))
                    res_im(i, j, :) = 0;
                end
            end
        end
    end
end