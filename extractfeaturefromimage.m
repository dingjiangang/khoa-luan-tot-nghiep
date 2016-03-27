%READCONFIG : extract feature from image
%  @return : return feature ò image
%  'E:\PathData.txt' saving path to image data, cnn model and folder output
%  Auhtor: nhutvm
%  Last modified: 27/03/2016

function feature_test = extractfeaturefromimage(im,net)
    try               
       	if size(im, 3) == 1
         	m = cat(3, im, im, im);
          	pathfilename
        end
       	im_ = single(im) ; % note: 255 range
      	im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
       	im_ = im_ - net.meta.normalization.averageImage;
  	catch me
      	fprintf('\n catch %s');
   	end
    res_test = vl_simplenn(net, im_) ;
   	feat_test = gather(res_test(end-2).x);
   	feature_test(:, 1) = reshape(feat_test, 4096, []);
end