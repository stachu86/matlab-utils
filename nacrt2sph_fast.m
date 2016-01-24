function [ sph ] = nacrt2sph_fast(cart)
%NCART2SPH_FAST Transform N-dimensional Cartesian vector to spherical coordinates.
%   [SPH] = NCART2SPH_FAST(CART) where CART is n by d matrix. Rows corresponds
%   to points in N-dimensional space.
%
%   author: skacprza@agh.edu.pls

[m,n] = size(cart);
sph = zeros(m,n);
sph(:,1) = sqrt(sum(cart.^2,2));
for k=1:n-1
    denom = sqrt(sum(cart(:,k:n).^2,2));
    idx1 = (denom ~= 0);
    sph(idx1,k+1) = acos(cart(idx1,k)./denom(idx1));
    idx2 = cart(:,k+1) > 0;
    sph(~idx1 & idx2,k+1) = 0;
    sph(~idx1 & ~idx2,k+1) = pi;
end

idx = cart(:,n) < 0;
sph(idx,n) = 2*pi - sph(idx,n);


