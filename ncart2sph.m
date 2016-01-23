function [ sph ] = ncart2sph(cart)
%NCART2SPH Transform N-dimensional Cartesian vector to spherical coordinates.
%   [SPH] = NCART2SPH(CART) where CART is n by d matrix. Rows corresponds
%   to points in N-dimensional space.
%
%   author: skacprza@agh.edu.pl

[m,n] = size(cart);
sph = zeros(m,n);

for i=1:m
    sph(i,1) = norm(cart);
    for k=1:n-1
        denom = norm(cart(i,k:n));
        if denom ~= 0
            sph(i,k+1) = acos(cart(i,k)/denom);
        else
            if cart(i,k+1) > 0
                sph(i,k+1) = 0;
            else
                sph(i,k+1) = pi;
            end
        end
    end
    
    if cart(i,n) < 0 && n > 1
        cart(i,n) = 2*pi - cart(i,n);
    end
end

