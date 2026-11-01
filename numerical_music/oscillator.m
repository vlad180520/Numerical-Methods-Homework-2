function x = oscillator(freq, fs, dur, A, D, S, R)
  x = 0;
  % Am generat un vector de timp de la 0 la dur cu pasul 1/fs
  % M-am asigurat ca vectorul de timp are lungimea corecta (dur * fs)
  t = (0:1 / fs:dur - 1 / fs)';

  % Am generat un semnal sinusoidal
  sine_wave = sin(2 * pi * freq * t);

  % Am calculat numarul de sample-uri pentru fiecare faza a ADSR envelope-ului
  total_samples = length(t);
  attack_samples = floor(A * fs);
  decay_samples = floor(D * fs);
  release_samples = floor(R * fs);
  sustain_samples = total_samples - attack_samples - decay_samples - release_samples;

  % M-am asigurat ca sustain_samples nu este negativ
  if sustain_samples < 0
    sustain_samples = 0;
  end

  % Am calculat fiecare faza a ADSR envelope-ului
  % Faza de attack: linear ramp de la 0 la 1
  if attack_samples > 0
    attack_envelope = linspace(0, 1, attack_samples)';
  else
    attack_envelope = [];
  end

  % Faza de decay: linear ramp de la 1 la S (sustain level)
  if decay_samples > 0
    decay_envelope = linspace(1, S, decay_samples)';
  else
    decay_envelope = [];
  end

  % Faza de sustain: constant la nivelul S
  if sustain_samples > 0
    sustain_envelope = S * ones(sustain_samples, 1);
  else
    sustain_envelope = [];
  end

  % Faza de release: linear ramp de la S la 0
  if release_samples > 0
    release_envelope = linspace(S, 0, release_samples)';
  else
    release_envelope = [];
  end

  % Am concatenat toate fazele pentru a forma ADSR envelope-ul
  envelope = [attack_envelope; decay_envelope; sustain_envelope; release_envelope];

  % M-am asigurat ca envelope-ul are lungimea exacta a semnalului
  % Daca nu are lungimea corecta, il completez cu zerouri sau il trunchiez
  if length(envelope) ~= total_samples
    if length(envelope) < total_samples
      envelope = [envelope; zeros(total_samples - length(envelope), 1)];
    else
      envelope = envelope(1:total_samples);
    end
  end

  % Am aplicat envelope-ul la semnalul sinusoidal (produs Hadamard)
  x = sine_wave .* envelope;

end