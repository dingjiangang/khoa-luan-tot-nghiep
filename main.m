%READCONFIG : main code to run program
%  @return : return result of classify
%  'E:\PathData.txt' saving path to image data, cnn model and folder output
%  Auhtor: nhutvm
%  Last modified: 27/03/2016

clear all;
clc;

%install config
[data_dir, feat_dir, model_dir,filenamefeatmodel, extstr]=loadConfig();
%Load net
setup;
%run 
%Tinh thoi gian
    t = cputime; 
fprintf('\n net = load(%s)...', filenamefeatmodel);
net = load(fullfile(model_dir,filenamefeatmodel)) ;
vl_simplenn_display(net) ;
fprintf('\n Loading net success ');
%extract feature from folder image data
nfile=extractfeaturefromdata(data_dir,feat_dir,extstr, net);

%trainning data using svm
[trainData,M]=trainDataUsingSVM(nfile,data_dir,feat_dir);
%SVMStruct = svmtrain (trainData, M);
SVMStruct = svmtrain (trainData, M, 'kernel_function', 'linear');
%load image test
%   anh test thuoc lop 1
%imtest=imread('E:\Malab Code\Test\Black_footed_Albatross_0007_2675126617.jpg');
%imtest=imread('E:\Malab Code\Test\Black_footed_Albatross_0031_2445546631.jpg');
%imtest=imread('E:\Malab Code\Test\Black_footed_Albatross_0015_2446377484.jpg');
%   anh test khong thuoc lop 1
%imtest=imread('E:\Malab Code\Test\Sooty_Albatross_0001_389284737.jpg');
%imtest=imread('E:\Malab Code\Test\Sooty_Albatross_0025_2212587920.jpg');
imtest=imread('E:\Malab Code\Test\Sooty_Albatross_0026_2204677331.jpg');

feat_test= extractfeaturefromimage(imtest,net);

%using svm to classify
result = svmclassify(SVMStruct, feat_test');
if result==1
    fprintf('\n Anh thuoc lop 1');
else
    fprintf('\n Anh khong thuoc lop 1');
end
e = cputime-t;
fprintf('\n Thoi gian extrac feature %f s',e)
