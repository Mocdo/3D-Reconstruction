function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%

    if (ndims(im1) == 3)
        im1 = rgb2gray(im1);
    end
    if (ndims(im2) == 3)
        im2 = rgb2gray(im2);
    end

    b_size = 4;
    
    im2_padd = double(padarray(im2,[b_size,b_size],'replicate','both'));
    im1_padd = double(padarray(im1,[b_size,b_size],'replicate','both'));

    im2_h = size(im2,1);
    im2_w = size(im2,2);
    im1_h = size(im1,1);
    im1_w = size(im1,2);

    N = size(pts1,1);
    pts2 = zeros(N,2);
    for i=1:N
        px=pts1(i,1);
        py=pts1(i,2);
%          if(px<=0 || px>im1_h || py<=0 ||py>im1_w)
%              continue;
%          end
        p1=[px; py; 1];
        line = F*p1;
        
        k = -line(1)/line(2);
        b = -line(3)/line(2);
        
        px_int = uint16(px);
        py_int = uint16(py);
        
        im1_block = im1_padd(py_int:py_int+2*b_size,px_int:px_int+2*b_size);
        
        matched_value = Inf(im2_h,1);
        matched_pix = zeros(im2_h,2);
        for px2 = 1:im2_w
            py2 = k*px2+b;
            if(px2<=0 || px2>im2_w || py2<=0 ||py2>im2_h)
                continue;
            end
            
            py2_int = floor(py2);
            im2_block = im2_padd(py2_int:py2_int+2*b_size,px2:px2+2*b_size);
            
            matched_value(px2) = matchblocks(im1_block,im2_block);
            
            matched_pix(px2,:) = [px2,py2];
            

        end
        
        [~,px2_min] = min(matched_value);
        %py2_min = k*px2_min+b;
        
        pts2(i,:)=matched_pix(px2_min,:);
    end
    

    
end


function value = matchblocks(b1, b2)

    value=-999;
    x = min(size(b1,1),size(b2,1));
    y = min(size(b1,2),size(b2,2));
    for i = 1:x-1
        for j = 1:y
            value = value+abs((b1(i,j)-b1(i+1,j))-(b2(i,j)-b2(i+1,j)));
        end
    end
    overall_diff = abs(sum(b1(:))-sum(b2(:)));
    value = value+overall_diff;
end
