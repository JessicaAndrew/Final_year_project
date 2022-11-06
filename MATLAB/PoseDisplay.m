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
count = 0;
for i = 1:1000
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
    xyzp = R*xyz0 + repmat(t,1,size(xyz0,2));

    sh = scatter3(xyzp(1,:),xyzp(2,:),xyzp(3,:),'');
    axis equal;  axis vis3d;
    set(gca,'xlim',[min(xv) max(xv)]);
    set(gca,'ylim',[min(yv) max(yv)]);
    set(gca,'zlim',[min(zv) max(zv)]);
    xlabel('X axis');  ylabel('Y axis');  zlabel('Z axis');
    hold on;

    if mod(count,100) == 0
        disp(count);
    end
    count = count + 1;

end

hold off;

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