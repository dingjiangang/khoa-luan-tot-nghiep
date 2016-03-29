%READCONFIG : trainninng data from data image using svm model
%  @return : return svm struct
%  'E:\PathData.txt' saving path to image data, cnn model and folder output
%  Auhtor: nhutvm
%  Last modified: 27/03/2016

function [trainData, M] = trainDataUsingSVM(nfile,data_dir,feat_dir)
    class_dirs = dir(data_dir);
    nclass = length(class_dirs); 
    
    trainData = zeros(nfile, 4096);
    k=0; % luu tung anh vao phan tu k cua ma tran traiData
    for i=3:nclass
        class_name = class_dirs(i).name;
    	class_path = fullfile(data_dir, class_name);
        im_in_class = dir(class_path);
        nimage = length(im_in_class);
        for ii=3:nimage
            k=k+1;
            temp=load(fullfile(feat_dir,class_name,[im_in_class(ii).name '.mat']));
            trainData(k,:)=temp.feature';
        end           
    end
    nclassify=fullfile(data_dir,class_dirs(3).name);
    nM=length(nclassify)-2;
    M=[ones(1,nM) zeros(1,k-nM)];
    
end