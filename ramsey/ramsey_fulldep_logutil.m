% MATLAB code for Ramsey model with full depreciation and log utility
% (also tested in GNU Octave 3.4.0)
% Andrew Gimber, European University Institute
% 2012-01-29

clear;                                          % clear Workspace
clc;                                            % clear Command Window
close all;                                      % close Figures

% Model parameters
k0=1;                                           % initial capital stock
alpha=0.3;                                      % exponent on capital in the production function
beta=0.9;                                       % discount factor

% Discretisation and value function iteration parameters
kpoints=100;                                    % number of different values of the capital stock to consider (grid size)
tol=0.0001;                                     % tolerance value

% Create grid for k (values of the capital stock to consider)
kincr=k0/(kpoints-1);                           % calculate increment such that grid size is equal to kpoints
k=0:kincr:k0;                                   % 1 x kpoints row vector with elements from 0 to k0 in increments of kincr

% Create matrices of consumption and instantaneous utility possibilities
c=(k.^alpha)'*ones(size(k))-ones(size(k))'*k;   % kpoints x kpoints consumption matrix with typical element c(i,j)=f(k(i))-k(j)
ctiny=0.0001;                                   % a very small number
c(c==0)=ctiny;                                  % set all zero elements of c to a very small number, because we are about to take logs
c(c<0)=NaN;                                     % set all negative elements of c to "not a number", because negative consumption is impossible
u=log(c);                                       % kpoints x kpoints instantaneous utility matrix with typical element u(i,j)=log(c(i,j))

% Value function iteration
V=zeros(size(k));                               % 1 x kpoints row vector of zeros, which is our initial guess for the value function V(k)
gap=tol+1;                                      % need gap>tol, otherwise our while loop will never start
while gap>tol                                   % apply the Bellman operator TV(k)=max{u(k,k')+beta*V(k')} until TV(k) and V(k) are close
    aux=(u+beta*ones(size(k))'*V)';             % kpoints x kpoints matrix, which forms the RHS of the Bellman equation (transposed because max works over columns)
    [TV,I]=max(aux);                            % two 1 x kpoints matrices: one for maximum values, the other for indices
    gap=max(abs(TV-V));                         % measure largest gap between elements of TV(k) and V(k) (loop ends when gap<=tol)
    V=TV;                                       % set V(k) equal to TV(k) so we can do another iteration
end

% Policy function
coptan=(1-alpha*beta)*k.^alpha;                 % analytical solution for optimal consumption
coptnu=k.^alpha-k(I);                           % numerical solution: use indices to find optimal k' and so calculate optimal c

% Graph
figure
plot(k,coptan,k,coptnu)
xlabel('Capital stock')
ylabel('Optimal consumption')
legend('Analytical solution','Numerical solution')