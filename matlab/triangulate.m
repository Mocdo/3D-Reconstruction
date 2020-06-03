function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

    N = size(pts1,1);

    p11_v = P1(1,:);
    p12_v = P1(2,:);
    p13_v = P1(3,:);
	p21_v = P2(1,:);
	p22_v = P2(2,:);
	p23_v = P2(3,:);

    %A = zeros(4,4);
    pts3d = zeros(N,3);
    
    for i=1:N

        x1 = pts1(i,1);
        y1 = pts1(i,2);
        x2 = pts2(i,1);
        y2 = pts2(i,2);
        A = [y1.*p13_v - p12_v;
             p11_v - x1.*p13_v;
             y2.*p23_v - p22_v;
             p21_v - x2.*p23_v];
    
        [~,~,v] = svd(A);
        pts3d(i,:) = v(1:3,end)./v(4,end);
    end



end
