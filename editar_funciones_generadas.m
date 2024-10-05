function [x, desired_sample_rate] = editar_funciones_generadas(signal, sample_rate, desired_sample_rate, delay)
    % [sample_rate, desired_sample_rate] = rat(sample_rate/desired_sample_rate);
    x_resampled = resample(signal, sample_rate, str2num(desired_sample_rate));
    num_delay_samples = str2num(delay) * str2num(desired_sample_rate);  % Convert to samples
    disp(['delay ', num2str(delay)]);
    disp(['desired sample rate ', num2str(desired_sample_rate)]);
    disp(['num_delay_samples ', num2str(num_delay_samples)]);
    x = [zeros(num_delay_samples, 1); x_resampled];  % Add delay
end

