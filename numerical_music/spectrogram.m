function [S f t] = spectrogram(signal, fs, window_size)
  S = 0;
  f = 0;
  t = 0;
  % Extrag lungimea semnalului
  signal_len = length(signal);

  % Extrag numarul de ferestre
  windows_cnt = floor(signal_len / window_size);

  % Am initializat matricea spectograma
  S = zeros(window_size, windows_cnt);

  % Procesez fiecare fereastra
  for i = 1:windows_cnt
    % Extrag fereastra curenta
    cnt_start = (i - 1) * window_size + 1;
    cnt_end = cnt_start + window_size - 1;
    window = signal(cnt_start:cnt_end);

    % Aplic functia pentru fereastra Hann
    windowed_signal = window .* hanning(window_size);

    % Calculez FFT pentru fereastra curenta
    % Am dublat lungimea FFT-ului pentru a obtine spectrul complet
    fourier = fft(windowed_signal, 2 * window_size);

    % Extrag jumatatea spectogramei (simetria FFT-ului)
    fourier_half = fourier(1:window_size);

    % Calculez amplitudinea spectrogramei
    S(:, i) = abs(fourier_half);
  end

  % Calculez vectorul de frecventa
  % Frecventele reprezentate de DFT sunt de la 0 la fs/ 2
  f = (0:window_size - 1)' * fs / (2 * window_size);

  % Calculez vectorul de timp
  % Fiecare fereastra are o durata de window_size / fs secunde
  % si sunt windows_cnt ferestre
  t = (0: windows_cnt - 1)' * window_size / fs;
end
