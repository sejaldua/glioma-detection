ima=imread('tumor7.png'); 
ima=rgb2gray(ima); 
subplot(2,2,1),imshow(ima);

k=20; %Number of classes 
[mu,mask]=kMeansFilter(ima,k); 
mask=mat2gray(mask);% convert matrix to image 
subplot(2,2,2),imshow(mask);