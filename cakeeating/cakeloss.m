% MATLAB function to calculate loss for cakesearch.m
% (also tested in GNU Octave 3.4.0)
% Andrew Gimber, European University Institute
% 2012-01-03

function L=cakeloss(ctiny,params)

% Unpack model parameters
k0=params(1);                           % initial cake size
beta=params(2);                         % discount factor
% Unpack discretisation and value function iteration parameters
kpoints=params(3);                      % number of different cake sizes to consider (grid size)
tol=params(4);                          % tolerance value

% Create grid for k (cake sizes to consider)
kincr=k0/(kpoints-1);                   % calculate increment such that grid size is equal to kpoints
k=0:kincr:k0;                           % 1 x kpoints row vector with elements from 0 to k0 in increments of kincr

% Create matrices of consumption and instantaneous utility possibilities
c=k'*ones(size(k))-ones(size(k))'*k;    % kpoints x kpoints consumption matrix with typical element c(i,j)=k(i)-k(j)
c(c==0)=ctiny;                          % set all zero elements of c to a very small number, because we are about to take logs
c(c<0)=NaN;                             % set all negative elements of c to "not a number", because negative consumption is impossible
u=log(c);                               % kpoints x kpoints instantaneous utility matrix with typical element u(i,j)=log(c(i,j))

% Value function iteration
V=zeros(size(k));                       % 1 x kpoints row vector of zeros, which is our initial guess for the value function V(k)
count=0;                                % for recording how many iterations it takes for convergence
gap=tol+1;                              % need gap>tol, otherwise our while loop will never start
while gap>tol                           % apply the Bellman operator TV(k)=max{u(k,k')+beta*V(k')} until TV(k) and V(k) are close
    aux=(u+beta*ones(size(k))'*V)';     % kpoints x kpoints matrix, which forms the RHS of the Bellman equation (transposed because max works over columns)
    [TV,I]=max(aux);                    % two 1 x kpoints matrices: one for maximum values, the other for indices
    gap=max(abs(TV-V));                 % measure largest gap between elements of TV(k) and V(k) (loop ends when gap<=tol)
    V=TV;                               % set V(k) equal to TV(k) so we can do another iteration
    count=count+1;                      % add one to the iteration counter
end

% Policy function
coptan=(1-beta)*k;                      % analytical solution for optimal consumption
coptnu=k-k(I);                          % numerical solution: use indices to find optimal k' and so calculate optimal c

% Loss function
L=(coptan-coptnu)*(coptan-coptnu)';     % sum of squared residuals