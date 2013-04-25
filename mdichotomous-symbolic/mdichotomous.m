% f is a string (symbolic expression) for the multivariable function;
% its variables must use syntax x1...xn for the names
% xmin and xmax are n-element vectors
function [ x_opt, X ] = mdichotomous(f, x0, epsilon, amin, amax)	
	% convert to column vectors
	x0   = x0(:);
	
	% matrices to return
    X = [];
    F = [];
    
    f_symbolic = sym(f);
    
    n = size(x0,1);
    f_gradient = [];
    
    for i=1:n
        eval(sprintf('syms x%d', i));
        f_gradient = [f_gradient; diff(f_symbolic, eval(sprintf('x%d', i)))]; 
    end
    %disp('f_gradient');
	%disp(f_gradient);
	
	x_curr = x0;
	a_opt = inf;
	
	while abs(a_opt) > epsilon
	    X = [X, x_curr];
	    % evaluate gradient at x_curr
	    for i = 1:n
			eval(sprintf('x%d = %f;', i, x_curr(i)));
		end
		gradient_curr = subs(f_gradient);
		%disp('gradient_curr'); disp(gradient_curr);
		gradient_curr = gradient_curr / norm(gradient_curr);
		
		syms a
		f_symbolic_a = f_symbolic;
	    for i = 1:n
	    	% restore x1 ... xn to symbolic
	    	eval(sprintf('syms x%d', i));
	    	% create intermediate variables
	        eval(sprintf('x%d_inter = %f + a * %f;', i, x_curr(i), gradient_curr(i)));
			f_symbolic_a = subs( f_symbolic_a, ...
				                 eval(sprintf('x%d', i)), ...
				                 eval(sprintf('%f + a * %f', x_curr(i), gradient_curr(i))) ...
			                   );
		end
		%disp('f_symbolic_a'); disp(f_symbolic_a);
		[ a_opt, a_x, a_f] = dichotomous(@(a)(subs(f_symbolic_a)), amin, amax, epsilon);
		x_curr = x_curr + a_opt * gradient_curr;
		%disp('Optimal step: '); disp(a_opt);
		%disp('x_curr'); disp(x_curr);
    end
    x_opt = x_curr;
end