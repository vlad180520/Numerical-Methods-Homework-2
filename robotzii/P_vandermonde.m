function y_interp = P_vandermonde(coef, x_interp)
    % x = [x0, x1, ..., xn]'
    % y = [y0, y1, ..., yn]'
    % coef = [a0, a1, a2, ..., an]'

    % TODO: Calcualte y_interp using the Vandermonde coefficients

    % Calculez gradul polinomului
    n = length(coef) - 1;
    % Numarul de puncte de interpolare
    m = length(x_interp);
    % Initializarea vectorului de rezultate
    y_interp = zeros(m, 1);

    % Calculez polinomul la fiecare punct de interpolare
    for i = 1:m
      x_val = x_interp(i);
      % Initializez valoarea polinomului
      poly_val = 0;

      % P(x) = a0 + a1 * x + a2 * x^2 + ... + an * x^n
      for j = 1: n + 1
        poly_val = poly_val + coef(j) * (x_val ^ (j - 1));
      end

      % Setez valoarea polinomului in vectorul de rezultate
      y_interp(i) = poly_val;
    end

  end