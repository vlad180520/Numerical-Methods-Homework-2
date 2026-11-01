function reduced_mat = preprocess(mat, min_reviews)
  % Am calculat numarul de recenzii pentru fiecare client (rand)
  % O recenzie este valida daca este diferita de 0
  reviews_cnt = sum(mat ~= 0, 2);

  % Caut indicii randurilor care au cel putin min_reviews recenzii
  valid_rows = reviews_cnt >= min_reviews;

  % Pastrez doar randurile care indeplinesc conditia
  reduced_mat = mat(valid_rows, :);
end