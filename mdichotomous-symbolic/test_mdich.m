disp('Function : x1 - x2 + 2*x1^2 + 2*x1*x2 + x2^2');
disp('Minimum : [-1 1.5]');
[op x] = mdichotomous('x1-x2+2*x1^2+2*x1*x2+x2^2', [0 0], 0.0001, -10, 10)