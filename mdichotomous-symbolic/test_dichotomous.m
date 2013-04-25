disp('Function: (x+12.34)^2; Minimum is -12.34, result:')
dichotomous(@(x)(x+12.34)^2, -50, 50, 0.0001)

disp('More complicated function, cos(x)*sin(x)*exp(-x)')
dichotomous(@(x)cos(x)*sin(x)*exp(-x), -6, -2, 0.0001)