clear; clc;

im = double(imread('images/alko.jpg')) / 255;
imshow(im);
tim = triangulate(im, 3.0, 1.0);
imshow(tim);
btim = borders(tim, 2);
imshow(btim);