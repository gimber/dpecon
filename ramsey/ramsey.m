% MATLAB code for Ramsey model
% (also tested in GNU Octave 3.4.0)
% Andrew Gimber, European University Institute
% 2012-01-29

clear;                                                          % clear Workspace
clc;                                                            % clear Command Window
close all;                                                      % close Figures

% Model parameters
kmin=0;                                                         % smallest capital stock to consider
kmax=100;                                                       % largest capital stock to consider
beta=0.9;                                                       % discount factor
delta=0.1;                                                      % depreciation rate

% Discretisation and value function iteration parameters
kpoints=100;                                                    % number of different values of the capital stock to consider (grid size)
tol=0.0001;                                                     % tolerance value

% Create grid for k (values of the capital stock to consider)
kincr=(kmax-kmin)/(kpoints-1);                                  % calculate increment such that grid size is equal to kpoints
k=kmin:kincr:kmax;                                              % 1 x kpoints row vector with elements from kmin to kmax in increments of kincr

% Create matrices of consumption and instantaneous utility possibilities
c=(ramseyprod(k)+(1-delta)*k)'*ones(size(k))-ones(size(k))'*k;  % kpoints x kpoints consumption matrix with typical element c(i,j)=f(k(i))+(1-delta)k(i)-k(j)
ctiny=0.0001;                                                   % a very small number
c(c==0)=ctiny;                                                  % set all zero elements of c to a very small number, because we may have log utility
c(c<0)=NaN;                                                     % set all negative elements of c to "not a number", because negative consumption is impossible
u=ramseyutil(c);                                                % kpoints x kpoints instantaneous utility matrix with typical element u(i,j)=u(c(i,j))

% Value function iteration
V=zeros(size(k));                                               % 1 x kpoints row vector of zeros, which is our initial guess for the value function V(k)
gap=tol+1;                                                      % need gap>tol, otherwise our while loop will never start
while gap>tol                                                   % apply the Bellman operator TV(k)=max{u(k,k')+beta*V(k')} until TV(k) and V(k) are close
    aux=(u+beta*ones(size(k))'*V)';                             % kpoints x kpoints matrix, which forms the RHS of the Bellman equation (transposed because max works over columns)
    [TV,I]=max(aux);                                            % two 1 x kpoints matrices: one for maximum values, the other for indices
    gap=max(abs(TV-V));                                         % measure largest gap between elements of TV(k) and V(k) (loop ends when gap<=tol)
    V=TV;                                                       % set V(k) equal to TV(k) so we can do another iteration
end

% Policy function
copt=ramseyprod(k)+(1-delta)*k-k(I);                            % numerical solution: use indices to find optimal k' and so calculate optimal c

% Graph
figure
plot(k,copt)
xlabel('Capital stock')
ylabel('Optimal consumption')