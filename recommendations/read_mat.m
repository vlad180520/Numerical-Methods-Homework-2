function mat = read_mat(path)
  % Citesc CSV-ul si ignor prima linie si prima coloana
  mat = csvread(path, 1, 1);
end