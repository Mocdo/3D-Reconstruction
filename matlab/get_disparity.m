function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
    

    size_y = size(im1,1);
    size_x = size(im1,2);
    
    dispM = repmat(-1,size_y,size_x);
    
    w = (windowSize-1)/2;
    
    im2_padd = double(padarray(im2,[w,maxDisp+w],'replicate','both'));
    im1_padd = double(padarray(im1,[w,w],'replicate','both'));
    
    
    for y = 1:size_y
        for x = 1:size_x
            %im1_block = im1_padd(y:y+2*w,x:x+2*w);
            
            %temp_dist_Max = min(x-1,maxDisp);
            temp_dist_values = repmat(0,1,maxDisp+1);
            for d = 0:maxDisp
                %im2_block = im2_padd(y:y+2*w,x-d:x-d+2*w);
                for i = -w:w
                    for j = -w:w
                        temp = (im1_padd(w+y+i,w+x+j)-im2_padd(w+y+i,maxDisp+w+x+j-d))^2;
                        temp_dist_values(d+1) = temp_dist_values(d+1)+temp;
                    end
                end
            end
            %temp_min_value = min(temp_dist_values); %！！！！！！！！！！！！！！！！这里错误，应该赋值为让temp_dist_values最小的d，而不是temp_dist_values的最小值
			[_,temp_min_value] = min(temp_dist_values);  %更改后
            dispM(y,x)=temp_min_value;
        end
    end
end


function value = matchblocks(b1, b2)
    value=0;
    for i = 1:size(b1,1)
        for j = 1:size(b1,2)
            value = value+(b1(i,j)-b2(i,j))^2;
        end
    end
end