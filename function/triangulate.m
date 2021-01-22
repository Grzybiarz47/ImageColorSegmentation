function res_im = triangulate(im, treshold, borderTresholdShift, borders)
    [height, width, ~] = size(im);
    [yvals, xvals] = generatePoints(height, width, treshold, borderTresholdShift);
    vertices = delaunay(xvals, yvals);

    points = [yvals, xvals];
    labels = zeros(height, width);
    trianglesCount = size(vertices, 1);

    colors = zeros(trianglesCount, 3);

    for i = 1:trianglesCount
        [p1, p2, p3] = getTrianglePoints(vertices(i, :), points);
        mins = min([p1;p2;p3], [], 1);
        maxs = max([p1;p2;p3], [], 1);
        minx = mins(1, 1);
        miny = mins(1, 2);
        maxx = maxs(1, 1);
        maxy = maxs(1, 2);

        mp = [p1;p2;p3];
        mask = poly2mask(mp(:, 1), mp(:, 2), height, width);
        
        red = im(miny:maxy, minx:maxx, 1);
        green = im(miny:maxy, minx:maxx, 2);
        blue = im(miny:maxy, minx:maxx, 3);
        
        redval = mean(red(mask(miny:maxy, minx:maxx)));
        greenval = mean(green(mask(miny:maxy, minx:maxx)));
        blueval = mean(blue(mask(miny:maxy, minx:maxx)));
        
        colors(i, :) = [redval, greenval, blueval];
       
        for x = minx:maxx
            for y = miny:maxy
                if mask(y, x)
                    labels(y, x) = i;
                end
            end
        end
    end
    
    res_im = zeros(height, width, 3);
    for x = 1:width
        for y = 1:height
            index = labels(y, x);
            if index ~= 0
                res_im(y, x, :) = colors(index, :);
            end
        end
    end

    if borders
        figure('visible','off', 'Position', [0 0 width/2 height/2]);
        imagesc([0 width], [0 height], res_im);
        hold on;
        triplot(vertices, yvals, xvals, 'k');
        set(gca,'XTick',[], 'YTick', []);
        hold off;
        
        exportgraphics(gca, 'fig.png', 'Resolution', 300);
        close all;
        res_im = double(imread('fig.png')) / 255;
    end
end

function [p1, p2, p3] = getTrianglePoints(vertices, points)
    p1 = points(vertices(1), :);
    p2 = points(vertices(2), :);
    p3 = points(vertices(3), :);
end