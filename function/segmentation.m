function result = segmentation(filename, threshold)
    im = double(imread(filename))/255;
    tim = triangulate(im, threshold, 1.0);
    result = tim;
end
