% Reference: Professor Fred Nicolls

[V,spatial,dim] = dicomreadVolume("NewDataTest\1_01_P\CT-deformed");
V = squeeze(V);
V = double(V);

[V1,spatial1,dim1] = dicomreadVolume("NewDataTest\1_01_P\MRI-T1");
V1 = squeeze(V1);
V1 = double(V1);

[V2,spatial2,dim2] = dicomreadVolume("NewDataTest\1_01_P\MRI-T2");
V2 = squeeze(V2);
V2 = double(V2);

[V3,spatial3,dim3] = dicomreadVolume("NewDataTest\1_01_P\CT");
V3 = squeeze(V3);
V3 = double(V3);

%volumeViewer(V);
%[V,scaninfo] = loadminc("01a_us_tal.mnc");

% Voxel coordinates (place origin at center)
tcen = size(V)'/2;
xv = tcen(1)-size(V,1)+1:size(V,1)-tcen(1);
yv = tcen(2)-size(V,2)+1:size(V,2)-tcen(2);
zv = tcen(3)-size(V,3)+1:size(V,3)-tcen(3);

% Points on reference plane
[Xm,Ym,Zm] = meshgrid(-100:100,-100:100,0);
xyz0 = [Xm(:)'; Ym(:)'; Zm(:)'];

dataSetSize = 21*21*21;
labels = [];
data = [];
counting = 0;

% Voxel coordinates (place origin at center)
tcen1 = size(V1)'/2;
xv1 = tcen1(1)-size(V1,1)+1:size(V1,1)-tcen1(1);
yv1 = tcen1(2)-size(V1,2)+1:size(V1,2)-tcen1(2);
zv1 = tcen1(3)-size(V1,3)+1:size(V1,3)-tcen1(3);

% Points on reference plane
[Xm1,Ym1,Zm1] = meshgrid(-100:100,-100:100,0);
xyz01 = [Xm1(:)'; Ym1(:)'; Zm1(:)'];

dataSetSize1 = 21*21*21;
labels1 = [];
data1 = [];
counting1 = 0;

% Voxel coordinates (place origin at center)
tcen2 = size(V2)'/2;
xv2 = tcen2(1)-size(V2,1)+1:size(V2,1)-tcen2(1);
yv2 = tcen2(2)-size(V2,2)+1:size(V2,2)-tcen2(2);
zv2 = tcen2(3)-size(V2,3)+1:size(V2,3)-tcen2(3);

% Points on reference plane
[Xm2,Ym2,Zm2] = meshgrid(-100:100,-100:100,0);
xyz02 = [Xm2(:)'; Ym2(:)'; Zm2(:)'];

dataSetSize2 = 21*21*21;
labels2 = [];
data2 = [];
counting2 = 0;

% Voxel coordinates (place origin at center)
tcen3 = size(V3)'/2;
xv3 = tcen3(1)-size(V3,1)+1:size(V3,1)-tcen3(1);
yv3 = tcen3(2)-size(V3,2)+1:size(V3,2)-tcen3(2);
zv3 = tcen3(3)-size(V3,3)+1:size(V3,3)-tcen3(3);

% Points on reference plane
[Xm3,Ym3,Zm3] = meshgrid(-100:100,-100:100,0);
xyz03 = [Xm3(:)'; Ym3(:)'; Zm3(:)'];

dataSetSize3 = 21*21*21;
labels3 = [];
data3 = [];
counting3 = 0;

for i = 1:10000
    % Pose
    thx = (2*pi*rand() - pi)/2; 
    thy = acos(1 - 2*rand()) + pi/2;  
    if rand() < 1/2
        if thy < pi
            thy = thy + pi;
        else
            thy = thy - pi;
        end
    end
    thy = thy/2;
    thz = (2*pi*rand() - pi)/2;

    Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
    Ry = [cos(thy) 0 -sin(thy); 0 1 0; sin(thy) 0 cos(thy)];
    Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
    R = Rx*Ry*Rz;  t = [0; 0; 0];  Rt = [R t];

    % Interpolate
    xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));
    Vq = interp3(xv,yv,zv,V,xyzp(1,:),xyzp(2,:),xyzp(3,:),'cubic');
    imslice = reshape(Vq,size(Xm));
    imslice = imcrop(imslice,[80 70 47 47]);
    %imslice = uint8(255 * mat2gray(imslice)); % convert from 2000 Hounsfield units to 256

    image = im2gray(imslice);
    vector = reshape(image, 1, []);
    data = [vector; data];

    temp = euler_to_quaternion([thx, thy, thz]);
    labels = [temp; labels];
    
    % Interpolate
    xyzp1 = R*xyz01 + repmat(t,1,size(xyz01,2));
    Vq1 = interp3(xv1,yv1,zv1,V1,xyzp1(1,:),xyzp1(2,:),xyzp1(3,:),'cubic');
    imslice1 = reshape(Vq1,size(Xm1));
    imslice1 = imcrop(imslice1,[80 70 47 47]);
    %imslice1 = uint8(255 * mat2gray(imslice1)); % convert from 2000 Hounsfield units to 256

    image1 = im2gray(imslice1);
    vector1 = reshape(image1, 1, []);
    data1 = [vector1; data1];

    temp1 = euler_to_quaternion([thx, thy, thz]);
    labels1 = [temp1; labels1];
    
    % Interpolate
    xyzp2 = R*xyz02 + repmat(t,1,size(xyz02,2));
    Vq2 = interp3(xv2,yv2,zv2,V2,xyzp2(1,:),xyzp2(2,:),xyzp2(3,:),'cubic');
    imslice2 = reshape(Vq2,size(Xm2));
    imslice2 = imcrop(imslice2,[80 70 47 47]);
    %imslice2 = uint8(255 * mat2gray(imslice2)); % convert from 2000 Hounsfield units to 256

    image2 = im2gray(imslice2);
    vector2 = reshape(image2, 1, []);
    data2 = [vector2; data2];

    temp2 = euler_to_quaternion([thx, thy, thz]);
    labels2 = [temp2; labels2];
    
    % Interpolate
    xyzp3 = R*xyz03 + repmat(t,1,size(xyz03,2));
    Vq3 = interp3(xv3,yv3,zv3,V3,xyzp3(1,:),xyzp3(2,:),xyzp3(3,:),'cubic');
    imslice3 = reshape(Vq3,size(Xm3));
    imslice3 = imcrop(imslice3,[80 70 47 47]);
    %imslice3 = uint8(255 * mat2gray(imslice3)); % convert from 2000 Hounsfield units to 256

    image3 = im2gray(imslice3);
    vector3 = reshape(image3, 1, []);
    data3 = [vector3; data3];

    temp3 = euler_to_quaternion([thx, thy, thz]);
    labels3 = [temp3; labels3];

    counting = counting+1;
    if mod(counting,1000) == 0
        disp(counting);
        %imwrite(imslice, "ImageSet3\Test"+counting+".jpg", 'JPEG');

%         fh = figure;
%         subplot(1,2,1);
%         imagesc(imslice);  colormap(gray);  axis equal;  axis tight;
%         subplot(1,2,2);
%         sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'r.');
%         hold on;  sh2 = scatter3(xyzp(1,1),xyzp(2,1),xyzp(3,1),'b.');  hold off;
%         set(sh2,'SizeData',1000);
%         axis equal;  axis vis3d;
%         set(gca,'xlim',[min(xv) max(xv)]);
%         set(gca,'ylim',[min(yv) max(yv)]);
%         set(gca,'zlim',[min(zv) max(zv)]);
%         xlabel('x');  ylabel('y');  zlabel('z');
    end
    %name = "ImageSet3\img" + counting + ".jpg";
    %imwrite(image, name, 'JPEG');

end 
data(isnan(data)) = 0;
save("ImageSet4\CT-deformed-10000.mat", 'data', 'labels')

data1(isnan(data1)) = 0;
save("ImageSet4\MRI-T1-10000.mat", 'data1', 'labels1')

data2(isnan(data2)) = 0;
save("ImageSet4\MRI-T2-10000.mat", 'data2', 'labels2')

data3(isnan(data3)) = 0;
save("ImageSet4\CT-10000.mat", 'data3', 'labels3')

function eQ = euler_to_quaternion(r)
    x = r(1);
    y = r(2);
    z = r(3);
    
    qx = sin(z/2)*cos(y/2)*cos(x/2) - cos(z/2)*sin(y/2)*sin(x/2);
    qy = cos(z/2)*sin(y/2)*cos(x/2) + sin(z/2)*cos(y/2)*sin(x/2);
    qz = cos(z/2)*cos(y/2)*sin(x/2) - sin(z/2)*sin(y/2)*cos(x/2);
    qw = cos(z/2)*cos(y/2)*cos(x/2) + sin(z/2)*sin(y/2)*sin(x/2);
    
    eQ = [qx, qy, qz, qw];
end