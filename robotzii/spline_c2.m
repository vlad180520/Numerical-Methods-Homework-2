function coef = spline_c2(x, y)
  % Remember that the indexes in Matlab start from 1, not 0

	% si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3
	% si'(x)  =      bi         + 2ci(x - xi)  + 3di(x - xi)^2
	% si''(x) =                   2ci          + 6di(x - xi)

  % Numarul de intervale
  N = length(x) - 1;

  % Initializarea matricei A si vectorului b
  % coeficientii polinoamelor sunt: [a0, b0, c0, d0, a1, b1, c1, d1, ..., aN-1, bN-1, cN-1, dN-1]
  % Deci sunt 4 * N necunoscute
  A = zeros(4 * N, 4 * N);
  b = zeros(4 * N, 1);

  % Am initializat indexul pentru linia curenta
  row = 1;

  % TOOD 1: si(xi) = yi, i = 0 : n - 1
  for i = 1:N
    % si(xi) = ai + bi*0 + ci*0 + di*0 = ai = yi
    % coeficientul ai este la pozitia 4 * (i - 1) + 1
    col = 4 * (i - 1) + 1;
    % Setez coeficientul ai in matricea A
    A(row, col) = 1;
    % Setez valoarea lui yi in vectorul b
    b(row) = y(i);
    % Incrementez indexul pentru linia curenta
    row = row + 1;
  end

  % TODO 2: s_n-1(xn) = yn
  dx = x(N + 1) - x(N);

  % Indexul base pentru coeficientii ultimului polinom
  col_base = 4 * (N - 1);
  % a_{n-1}
  A(row, col_base + 1) = 1;
  % b_{n-1}
  A(row, col_base + 2) = dx;
  % c_{n-1}
  A(row, col_base + 3) = dx ^ 2;
  % d_{n-1}
  A(row, col_base + 4) = dx ^ 3;
  % Setez valoarea lui yn in vectorul b
  b(row) = y(N + 1);
  % Incrementez indexul pentru linia curenta
  row = row + 1;

  % TODO 3: si(x_i+1) = s_i+1(x_i+1), i = 0 : n - 1
  for i = 1:N - 1
    % si(x_{i+1}) = ai + bi*dx + ci*dx^2 + di*dx^3
    dx = x(i + 1) - x(i);
    % coeficientii pentru polinomul i
    col_i = 4 * (i - 1);
    % Setez coeficientul ai in matricea A
    A(row, col_i + 1) = 1;
    % Setez coeficientul bi in matricea A
    A(row, col_i + 2) = dx;
    % Setez coeficientul ci in matricea A
    A(row, col_i + 3) = dx ^ 2;
    % Setez coeficientul di in matricea A
    A(row, col_i + 4) = dx ^ 3;

    % s_{i+1}(x_{i+1}) = a_{i+1}
    col_i1 = 4 * i;
    A(row, col_i1 + 1) = -1;
    % Setez valoarea lui 0 in vectorul b
    b(row) = 0;
    % Incrementez indexul pentru linia curenta
    row = row + 1;
  end

  % TODO 4: si'(x_i+1) = s_i+1'(x_i+1), i = 0 : n - 1
  for i = 1:N - 1
    % si'(x_{i+1}) = bi + 2*ci*dx + 3*di*dx^2
    dx = x(i + 1) - x(i);
    % coeficientii pentru polinomul i
    col_i = 4 * (i - 1);
    % Setez coeficientul bi in matricea A
    A(row, col_i + 2) = 1;
    % Setez coeficientul ci in matricea A
    A(row, col_i + 3) = 2 * dx;
    % Setez coeficientul di in matricea A
    A(row, col_i + 4) = 3 * dx ^ 2;

    % s_{i+1}'(x_{i+1}) = b_{i+1}
    col_i1 = 4 * i;
    A(row, col_i1 + 2) = -1;

    % Setez valoarea 0 in vectorul b
    b(row) = 0;
    % Incrementez indexul pentru linia curenta
    row = row + 1;
  end

  % TODO 5: si''(x_i+1) = s_i+1''(x_i+1), i = 0 : n - 1
  for i = 1:N - 1
    % si''(x_{i+1}) = 2*ci + 6*di*dx
    dx = x(i + 1) - x(i);
    col_i = 4 * (i - 1);
    A(row, col_i + 3) = 2;
    A(row, col_i + 4) = 6 * dx;

    % s_{i+1}''(x_{i+1}) = 2*c_{i+1}
    col_i1 = 4 * i;
    A(row, col_i1 + 3) = -2;

    b(row) = 0;
    row = row + 1;
  end

  % TODO 6: s0''(x0) = 0
  % s0''(x0) = 2*c0 = 0
  A(row, 3) = 2;
  b(row) = 0;
  row = row + 1;

  % TODO 7: s_n-1''(x_n) = 0
  % s_{n-1}''(x_n) = 2*c_{n-1} + 6*d_{n-1}*(x_n - x_{n-1}) = 0
  dx = x(N + 1) - x(N);
  col_base = 4 * (N - 1);
  A(row, col_base + 3) = 2;
  A(row, col_base + 4) = 6 * dx;
  b(row) = 0;

  % Rezolv sistemul de ecuatii
  coef = A \ b;
  
end