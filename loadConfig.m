%READCONFIG : install path folder images, feature and cnn models in text file 
%  @return : Load all neccesary parameter  for Instance Search from config
%  'E:\PathData.txt' saving path to image data, cnn model and folder output
%  Auhtor: nhutvm
%  Last modified: 27/03/2016
function [data_dir, feat_dir, model_dir, filenamefeatmodel, extstr] = loadConfig()
    fileID = fopen('PathData.txt');
    C = textscan(fileID,'%s','Delimiter', '', 'CommentStyle', '%')
    fclose(fileID);
    cellfun(@eval, C{1});
    %Duong dan den thu muc anh
    data_dir = data;
    %caltech_dir ='E:\practical-cnn-2015a\Dataset\Images'
    %Duong dan den thu muc chua mo hinh CNN
    model_dir = model;
    % Lua chon CNN
    numfeature=input('Nhap loai feature (1: CNN-F, 2: CNN-S, 3:verydeep16, 4:verydeep19):');
    %numfeature=1;  
    if numfeature==1
        strFeature = 'CNNF';
        filenamefeatmodel = 'imagenet-vgg-f.mat';
    elseif numfeature==2
        strFeature = 'CNNS';
        filenamefeatmodel = 'imagenet-vgg-s.mat';
    elseif numfeature==3
        strFeature = 'DeepNet16';
        filenamefeatmodel = 'imagenet-vgg-verydeep-16.mat';
    elseif numfeature==4
        strFeature = 'DeepNet19';
        filenamefeatmodel = 'imagenet-vgg-verydeep-19.mat';
    else
        filenamefeatmodel='null';
        error('Chua xu ly');
    end
    %Duong dan den thu muc luu cac feature
    feat_dir = output;
    feat_dir = fullfile(feat_dir, strFeature);
    fprintf('\n Creating dir %s', feat_dir);
    % create feature folder
    if ~exist(feat_dir, 'dir')
        mkdir(feat_dir);
    end
    extstr = imageformat;
    fprintf('\n Thiet lap thanh cong'); 
end