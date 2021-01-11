% generates random points for triangulation
% uses normal distribution
% borderShift is now much more probable border point is (shifts treshold)

function [x, y] = generatePoints(width, height, treshold, borderShift)
    w_m = randn(height, width, 'single');
    
    % border has higher probability of point occurence
    w_m(:, 1) = w_m(:, 1) + borderShift;
    w_m(:, end) = w_m(:, end) + borderShift;
    w_m(1, :) = w_m(1, :) + borderShift;
    w_m(end, :) = w_m(end, :) + borderShift;
    
    result = zeros(height, width);
    
    % corners are points
    result([1, end], [1, end]) = 1;
    result(w_m > treshold) = 1;
    
    % converts to point coordinates
    [x, y] = find(result);
end
