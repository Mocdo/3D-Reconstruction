function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
  %%  
    size_ptr = size(pts1,1);
    scale_M = diag([1/M 1/M 1]);
    
    
%     pts1_scaled=zeros(size_ptr,3);
%     pts2_scaled=zeros(size_ptr,3);
%     for i=1:size_ptr
%         pts1_scaled(i,:)=[pts1(i,:),1];
%         pts2_scaled(i,:)=[pts2(i,:),1];
%         
%         pts1_scaled(i,:) = (scale_M* pts1_scaled(i,:)')';
%         pts2_scaled(i,:) = (scale_M* pts2_scaled(i,:)')';
% 
%     end
    pts1_scaled = pts1./M;
    pts2_scaled = pts2./M;
    pts1_scaled = [pts1_scaled,ones(size_ptr,1)];
    pts2_scaled = [pts2_scaled,ones(size_ptr,1)];
    
    A = zeros(size_ptr,9);
    for i=1:size_ptr
        x2=pts1_scaled(i,1);
        y2=pts1_scaled(i,2);
        x1=pts2_scaled(i,1);
        y1=pts2_scaled(i,2);
        A(i,:) = [x2*x1, x2*y1, x2, y2*x1, y2*y1, y2, x1, y1, 1];
    end
    
    [~,~,V] = svd(A);
    F = reshape(V(:,end),3,3)';
    
    [s,u,v] = svd(F);
    u(3,3)=0;
    F = s*u*v';
    disp(F)
    F = refineF(F,pts1_scaled,pts2_scaled);
    
    F = (scale_M)*F*(scale_M);

end
