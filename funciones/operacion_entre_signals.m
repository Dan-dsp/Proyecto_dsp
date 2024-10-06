function [processed_signal, new_sample_rate] = operacion_entre_signals(type_of_operation, signal_1, sample_rate_1, signal_2, sample_rate_2)

    % Se va a realizar sobremuestreo y submuestreo de acuerdo a las dos
    % frecuencias
    new_sample_rate = lcm(sample_rate_1, sample_rate_2);
    disp(['El mcm entre ', num2str(sample_rate_1), ' y ', num2str(sample_rate_2), ' es ', num2str(new_sample_rate)]);
    if new_sample_rate >= 100000
        new_sample_rate = max(sample_rate_1, sample_rate_2);
        if new_sample_rate == sample_rate_1
            signal_2 = resample(signal_2, sample_rate_2, new_sample_rate);
        elseif new_sample_rate == sample_rate_2
            signal_1 = resample(signal_1, sample_rate_1, new_sample_rate);
        end
    else
        signal_1 = resample(signal_1, sample_rate_1, new_sample_rate);
        signal_2 = resample(signal_2, sample_rate_2, new_sample_rate);
    end  

    max_length = max(length(signal_1), length(signal_2));
    % Adidng zeros at the right side of the signal
    x1_padded = [signal_1; zeros(max_length - length(signal_1), 1)]; 
    x2_padded = [signal_2; zeros(max_length - length(signal_2), 1)];

    switch type_of_operation
        case 'Suma'
            processed_signal = x1_padded + x2_padded; % Sum of two signals
        case 'Multiplicación'
            processed_signal = x1_padded .* x2_padded; % Element-wise multiplication of two signals
    end

    
end

