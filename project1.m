imagefiles = dir('E:\\ASU\\Fall 2016\\FSL\\Project\\TrainImages\\*.pgm');      
nfiles = length(imagefiles);    % Number of files found

counter = 0;
%create 1024*10 matrix
initial = [];

currentLayerNeurons = 1024;
nextLayerNeurons = 512;

currentLayer=0;
numHiddenLayer = 1;


numberNeurons =[1024,512,1024];


%Matrix arrays
arrayWeights={};

layersArrayCounter = 2;
ZArray = {};
ActivatedArray = {};

% 1000 examples , 512 * 1024
%weight=[]
%weight = NormalizedWeight(currentLayerNeurons,nextLayerNeurons);


currentLayer = currentLayer+1;
%arrayWeights{currentLayer} =weight;



for epoch=1:100
for ii=1:nfiles
   currentfilename = [imagefiles(ii).folder '/' imagefiles(ii).name];
   currentimage = imread(currentfilename);
   B = reshape(currentimage,1024,1);
   initial = [initial B];
   images{ii} = B;
   counter  =counter +1;
   
   if mod(counter,10) == 0
       %Feed Forward
       input = initial;
       % numTotalLayer does not include the first layer input.
       numTotalLayers = numHiddenLayer + 1;
       ActivatedArray{currentLayer} = initial;
       for Layer=1:numTotalLayers
           images{ii} = currentimage;
           currentLayerNeurons = numberNeurons(Layer);
           nextLayerNeurons = numberNeurons(Layer + 1);
           weight = NormalizedWeight(currentLayerNeurons,nextLayerNeurons);
           arrayWeights{currentLayer} =  weight;
           ZMatrix = createLayer(input,weight);
           ZArray{currentLayer+1}=ZMatrix;
           ActivatedMatrix = ActivationFunction(ZMatrix);           
           ActivatedArray{currentLayer+1}= ActivatedMatrix;
           input = ActivatedMatrix;
           currentLayer = currentLayer+1;
       end
       
       currentLayer = currentLayer -1;
       
       %disp('CL')
       %disp(currentLayer)

       % Back propogation
       [arrayWeights] = BackPropogation(arrayWeights,ZArray,ActivatedArray,currentLayer,numberNeurons,initial);       
        initial=[];
        currentLayer = 1;
   end
end
    currentLayer = 1;
    for Layer=1:numTotalLayers
           input = images{1};
           currentLayerNeurons = numberNeurons(Layer);
           nextLayerNeurons = numberNeurons(Layer + 1);
           weight = arrayWeights{currentLayer};
           ZMatrix = createLayer(input,weight);
           ZArray{currentLayer+1}=ZMatrix;
           ActivatedMatrix = ActivationFunction(ZMatrix);           
           ActivatedArray{currentLayer+1}= ActivatedMatrix;
           input = ActivatedMatrix;
           currentLayer = currentLayer+1;
    end
    output = input;
    RMSE = sqrt(output-input)
end



