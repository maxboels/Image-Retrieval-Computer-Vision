%H is the descriptor. It is a row vector with the frequency of each pixel
%value quantized in each of the 64 bins.
function H=function_GCH(img,Q)

%1) and then multiply this by Q, then drop the decimal point.
qimg=floor(img.*Q);

%% Now, create a single integer value for each pixel that summarises the 
% RGB value. We will use this as the bin index in the histogram.
quantize = qimg(:,:,1)*Q^2 + qimg(:,:,2)*Q^1 + qimg(:,:,3);

% 'bin' is a 2D image (merged of third dim) where each 'pixel' contains an 
% integer value in range 0 to Q^3-1 inclusive.
% We will now use Matlab's hist command to build a frequency histogram
% from these values.  First, we have to reshape the 2D matrix into a long
% vector of values.
vals=reshape(quantize,1,size(quantize,1)*size(quantize,2));

% Now we can use hist to create a histogram of Q^3=64 bins.
H = hist(vals,Q^3); %#ok<HIST>

% It is convenient to normalise the histogram, so the area under it sum
% to 1.
H = H ./sum(H);

hist(vals,Q^3);
