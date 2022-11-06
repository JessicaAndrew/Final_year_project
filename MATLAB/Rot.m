count = 0;
for i = 1:1000
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
    
    poseplot(quaternion([thz*180/pi, thy*180/pi, thx*180/pi],"eulerd","ZYX","frame"), PatchFaceAlpha=0, HandleVisibility="off")
    hold on;

    if mod(count,100) == 0
        disp(count);
    end
    count = count + 1;

end
xlabel('X axis'), ylabel('Y axis'), zlabel('Z axis')
hold off

