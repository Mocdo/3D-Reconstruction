function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
    
    c1 = -(K1*R1)\(K1*t1);
    c2 = -(K2*R2)\(K2*t2);
    b = norm(c1-c2);
    f = K1(1,1);

    depthM = zeros(size(dispM,1),size(dispM,2));
    for x = 1:size(dispM,1)
        for y = 1:size(dispM,2)
            if(dispM(x,y)==0)
                depthM(x,y)=0;
            else
                depthM(x,y) = b * f / dispM(x,y);
            end
        end
    end
end