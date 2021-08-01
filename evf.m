function evfMap = evf(img, nHood)
%EVF Generate the Entropy Visibility Map of an image
%   EVFMAP = EVF(IMG) Generates the entropy visibility function map EVFMAP
%   of the input IMG. IMG can either be a M-by-N-by-C RGB color image or a
%   M-by-N grayscale image. Output EVFMAP is a M-by-N grayscale image. The
%   values of EVFMAP lie in the range of [0, 1]. M is the height of the
%   input IMG, N is the width of the input IMAGE, C is the number of color
%   channels of the input IMG.
%
%   EVFMAP = NVF(IMG, NHOOD) Generates the entropy visibility function map
%   EVFMAP of the input IMG where you specify the neighborhood in NHOOD.
%   Default NHOOD size is 9
%
%   Class support
%   -------------
%   Supported classes for IMG are single, double, uint8, uint16, uint32,
%   uint64, int8, int16, int32, int64. These must be real and non-sparse.
%   Supported classes for output EVFMAP are single and double.
%
%   Notes
%   -----
%   [1] EVF converts any class other than logical to uint8 for the
%       histogram count calculation so that the pixel values are discrete
%       and directly correspond to a bin value.
%   [2] EVF shows local entropy change in an image. Output EVF image range
%       lies between [0, 1]. Where 1 represents areas with high entropy and
%       vice-versa.
%
%   Example 1
%   ---------
%   % Compute EVF image of a grayscale image
%       % Read the image
%       img = imread('cameraman.tif');
%
%       % Compute EVF image
%       evfMap = evf(img);
%
%       % Display the results
%       figure
%       tiledlayout('flow');
%
%       nexttile
%       imshow(img)
%       title('Original image')
%
%       nexttile
%       imshow(evfMap)
%       colorbar
%       title('EVF image')
%
%   Reference
%   ---------
%   [1] Gonzalez, R. C., R. E. Woods, and S. L. Eddins. Digital Image
%   Processing Using MATLAB. New Jersey, Prentice Hall, 2003, Chapter 11.

% Written by: Subhadeep Koley
% CC BY-NC-ND license 2021

arguments
    img (:, :, :) {mustBeNumeric, mustBeNonNan, mustBeFinite,...
        mustBeNonsparse, mustBeNonempty, mustBeReal}
    
    nHood (1, 1) {mustBeInteger, mustBeNonNan, mustBeFinite,...
        mustBeNonsparse, mustBeNonempty, mustBeNonzero, mustBePositive,...
        mustBeReal} = 9
end

% Convert to Grayscale if RGB
img = im2gray(img);

% Convert to single if integer
if isinteger(img)
    img = im2single(img);
end

% Perform entropy filtering
evfMap = entropyfilt(img, true(nHood));

% Rescale in [0, 1] range
evfMap = rescale(evfMap);

% Cast output like input data
evfMap = cast(evfMap, 'like', img);
end