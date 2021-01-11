function result = segmentation(filename)
% Przykładowa funkcja 
% jeszcze nie wiem w sumie jak rozdzielimy obliczenia
    image = double(imread(filename))/255;
    image = rgb2gray(image);
    result = image;
end
