
function v = homography_solve(pin, pout)
% HOMOGRAPHY_SOLVE finds a homography from point pairs
%   V = HOMOGRAPHY_SOLVE(PIN, POUT) takes a 2xN matrix of input vectors and
%   a 2xN matrix of output vectors, and returns the homogeneous
%   transformation matrix that maps the inputs to the outputs, to some
%   approximation if there is noise.
%
%   This uses the SVD method of
%   http://www.robots.ox.ac.uk/%7Evgg/presentations/bmvc97/criminispaper/node3.html
% David Young, University of Sussex, February 2008
if ~isequal(size(pin), size(pout))
    error('Points matrices different sizes');
end
if size(pin, 1) ~= 2
    error('Points matrices must have two rows');
end
n = size(pin, 2);
if n < 4
    error('Need at least 4 matching points');
end
% Solve equations using SVD
x = pout(1, :); y = pout(2,:); X = pin(1,:); Y = pin(2,:);
rows0 = zeros(3, n);
rowsXY = -[X; Y; ones(1,n)];
hx = [rowsXY; rows0; x.*X; x.*Y; x];
hy = [rows0; rowsXY; y.*X; y.*Y; y];
h = [hx hy];
if n == 4
    [U, ~, ~] = svd(h);
else
    [U, ~, ~] = svd(h, 'econ');
end
v = (reshape(U(:,9), 3, 3)).';
end


% p = [92.9103 58.2693 38.2693 72.9130; 546.1154 566.1154 531.4744 511.4744]
% Q = [0.9000 0.9000 1.1000 1.1000; 1.9000 2.1000 2.1000 1.9000; 0 0 0 0]
% 
% H = homography(p,Q); %  H = [-0.0025 -0.0043 3.4970; -0.0043 0.0025 0.9370; 0.0000 0.0000 1.0000]
% 
% homography(H,p)
% homography(H,p) % gives Q values
% homography(inv(H),Q) % gives Q values
