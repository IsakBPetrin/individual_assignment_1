% Generate a "Clean" sinusoidal signal
amplitude = 1;              % Amplitude of the signal
sampling_rate = 44100;       % Sampling frequency in Hz
frequency = 1000;            % Frequency of the signal in Hz
initial_phase = 0;           % Phase shift in radians
signal_duration = 2;         % Duration of the signal in seconds

% Generate the clean sinusoidal signal and corresponding time vector
[clean_signal, time_vector_clean] = generate_sinusoid(amplitude, frequency, initial_phase, sampling_rate, signal_duration);

% Plot the clean signal (time domain)
stem(time_vector_clean, clean_signal);  % Plot using stem to emphasize discrete nature
xlim([0 0.01]);                         % Limit x-axis to show the first 10ms of the signal

% Play the clean signal (optional, uncomment to play sound)
% sound(clean_signal, sampling_rate);

% Transform clean signal to frequency domain using FFT
[clean_spectrum, frequency_vector_clean] = make_spectrum(clean_signal, sampling_rate, true);

% Plot the magnitude spectrum of the clean signal (frequency domain)
stem(frequency_vector_clean, abs(clean_spectrum));  % Plot the magnitude of the spectrum
xlim([0 3000]);                                    % Limit x-axis to show up to 3000 Hz

% Load the recorded voice from the .m4a file
recording_filename = "Voice.m4a";    % Filename of the recorded audio
[recorded_signal, recorded_fs] = audioread(recording_filename);  % Read the audio file

% Play the recorded voice (optional, uncomment to play sound)
% sound(recorded_signal, recorded_fs);

% Truncate the recorded signal to match the clean signal duration
start_sample = 1586;                       % Starting sample for the truncated recording
end_sample = 2 * sampling_rate + 1585;     % End sample, based on the signal duration
recorded_signal = recorded_signal(start_sample:end_sample);  % Extract the segment of interest
recorded_signal = recorded_signal';        % Transpose to match format (row vector)

% Plot the recorded signal (time domain)
stem(time_vector_clean, recorded_signal);  % Use the same time vector as clean signal

% Transform recorded signal to frequency domain using FFT
[recorded_spectrum, frequency_vector_recorded] = make_spectrum(recorded_signal, sampling_rate, true);

% Plot the magnitude spectrum of the recorded voice (frequency domain)
stem(frequency_vector_recorded, abs(recorded_spectrum));

% Plot the pure tone spectrum
figure;
hold on;
plot(frequency_vector_clean, abs(clean_spectrum));  % Plot the spectrum of the clean signal
title('Generated "Pure" tone');
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
xlim([0 3000]);    % Limit x-axis to 3000 Hz
grid off;          % Turn off the grid for a cleaner look
hold off;

% Plot the recorded tone spectrum
figure;
hold on;
plot(frequency_vector_recorded, abs(recorded_spectrum));  % Plot the spectrum of the recorded signal
title('Recorded tone');
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
xlim([0 3000]);    % Limit x-axis to 3000 Hz
grid off;          % Turn off the grid for a cleaner look
hold off;

% Uncomment to save the plots as PDF files
% saveas(gcf,'PureTone.pdf')
% saveas(gcf,'RecordedTone.pdf')
