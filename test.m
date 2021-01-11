[x, y] = generatePoints(300, 300, 2.5, 1.0);

% format of ConnectivityList is three indexes of (x, y) points that make a
% triangle

% trzebaby wyodrebnic kazdy trojkat zeby policzyc jego sredni kolor
% a potem go nim wypelnic

dt = delaunayTriangulation(x, y);
triplot(dt.ConnectivityList, x, y);
