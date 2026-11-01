function mono = stereo_to_mono(stereo)
  % Am aplicat formula de conversie stereo la mono
  mono = mean(stereo, 2);

  % Normalize
  mono = mono / max(abs(mono));
end