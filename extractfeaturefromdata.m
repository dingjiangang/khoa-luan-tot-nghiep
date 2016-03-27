%READCONFIG : read all parameters in text file 
%  extractfeature from folder images.
%  @return : feature of all images in folder
%  'E:\PathData.txt' saving path to image data, cnn model and folder output
%  Auhtor: nhutvm
%  Last modified: 27/03/2016
function nfile = extractfeaturefromdata(data_dir,feat_dir,extstr, net)
    class_dirs = dir(data_dir);
    nclass = length(class_dirs);
    
    nfile=0; % Dem tong so anh co trong thu muc chinh
    for i=3:nclass
    	%Lay ten cua tap tin i
    	class_name = class_dirs(i).name;
    	fprintf('\n %d - %s',i,class_name);

    	class_path = fullfile(data_dir, class_name);
      	feat_dir_i =fullfile(feat_dir, class_name);
       	if ~exist(feat_dir_i, 'dir')
        	mkdir(feat_dir_i);
       	end
        % Load all images
      	img_files = getFileNamesAtPath(class_path, extstr);
      	nimg = length(img_files) ;
       	if nimg==0
       	error('\n Thu muc khong co anh: %s', class_path);
        end
        nfile=nfile+nimg; % Cap nhat so luong anh moi khi quet mot thu muc con
      	num_images_per_class = nimg;
        for ii=1:nimg
         	feat_file = fullfile(feat_dir_i, [img_files{ii} '.mat']);
            if exist(feat_file, 'file')
                continue;
            end
            pathfilename =fullfile(class_path, img_files{ii});
            try               
                im = imread(pathfilename);
                if size(im, 3) == 1
                    m = cat(3, im, im, im);
                    pathfilename
                end
                im_ = single(im) ; % note: 255 range
                im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
                im_ = im_ - net.meta.normalization.averageImage;
            catch me
                fprintf('\n catch %s', pathfilename);
            end
            % run the CNN
            feature = zeros(4096,1);
            res = vl_simplenn(net, im_) ;
            feat = gather(res(end-2).x);
            feature(:, 1) = reshape(feat, 4096, []);
            if ~exist(feat_file, 'file')
                fprintf('\n Saving %s ', feat_file);
                save(feat_file, 'feature', '-v7.3');
            end 
        end 
    end

end

% load images from path folder
function ims = getFileNamesAtPath(pathloc, extstr)
    dirlisting_all = dir(pathloc);
    % remove '.' and '..' items from directory listing
    dirlisting_all(arrayfun(@(x)(strcmp(x.name,'.')),dirlisting_all)) = [];
    dirlisting_all(arrayfun(@(x)(strcmp(x.name,'..')),dirlisting_all)) = []; 
    dirlisting = arrayfun(@(x)~isempty(regexpi(x.name,extstr)),dirlisting_all);
    ims = arrayfun(@(x)(x.name),dirlisting_all(dirlisting),'UniformOutput',false);
end