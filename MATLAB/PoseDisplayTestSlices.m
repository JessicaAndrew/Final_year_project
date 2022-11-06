%https://www.mathworks.com/help/images/segment-lungs-from-3-d-chest-mri-data.html
[V,spatial,dim] = dicomreadVolume("NewDataTest\1_01_P\CT-deformed");
V = squeeze(V);
V = double(V);

% Voxel coordinates (place origin at center)
tcen = size(V)'/2;
xv = tcen(1)-size(V,1)+1:size(V,1)-tcen(1);
yv = tcen(2)-size(V,2)+1:size(V,2)-tcen(2);
zv = tcen(3)-size(V,3)+1:size(V,3)-tcen(3);

% Points on reference plane
[Xm,Ym,Zm] = meshgrid(-100:100,-100:100,0);
xyz0 = [Xm(:)'; Ym(:)'; Zm(:)'];
fh = figure;
set(fh,'Position',[100 100 1400 800])

f = split(readlines("labels.txt"), ",");

for i = 1:4000   
    temp = quaternion_to_euler([double(f(i,1)), double(f(i,2)), double(f(i,3)), double(f(i,4))]);  
    
    thx = temp(1);  Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
    thy = temp(2);  Ry = [cos(thy) 0 -sin(thy); 0 1 0; sin(thy) 0 cos(thy)];
    thz = temp(3);  Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
    R = Rx*Ry*Rz;  t = [0; 0; 0];  Rt = [R t];
    xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));
    
    sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'');
    axis equal;  axis vis3d;
    set(gca,'xlim',[min(xv) max(xv)]);
    set(gca,'ylim',[min(yv) max(yv)]);
    set(gca,'zlim',[min(zv) max(zv)]);
    xlabel('x');  ylabel('y');  zlabel('z');
    hold on;
end

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