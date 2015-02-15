clear
%% ingest training data
setup;

encoding = 'bovw' ;
category1 = 'airplane' ;
category2 = 'motorbike' ;

labels = zeros(1,400);
for i = 1:400
    if i <= 200
        files{i} = sprintf('251_%04d.jpg', i);
        labels(i) = 1;
        names{i} = category1;
    else
        files{i} = sprintf('145_%04d.jpg',i-200);
        labels(i) = 2;
        names{i} = category2;
    end
    im{i} = im2double(imread(files{i}));
end

perm1 = randperm(400);
tempim=im(perm1); im = tempim;
templab=labels(perm1); labels = templab;
tempfiles=files(perm1); files = tempfiles;
tempnames=names(perm1); names = tempnames;


%% train and implement encoder on training data
enc = trainEncoder(im);

enc_ims = encodeImage(enc,im);
histograms = enc_ims;
histograms = bsxfun(@times, histograms, 1./sqrt(sum(histograms.^2,1))) ;

%% train and evaluate linear svm on training data
C = 10 ;
[w, bias] = trainLinearSVM(histograms, labels, C) ;

% Evaluate the scores on the training data
scores = w' * histograms + bias ;

% Visualize the ranked list of images
figure(1) ; clf ; set(1,'name','Ranked training images (subset)') ;
displayRankedImageList(files, scores)  ;

% Visualize the precision-recall curve
figure(2) ; clf ; set(2,'name','Precision-recall on train data') ;
vl_pr(labels, scores) ;

%% ingest testing data

labels_test = zeros(1,1200);
for i = 1:1200
    if i <= 600
        files_test{i} = sprintf('251_%04d.jpg', i+200);
        labels_test(i) = 1;
        names_test{i} = category1;
    else
        files_test{i} = sprintf('145_%04d.jpg',i-600+200);
        labels_test(i) = 2;
        names_test{i} = category2;
    end
    im_test{i} = im2double(imread(files_test{i}));
end
perm2 = randperm(1200);
tempim=im_test(perm2); im_test = tempim;
templab=labels_test(perm2); labels_test = templab;
tempfiles=files_test(perm2); files_test = tempfiles;
tempnames=names_test(perm2); names_test = tempnames;

%% implement encoder on testing data
enc_ims_test = encodeImage(enc,im_test);
histograms_test = enc_ims_test;
histograms_test = bsxfun(@times, histograms_test, 1./sqrt(sum(histograms_test.^2,1))) ;

%% evaluate linear svm on testing data

testScores = w' * histograms_test + bias ;

% Visualize the ranked list of images
figure(3) ; clf ; set(3,'name','Ranked test images (subset)') ;
displayRankedImageList(files_test, testScores)  ;

% Visualize visual words by relevance on the first image
% [~,best] = max(testScores) ;
% displayRelevantVisualWords(testNames{best},w)

% Visualize the precision-recall curve
figure(4) ; clf ; set(4,'name','Precision-recall on test data') ;
vl_pr(labels_test, testScores) ;

% Print results
[drop,drop,info] = vl_pr(labels_test, testScores) ;
fprintf('Test AP: %.2f\n', info.auc) ;

[drop,perm] = sort(testScores,'descend') ;
fprintf('Correctly retrieved in the top 1200: %d\n', sum(labels_test(perm(1:1200)) > 0)) ;

