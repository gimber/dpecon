% MATLAB function to find optimal "tiny consumption" parameter for cakeeating.m
% (also tested in GNU Octave 3.4.0)
% Andrew Gimber, European University Institute
% 2012-01-03

function ctiny=cakesearch(params)

% Initial parameters for the grid of small numbers to consider
xmin=realmin;                                               % smallest number computer can handle
xmax=1e-1;                                                  % largest value to consider initially
xpoints=10;                                                 % number of values to consider

% Optimisation parameters
imax=20;                                                    % maximum number of iterations
xtol=1e-5;                                                  % tolerance value

% Grid search for optimum choice of small number to replace zero consumption
I=2;                                                        % otherwise while loop never starts
i=0;                                                        % counter for number of iterations
while I>1 && I<xpoints && (xmax-xmin)/xmin>=xtol && i<imax  % stop search when optimal value is at boundary of grid, or minimum and maximum values are very close, or after a certain number of iterations
    i=i+1;                                                  % increase the iteration counter by one
    xincr=(xmax-xmin)/(xpoints-1);                          % calculate increment such that grid size is equal to xpoints
    x=xmin:xincr:xmax;                                      % 1 x xpoints row vector with elements from xmin to xmax in increments of xincr
    for j=1:xpoints
        L(j)=cakeloss(x(j),params);                         % calculate loss for each grid point using cakeloss.m
    end
    [minL,I]=min(L);                                        % find minimum loss and store index of the value at which it was reached
    xopt=x(I);                                              % use index to find optimal value of x for this iteration of the search
    xmin=x(I-1);                                            % use the point below the current optimum as the lowest value in the new grid
    xmax=x(I+1);                                            % use the point above the current optimum as the highest value in the new grid
    % graph the loss function for this iteration
    figure                                                  % associate the Figure we are about to draw with the iteration number
    plot(x,L)
    xlabel('ctiny')
    ylabel('Loss')
end
ctiny=xopt;                                                 % store optimum value as parameter to be used later