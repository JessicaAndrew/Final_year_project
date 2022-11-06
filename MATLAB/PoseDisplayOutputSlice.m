% Reference: Professor Fred Nicolls

[V,spatial,dim] = dicomreadVolume("NewDataTest\1_01_P\CT-deformed");
V = squeeze(V);
V = double(V);

% Voxel coordinates (place origin at center)
tcen = size(V)'/2;
xv = tcen(1)-size(V,1)+1+125:size(V,1)-tcen(1)-125;
yv = tcen(2)-size(V,2)+1+125:size(V,2)-tcen(2)-125;
zv = tcen(3)-size(V,3)+1+15:size(V,3)-tcen(3)-15;

% Points on reference plane
[Xm,Ym,Zm] = meshgrid(-100:100,-100:100,0);
xyz0 = [Xm(:)'; Ym(:)'; Zm(:)'];
fh = figure;
set(fh,'Position',[100 100 1400 800])

% First plot
subplot(1,3,1);

temp = quaternion_to_euler([0.0, 0.0, 0.0, 0.0]);

thx = temp(1);  Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
thy = temp(2);  Ry = [cos(thy) 0 -sin(thy); 0 1 0; sin(thy) 0 cos(thy)];
thz = temp(3);  Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
R = Rx*Ry*Rz;  t = [0; 0; 0];  Rt = [R t];
xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));

sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'b.');
axis equal;  axis vis3d;
set(gca,'xlim',[min(xv) max(xv)]);
set(gca,'ylim',[min(yv) max(yv)]);
set(gca,'zlim',[min(zv) max(zv)]);
xlabel('x');  ylabel('y');  zlabel('z');
hold on;

temp = quaternion_to_euler([0.009 0.035 0.003 0.046]);

thx = temp(1);  Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
thy = temp(2);  Ry = [cos(thy) 0 -sin(thy); 0 1 0; sin(thy) 0 cos(thy)];
thz = temp(3);  Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
R = Rx*Ry*Rz;  t = [0; 0; 0];  Rt = [R t];
xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));

sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'g.');
axis equal;  axis vis3d;
set(gca,'xlim',[min(xv) max(xv)]);
set(gca,'ylim',[min(yv) max(yv)]);
set(gca,'zlim',[min(zv) max(zv)]);
xlabel('x');  ylabel('y');  zlabel('z');
hold on;
title('Average linear model error')

hold off;

% Second plot
subplot(1,3,2);

temp = quaternion_to_euler([0.0, 0.0, 0.0, 0.0]);

thx = temp(1);  Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
thy = temp(2);  Ry = [cos(thy) 0 -sin(thy); 0 1 0; sin(thy) 0 cos(thy)];
thz = temp(3);  Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
R = Rx*Ry*Rz;  t = [0; 0; 0];  Rt = [R t];
xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));

sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'b.');
axis equal;  axis vis3d;
set(gca,'xlim',[min(xv) max(xv)]);
set(gca,'ylim',[min(yv) max(yv)]);
set(gca,'zlim',[min(zv) max(zv)]);
xlabel('x');  ylabel('y');  zlabel('z');
hold on;

temp = quaternion_to_euler([0.007, 0.003, 0.002, 0.001]);

thx = temp(1);  Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
thy = temp(2);  Ry = [cos(thy) 0 -sin(thy); 0 1 0; sin(thy) 0 cos(thy)];
thz = temp(3);  Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
R = Rx*Ry*Rz;  t = [0; 0; 0];  Rt = [R t];
xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));

sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'g.');
axis equal;  axis vis3d;
set(gca,'xlim',[min(xv) max(xv)]);
set(gca,'ylim',[min(yv) max(yv)]);
set(gca,'zlim',[min(zv) max(zv)]);
xlabel('x');  ylabel('y');  zlabel('z');
hold on;
title('Average DNN model error')

hold off;

% Third plot
subplot(1,3,3);

temp = quaternion_to_euler([0.0, 0.0, 0.0, 0.0]);

thx = temp(1);  Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
thy = temp(2);  Ry = [cos(thy) 0 -sin(thy); 0 1 0; sin(thy) 0 cos(thy)];
thz = temp(3);  Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
R = Rx*Ry*Rz;  t = [0; 0; 0];  Rt = [R t];
xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));

sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'b.');
axis equal;  axis vis3d;
set(gca,'xlim',[min(xv) max(xv)]);
set(gca,'ylim',[min(yv) max(yv)]);
set(gca,'zlim',[min(zv) max(zv)]);
xlabel('x');  ylabel('y');  zlabel('z');
hold on;

temp = quaternion_to_euler([0.002 0.002 0.001 0]);

thx = temp(1);  Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
thy = temp(2);  Ry = [cos(thy) 0 -sin(thy); 0 1 0; sin(thy) 0 cos(thy)];
thz = temp(3);  Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
R = Rx*Ry*Rz;  t = [0; 0; 0];  Rt = [R t];
xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));

sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'g.');
axis equal;  axis vis3d;
set(gca,'xlim',[min(xv) max(xv)]);
set(gca,'ylim',[min(yv) max(yv)]);
set(gca,'zlim',[min(zv) max(zv)]);
xlabel('x');  ylabel('y');  zlabel('z');
hold on;
title('Average CNN model error')

hold off;

function qE = quaternion_to_euler(r)
    qx = r(1);
    qy = r(2);
    qz = r(3);
    qw = r(4);
    
    t0 = 2.0*(qw*qx + qy*qz);
    t1 = 1.0 - 2.0*(qx*qx + qy*qy);
    x = rad2deg(atan2(t0, t1));
     
    t2 = 2.0*(qw*qy - qz*qx);
    if t2 > 1.0
        t2 = 1.0;
    end   
    if t2 < -1.0
        t2 = -1.0;
    end
    y = rad2deg(asin(t2));

    t3 = 2.0*(qw*qz + qx*qy);
    t4 = 1.0 - 2.0*(qy*qy + qz*qz);
    z = rad2deg(atan2(t3, t4));
    
    qE = [x, y, z];
end