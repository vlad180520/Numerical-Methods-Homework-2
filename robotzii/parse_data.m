function [x y] = parse_data(filename)
  % Am deschis fisierul de intrare
  file = fopen(filename, 'r');

  % Am citit abscisele si ordonatele
  n = fscanf(file, '%d', 1);
  x = fscanf(file, '%f', n + 1);
  y = fscanf(file, '%f', n + 1);

  % Rezultatele trebuie sa fie vectori coloana
  x = x(:);
  y = y(:);

  % Am inchis fisierul
  fclose(file);
end