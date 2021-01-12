% generates random points for triangulation
% uses normal distribution
% borderTresholdShift is how much more probable border point is

function [x, y] = generatePoints(width, height, treshold, borderTresholdShift)
    w_m = randn(height, width, 'single');
    
    % border has higher probability of point occurence
    w_m(:, 1) = w_m(:, 1) + borderTresholdShift;
    w_m(:, end) = w_m(:, end) + borderTresholdShift;
    w_m(1, :) = w_m(1, :) + borderTresholdShift;
    w_m(end, :) = w_m(end, :) + borderTresholdShift;
    
    result = zeros(height, width);
    
    % corners are points
    result([1, end], [1, end]) = 1;
    result(w_m > treshold) = 1;
    
    % converts to point coordinates
    [x, y] = find(result);
end
