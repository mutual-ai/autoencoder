function [ neuralNet] = sigmoid(neuralNet)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

neuralNet = double(1.0) ./ ( double(1.0) + double(exp(-neuralNet)) );

end

