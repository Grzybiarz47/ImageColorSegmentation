clear; clc;

im = double(imread('rose.jpg')) / 255;
imshow(im);
tim = triangulate(im, 3.0, 1.0);
imshow(tim);
