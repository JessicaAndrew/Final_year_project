% Reference: Professor Fred Nicolls

f = split(readlines("labels.txt"), ",");
count = 0;

for i = 1:4000 
    poseplot(quaternion(quaternion_to_euler([double(f(i,1)), double(f(i,2)), double(f(i,3)), double(f(i,4))]),"eulerd","ZYX","frame"), PatchFaceAlpha=0, HandleVisibility="off")
    hold on;
    
    if mod(count,500) == 0
        disp(count);
    end
    count = count + 1;
end
xlabel('X axis'), ylabel('Y axis'), zlabel('Z axis')
hold off


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