% A test script using templeCoords.mat
%
% Write your code here
%
clear;
close all;
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
load('../data/someCorresp.mat');
%%
F = eightpoint(pts1, pts2, M);
%%
load('../data/templeCoords.mat');
pts2 = epipolarCorrespondence(I1, I2, F, pts1);

%%
load('../data/intrinsics.mat');
E = essentialMatrix(F, K1, K2);
%%
P1 = K1* [eye(3),[0;0;0]]* eye(4)* eye(4);
P2s = camera2(E);

P2 = zeros(3,4);
x1 = pts1(1,1);
y1 = pts1(1,2);
x2 = pts2(2,1);
y2 = pts2(2,2);
p11_v = P1(1,:);
p12_v = P1(2,:);
p13_v = P1(3,:);
%u=0;
for i=1:size(P2s,1)
    P2 = K2*P2s(:,:,i);
    p21_v = P2(1,:);
    p22_v = P2(2,:);
    p23_v = P2(3,:);
    temp_A = [y1.*p13_v - p12_v;
              p11_v - x1.*p13_v;
              y2.*p23_v - p22_v;
              p21_v - x2.*p23_v];
    [~,~,v] = svd(temp_A);
    
    Point = [v(1:3,end)./v(4,end);1];
    camera1point1 = P1*Point;
    camera2point1 = P2*Point;
    if(camera1point1(3)>0 && camera2point1(3)>0)
        break;
    end
end

%%
pts3d = triangulate(P1, pts1, P2, pts2 );
%%
figure();
plot3(pts3d(:,1),pts3d(:,2),pts3d(:,3),'*');
xlim([-0.4 1])
%ylim([-0.5 0.9])
%zlim([2 8])
%%
% save extrinsic parameters for dense reconstruction

t1 = [0;0;0];
[~,~,v] = svd(K2\P2);
c2 = v(:,end);
c2 = c2(1:3)./c2(4);
R1 = eye(3);
M2 = K2\(P2(:,1:3));
[~,R2] = qr(M2);
%R2 = [1,0,0;0,-1,0;0,0,1]*R2;
t2 = -R2*c2;
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
