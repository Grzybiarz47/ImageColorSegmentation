function res_im = triangulate(im, treshold, borderTresholdShift)
    [height, width, ~] = size(im);
    [yvals, xvals] = generatePoints(height, width, treshold, borderTresholdShift);
    vertices = delaunay(xvals, yvals);

    points = [yvals, xvals];
    labels = zeros(height, width);
    trianglesCount = size(vertices, 1);

    redSums = zeros(trianglesCount, 1);
    greenSums = zeros(trianglesCount, 1);
    blueSums = zeros(trianglesCount, 1);
    counts = zeros(trianglesCount, 1);

    for i = 1:trianglesCount
        [p1, p2, p3] = getTrianglePoints(vertices(i, :), points);
        mins = min([p1;p2;p3], [], 1);
        maxs = max([p1;p2;p3], [], 1);
        minx = mins(1, 1);
        miny = mins(1, 2);
        maxx = maxs(1, 1);
        maxy = maxs(1, 2);

        for x = minx:maxx
            for y = miny:maxy
                if isInTriangle(p1, p2, p3, [x, y])
                    redSums(i) = redSums(i) + im(y, x, 1);
                    greenSums(i) = greenSums(i) + im(y, x, 2);
                    blueSums(i) = blueSums(i) + im(y, x, 3);
                    counts(i) = counts(i) + 1;
                    labels(y, x) = i;
                end
            end
        end
    end

    colors = [redSums./counts, greenSums./counts, blueSums./counts];
    res_im = zeros(height, width, 3);

    for x = 1:width
        for y = 1:height
            index = labels(y, x);
            if index ~= 0
                res_im(y, x, :) = colors(index, :);
            else
                res_im(y, x, :) = res_im(y, x-1, :);
            end    
        end
    end
end



function [p1, p2, p3] = getTrianglePoints(vertices, points)
    p1 = points(vertices(1), :);
    p2 = points(vertices(2), :);
    p3 = points(vertices(3), :);
end

function result = isInTriangle(p1, p2, p3, p)
    p12 = p1-p2;
    p23 = p2-p3;
    p31 = p3-p1;
    result = sign(det([p31;p23]))*sign(det([p3-p;p23])) >= 0 & ...
        sign(det([p12;p31]))*sign(det([p1-p;p31])) >= 0 & ...
        sign(det([p23;p12]))*sign(det([p2-p;p12])) >= 0 ;
end