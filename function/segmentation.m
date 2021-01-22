function result = segmentation(filename, threshold, borders)
    im = double(imread(filename))/255;
    tim = triangulate(im, threshold, 1.0, borders);
    result = tim;
end
