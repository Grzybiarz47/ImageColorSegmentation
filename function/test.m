clear; clc;

 im = double(imread('images/rose.jpg')) / 255;
 tim = triangulate(im, 3.0, 1.0, true);
 imshow(tim);
