function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m

    
    
    c1 = -(K1*R1)\(K1*t1);
    c2 = -(K2*R2)\(K2*t2);
    r1 = (c1-c2)/norm(c1-c2);
    r2 = cross(R1(3,:)',r1);
    r3 = cross(r2,r1);
    Rrect = [r1,r2,r3]';
    Krect = K1;
    
    t1n = -Rrect*c1;
    t2n = -Rrect*c2;
    
    R2 = [-1,0,0;0,-1,0;0,0,1]*R2;

    
    M1 = (Krect*Rrect)/(K1*R1);
    M2 = (Krect*Rrect)/(K2*R2);
    
    
    K1n = Krect;
    K2n = Krect;
    R1n = Rrect;
    R2n = Rrect;


    
end