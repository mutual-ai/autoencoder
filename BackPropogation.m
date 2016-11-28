function [ arrayWeights ] = BackPropogation( arrayWeights,ZArray,ActivatedArray,currentLayer,numberNeurons,inputMatrix)
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here

currentTrainingSample = 0;
deltaValuesList = {};
%Calculate delta for output layer
currentTrainingSample = 1;
deltaWMain = zeros(numberNeurons(currentLayer+1), numberNeurons(currentLayer));
[deltaWMain, deltaValuesList] = BackPropogationLastLayer(currentTrainingSample, arrayWeights,ZArray,ActivatedArray,currentLayer,numberNeurons,inputMatrix,deltaValuesList,deltaWMain);
%disp(deltaWMain);
arrayWeights{currentLayer} = arrayWeights{currentLayer} - (deltaWMain)/10;
currentLayer = currentLayer - 1;

while currentLayer > 0
    deltaWMain = zeros(numberNeurons(currentLayer+1), numberNeurons(currentLayer));
    [deltaWMain, deltaValuesList] = BackPropagationHiddenLayers(currentTrainingSample, arrayWeights,ZArray,ActivatedArray,currentLayer,numberNeurons,inputMatrix,deltaValuesList,deltaWMain);
    arrayWeights{currentLayer} = arrayWeights{currentLayer} - (deltaWMain)/10;
    currentLayer = currentLayer - 1;
end


end

