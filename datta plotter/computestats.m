detection = readtable('./data/detection.csv');
groundTruth = readtable('./data/groundtruth.csv');
% -50 = NAN values
ranges = [-50 0 50 100 150 200 250];

area2DNANsize = size(detection.Area2D(1:end,:));

area2Ddetection = detection.Area2D(1:end,:);
area2Ddetection = cellfun(@str2num,area2Ddetection,'un',0);
area2Ddetection = cell2mat(area2Ddetection);

area2Dsize = size(area2Ddetection);
area2DNAN = area2DNANsize(1) - area2Dsize(1);

area2DgroundTruth = groundTruth.Area2D(1:end,:);
area2DgroundTruth = cellfun(@str2num,area2DgroundTruth,'un',0);
area2DgroundTruth = cell2mat(area2DgroundTruth);

area2D = abs(area2Ddetection - area2DgroundTruth);

area3DNANsize = size(detection.Area3D(1:end,:));

area3Ddetection = detection.Area3D(1:end,:);
area3Ddetection = cellfun(@str2num,area3Ddetection,'un',0);
area3Ddetection = cell2mat(area3Ddetection);

area3Dsize = size(area3Ddetection);
area3DNAN = area3DNANsize(1) - area3Dsize(1);

area3DgroundTruth = groundTruth.Area3D(1:end,:);
area3DgroundTruth = cellfun(@str2num,area3DgroundTruth,'un',0);
area3DgroundTruth = cell2mat(area3DgroundTruth);

area3D = abs(area3Ddetection - area3DgroundTruth);

% -1 = NAN values
ranges2 = [-1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4];
complexNANsize = size(detection.Complexity(1:end,:));

complexDetection = detection.Complexity(1:end,:);
complexDetection = cellfun(@str2num,complexDetection,'un',0);
complexDetection = cell2mat(complexDetection);

complexsize = size(complexDetection);
complexNAN = complexNANsize(1) - complexsize(1);

complexgroundTruth = groundTruth.Complexity(1:end,:);
complexgroundTruth = cellfun(@str2num,complexgroundTruth,'un',0);
complexgroundTruth = cell2mat(complexgroundTruth);

complexity = abs(complexDetection - complexgroundTruth);

nanValues = ones(area2DNAN, 1) * -1;
area2D = [nanValues; area2D];
fig = figure() 
histogram(area2D,ranges,'Normalization','probability') 
title('Area 2D')
ax = gca;
rangesNoNAN = string(ranges);
rangesNoNAN = rangesNoNAN(2:end);
rangesStr = ["Errors", rangesNoNAN];
ax.XTickLabel = rangesStr;
saveas(fig,"Area2D.png")

nanValues = ones(area3DNAN, 1) * -1;
area3D = [nanValues; area3D];
fig = figure() 
histogram(area3D,ranges,'Normalization','probability') 
title('Area 3D')
ax = gca;
ax.XTickLabel = rangesStr;
saveas(fig,"Area3D.png")

nanValues = ones(complexNAN, 1) * -1;
complexity = [nanValues; complexity];
fig = figure() 
histogram(complexity,ranges2,'Normalization','probability') 
title('Complexity')
ax = gca;
rangesNoNAN = string(ranges2);
rangesNoNAN = rangesNoNAN(3:end);
rangesStr = ["Errors","Errors", rangesNoNAN];
ax.XTickLabel = rangesStr;
saveas(fig,"Complexity.png")