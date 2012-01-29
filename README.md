Dynamic Programming for Economics
=================================

This is a collection of code files that solve various economic models using dynamic programming. It is intended as a reference for economists who are getting started with solving economic models numerically.

The code is written in MATLAB, a programming language developed by MathWorks. MathWorks sells a piece of software (also called MATLAB) for writing and running MATLAB code, and most economics departments will have licenses for it. However, to run the code included in this collection you do *not* need to have a MATLAB license. All the code is written to be compatible with GNU Octave, a free software alternative to MATLAB. Where certain MATLAB features are not implemented in Octave, I provide alternative files with the suffix "_octave".


Cake-eating problem
-------------------

`cakeeating.m`

Code for solving an infinite horizon non-stochastic cake-eating problem with log utility. This problem can be solved analytically, so the code is redundant from the point of view of finding the solution. However, since the true solution is already known, we can use the code to verify that the value function iteration approach works. Starting from an arbitrary guess for the value function and repeatedly applying the Bellman operator, the code does indeed get very close to the true value function. Note that this cake-eating problem is just a special case of the Ramsey model with u(c)=log(c), f(k)=0 and delta=0.

`cakesearch.m`

With log utility, considering zero consumption causes an error in the value function iteration: the value of a cake of size zero is negative infinity, and with each iteration of the Bellman operator this value spreads to the next-smallest cake size. `cakeeating.m` works around this problem by replacing zero consumption values with a very small number. `cakesearch.m` finds the value of this small number that minimises the difference between the numerical solution and the analytical solution.

`cakeloss.m`

An auxiliary function used by `cakesearch.m`. For any given number, it performs value function iteration as in `cakeeating.m`, replacing zero consumption values with that number. It then takes the resulting numerical value function and the analytical value function, and calculates the sum of squared residuals.


Ramsey model
------------

`ramsey_fulldep_logutil.m`

Code for solving an infinite horizon non-stochastic Ramsey model with full depreciation and log utility. As with `cakeeating.m`, this model has an analytical solution, so we can compare this with our numerical result to verify that the value function iteration approach works.

`ramsey.m`

A more general script file for solving non-stochastic Ramsey models. The depreciation rate (delta) can be changed, as can the production and utility functions.

`ramseyprod.m`

Production function for `ramsey.m`.

`ramseyutil.m`

Utility function for `ramsey.m`.


License (The MIT License)
-------------------------

Copyright (c) 2012 Andrew Gimber

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.