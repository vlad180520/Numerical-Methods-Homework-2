function similarity = cosine_similarity(A, B)
  % Calculez norma 2 pentru fiecare vector
  norm_A = norm(A, 2);
  norm_B = norm(B, 2);

  % Daca unul dintre vectori este 0 similaritatea este 0
  if norm_A == 0 || norm_B == 0
    similarity = 0;
  end

  % Calculez produsul scalar dintre vectori
  scalar_product = dot(A, B);

  % Calculez cosine_similarity cu formula data
  similarity = scalar_product / (norm_A * norm_B);

end