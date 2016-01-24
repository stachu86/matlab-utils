function [ SPH ] = ncart2sph(cart)
%NCART2SPH Transform N-dimensional Cartesian vector to spherical coordinates.
%   [SPH] = NCART2SPH(CART) where CART is n by d matrix. Rows corresponds
%   to points in N-dimensional space.
%
%   based on: https://en.wikipedia.org/wiki/N-sphere#Spherical_coordinates
%   author: skacprza@agh.edu.pl


[m,n] = size(cart);
SPH = cell(m,1);

for i=1:m
    sph = zeros(1,n);
    sph(1) = norm(cart);
    for k=1:n-1
        denom = norm(cart(i,k:n));
        if denom ~= 0
            sph(k+1) = acos(cart(i,k)/denom);
        else
            if cart(k+1) > 0
                sph(k+1) = 0;
            else
                sph(k+1) = pi;
            end
        end
    end
    
    if cart(i,n) < 0 && n > 1
        sph(n) = 2*pi - sph(n);
    end
    SPH{i} = sph;
end
SPH = cell2mat(SPH);

