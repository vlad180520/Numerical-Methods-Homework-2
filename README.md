# Numerical Methods - Homework 2

**Author:** Vlad Parau

Homework for the Numerical Methods course at the National University of Science and Technology POLITEHNICA Bucharest (2025), implemented in GNU Octave / MATLAB. `README.ro.md` contains the spectrogram analysis for the audio task (in Romanian).

---

## Numerical Music (`numerical_music`)
Synthesizes and processes audio.
- Oscillators and instrument synthesis from note patterns (`music1.csv`, `music2.csv`)
- Stereo-to-mono conversion and spectrograms
- High-pass filtering and reverb by convolution with an impulse response
- Spectrograms of each effect chain are in `figures`

## Robotzii (`robotzii`)
Reconstructs a trajectory from sampled points by interpolation.
- Polynomial interpolation by solving a **Vandermonde** system
- **Cubic C² spline** interpolation, assembling and solving the 4N × 4N system for the spline coefficients

## Recommendations (`recommendations`)
Recommends themes similar to one a user liked.
- Filters out users with too few reviews
- Extracts latent features with a **truncated SVD**
- Ranks themes by **cosine similarity** to the liked theme

---

## Running

Each task is a set of Octave/MATLAB functions. Run them from GNU Octave or MATLAB with the task folder on the path, for example:

```octave
cd robotzii
coef = spline_c2(x, y);
```
