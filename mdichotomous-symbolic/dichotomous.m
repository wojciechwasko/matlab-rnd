function [ x_opt, X, F] = dichotomous(f, xmin, xmax, epsilon)
	X = [];
	F = [];
	x1 = xmin;
	x2 = xmax;
	% initial xmid
	xmid = (xmin+xmax)/2;
	while abs(xmax-xmin) > 2*epsilon
		x1 = xmid - epsilon;
		x2 = xmid + epsilon;
		fx1 = f(x1);
		fx2 = f(x2);
		X = [X ; x1, x2];
		F = [F ; fx1, fx2];
		if fx1 < fx2
			xmax = xmid;
		else
			xmin = xmid;
		end
		xmid = (xmin+xmax)/2;
	end
	x_opt = xmid;
end
