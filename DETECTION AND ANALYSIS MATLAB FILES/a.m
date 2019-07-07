img=imread('tumor1.jpeg');
bw=im2bw(img,0.7);
label=bwlabel(bw);
stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
tumor_label=find(area==max_area);
tumor=ismember(label,tumor_label);
se=strel('square',5);
tumor=imdilate(tumor,se);
figure(2);
subplot(1,3,1);
imshow(img,[]);
title('Brain');

subplot(1,3,2);
imshow(tumor,[]);
title('Tumor Alone');
[B,L]=bwboundaries(tumor,'noholes');
subplot(1,3,3);
imshow(img,[]);
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'y' ,'linewidth',1.45);
    
    
    
end

title('Detected Tumor');
hold off;