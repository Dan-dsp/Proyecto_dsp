function [signal] = flip_signal(signal, type_of_signal)
    switch type_of_signal
        case 'Inverse'
            signal = flip(signal);
            % disp(['class signal ', num2str(class(signal))]);
    end
end

