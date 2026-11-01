function recoms = recommendations(path, liked_theme, num_recoms, min_reviews, num_features)
  % Parsare si preprocesare matrice
  mat = read_mat(path);
  preprocessed_mat = preprocess(mat, min_reviews);

  % Am calculat SVD redus
  if num_features < min(size(preprocessed_mat))
    [U, S, V] = svds(preprocessed_mat, num_features);
  else
    % SVD complet apoi trunchiat
    [U, S, V] = svd(preprocessed_mat);
    if size(V, 2) > num_features
      V = V(:, 1:num_features);
    end
  end

  % Calculez similaritățile folosind matricea V (informații despre teme)
  % Inițializez vectorul de similarități
  % și vectorul pentru tema preferată
  num_themes = size(V, 1);
  similarities = zeros(num_themes, 1);
  liked_theme_vector = V(liked_theme, :);

  % Calculez similaritățile cu tema preferată
  for i = 1:num_themes
    % Dacă tema curentă nu este cea preferată
    if i ~= liked_theme
      theme_vector = V(i, :);
      % Calculez similaritatea cosinus între tema preferată și tema curentă
      similarities(i) = cosine_similarity(liked_theme_vector', theme_vector');
    else
      % Exclud tema preferată din recomandări
      similarities(i) = -inf;
    end
  end

  % Sortez și returnez recomandările
  [~, sorted_indices] = sort(similarities, 'descend');
  recoms = sorted_indices(1:num_recoms)';

end