function [signal, sample_rate] = procesamiento_en_el_tiempo(tipo_de_procesamiento)
    [signal, sample_rate] = import_signal();
    switch tipo_de_procesamiento
        case 'cambiar frecuencia de muestreo'
            sample_rate = change_sample_rate();
        case 'desplazar'
            signal = desplazar(signal, sample_rate);
        case 'sumar'
            [signal_2, sample_rate_2] = import_signal();
            signal = sumar(signal, signal_2);
        case 'multiplicar'
            [signal_2, sample_rate_2] = import_signal();
            signal = multiplicar(signal, signal_2);
        case 'inversa'
            signal = invertir_senal(signal);
        case 'mono a estereo'
            signal = stereo_from_mono(signal, signal_2, sample_rate);
        case 'estereo a mono'
            a
        case 'estereo con dos monos'
            a
        case 'volumen del audio'
            a
    end

    function [signal, sample_rate] = import_signal()
        % Busca el archivo que se quiere importar
        [filename, path] = uigetfile({'*.mp3;*.wav'}); 
        % figure(app.UIFigure);
        fullFileName = fullfile(path, filename);  % Construye la ruta completa del archivo
        
        % Recuperar los datos importados
        [signal, sample_rate] = audioread(fullFileName);
    end
    
    function new_sample_rate = change_sample_rate()
        dlgtitle = 'Cambio en la frecuencia de muestreo';
        prompt = {'Nueva frecuencia de muestreo'};
        dims = [1 35];
        defect_input = {'48000'};
        answer = inputdlg(prompt,dlgtitle,dims,defect_input);
        new_sample_rate = str2num(answer{1});
    end
    
    function shifted_signal = desplazar(signal, sample_rate)
 
        % shiftSignalForLoops: Shifts a signal by a specified number of samples or seconds using for loops
        % signal: The original signal to be shifted
        % shiftValue: The number of samples to shift or time in seconds to shift.
        % Fs: The sampling frequency in Hz.
        % isTimeShift: A boolean indicating if 'shiftValue' is in seconds (true) or samples (false).
    
        dlgtitle = 'Desplazar señal';
        prompt = {'Valor del desplazamiento', '0 para desplazamiento a la izquierda o 1 para desplazamiento a la derecha', '0 para desplazamiento por muestra o 1 para desplazamiento en segundos'};
        dims = [1 35];
        defect_input = {'1','0','1'};
        answer = inputdlg(prompt,dlgtitle,dims,defect_input);
        
        
        shift_value = str2num(answer{1});    % Valor del desplazamiento
        left_right_shifting = str2num(answer{2});    % Sentido del desplazamiento
        sample_second_shifting = str2num(answer{3});    % Referencia del desplazamiento: si en muestras o en segundos
    
        
        % Convert shift value from time (seconds) to samples if necessary
        if sample_second_shifting
            % Convert seconds to number of samples
            shift_value = round(shift_value * sample_rate);
        else
            % Use the given number of samples directly
        end
        
        % Get the length of the original signal
        signalLength = length(signal);
        
        % Adjust length for the shifted signal depending on the direction of the shift
        
        if left_right_shifting == 0
            % Advance: Add additional space to the left (beginning)
            shiftedSignalLength = signalLength + shift_value;
            shifted_signal = zeros(1, shiftedSignalLength);
            
            % Fill the shifted signal using the for loop
            for i = 1:signalLength
                shifted_signal(i) = signal(i);
            end
        
        elseif left_right_shifting == 1
            % Delay: Add additional space to the right (end)
            shiftedSignalLength = signalLength + shift_value;
            shifted_signal = zeros(1, shiftedSignalLength);
            
            % Fill the shifted signal using the for loop
            for i = 1:signalLength
                shifted_signal(i + shift_value) = signal(i);
                signal = shifted_signal;
            end
        
        else
            % No shift: Simply copy the original signal
            shifted_signal = signal;
        end
    end

    function signal = sumar(signal1, signal2)
        % Determine the length of each signal
        len1 = length(signal1);
        len2 = length(signal2);
    
        % Equalize lengths by padding with zeros
        if len1 > len2
            signal2 = [signal2, zeros(1, len1 - len2)];
        elseif len2 > len1
            signal1 = [signal1, zeros(1, len2 - len1)];
        end
    
        % Sum the two signals
        signal = signal1 + signal2;
    end

    function signal = multiplicar(signal1, signal2)
        % Determine the length of each signal
        len1 = length(signal1);
        len2 = length(signal2);
    
        % Equalize lengths by padding with zeros
        if len1 > len2
            signal2 = [signal2, zeros(1, len1 - len2)];
        elseif len2 > len1
            signal1 = [signal1, zeros(1, len2 - len1)];
        end
    
        % Multiply the two signals element-wise
        signal = signal1 .* signal2;
    
    end
    
    function signal = invertir_senal(signal)
        % Reverse the order of the signal
        signal = signal(end:-1:1);
    end

    function signal = stereo_from_mono(signal_1, signal_2)
        % Equalize lengths by padding the shorter signal with zeros
        len1 = length(signal_1);
        len2 = length(signal_2);
        
        if len1 > len2
            signal_2 = [signal_2, zeros(1, len1 - len2)];
        elseif len2 > len1
            signal_1 = [signal_1, zeros(1, len2 - len1)];
        end
    
        % Combine the two mono signals into a stereo signal using the
        % transpose
        signal = [signal_1.' signal_2.'];
    end

end

