function y_interp = P_spline(coef, x, x_interp)
  % si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3, i = 0 : n - 1
	% coef = [a0, b0, c0, d0, a1, b1, c1, d1, ..., an-1, bn-1, cn-1, dn-1]
	% x = [x0, x1, ..., xn]
	% y_interp(i) = P_spline(x_interp(i)), i = 0 : length(x_interp) - 1
	% Be careful! Indexes in Matlab start from 1, not 0

  % Numarul de intervale
  n = length(x) - 1;
  % Numarul de puncte de interpolare
  m = length(x_interp);
  % Initializarea vectorului de rezultate
  y_interp = zeros(m, 1);

  % TODO: Calculate y_interp using the Spline coefficients
  for j = 1:m
    % Gasesc intervalul in care se afla x_interp(j)
    x_val = x_interp(j);
    % Initializez intervalul cu 1
    interval = 1;
    % Caut intervalul in care se afla x_val
    for i = 1:n
      % Daca x_val este in intervalul [x(i), x(i + 1)], setez intervalul
      if x_val >= x(i) && x_val <= x(i + 1)
        interval = i;
        break;
      end
    end

    % Daca x_val este exact la ultimul punct, setez intervalul la n
    if x_val == x(n + 1)
      interval = n;
    end

    % Coeficientii pentru intervalul i
    % Intervalul i corespunde polinomului s_{i-1} (indexat de la 0)
    coef_base = 4 * (interval - 1);
    a = coef(coef_base + 1);
    b = coef(coef_base + 2);
    c = coef(coef_base + 3);
    d = coef(coef_base + 4);

    % Calculez valoarea polinomului
    dx = x_val - x(interval);
    y_interp(j) = a + b * dx + c * dx ^ 2 + d * dx ^ 3;
  end

end