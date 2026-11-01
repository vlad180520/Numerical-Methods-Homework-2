function signal = apply_reverb(signal, impulse_response)
  % M-am asigurat ca impulse response-ul este in mono
  impulse_response = stereo_to_mono(impulse_response);

  % Am calculat convolutia intre semnal si impulse response
  convolved_signal = fftconv(signal, impulse_response);

  % Am normalizat semnalul rezultat
  max_amplitude = max(abs(convolved_signal));

  % Daca amplitudinea maxima este mai mare decat 0, normalizam semnalul
  if max_amplitude > 0 
    signal = convolved_signal / max_amplitude;
  else
    signal = convolved_signal;
  end
end