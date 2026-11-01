function signal = high_pass(signal, fs, cutoff_freq)
  % N - numarul de sample-uri din semnal
  % X - transformata Fourier a semnalului
  N = length(signal);
  X = fft(signal);

  % frequencies - vectorul de frecvente corespunzator transformatei Fourier
  frequencies = (0:N - 1)' * fs / N;

  % Am initializat un vector de mask pentru filtrarea semnalului
  mask = zeros(N, 1);

  % Am aplicat filtrul high-pass pentru prima jumatate a FFT
  for i = 1:floor(N / 2)
    % Daca frecventa este mai mare decat cutoff_freq, setez masca la 1
    if frequencies(i) > cutoff_freq
      mask(i) = 1;
    end
  end

  % Am aplicat filtrul high-pass pentru a doua jumatate a FFT
  % pentru frecventele negative
  for i = floor(N / 2) + 1:N
    % Calculez frecventa negativa corespunzatoare
    mask(i) = abs(mask(N - i + 1));
  end

  % Am aplicat masca pentru a filtra semnalul
  X_filtered = X .* mask;

  % Am aplicat transformata inversa Fourier pentru a obtine semnalul filtrat
  filtered_signal = ifft(X_filtered);

  % Am normalizat semnalul filtrat pentru a avea amplitudinea maxima de 1
  max_amplitude = max(abs(filtered_signal));
  if max_amplitude > 0
    signal = filtered_signal / max_amplitude;
  end

end