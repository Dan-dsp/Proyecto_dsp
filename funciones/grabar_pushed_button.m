function [x_in, sample_rate] = grabar_pushed_button(axes)

% Ingresar los parámetros para grabar el audio
            prompt = {'Duración (segundos):', 'Frecuencia de muestreo Fs (Hz):', 'Número total de canales (1: mono, 2: estéreo):'};
            dlgtitle = 'Recording Parameters';
            dims = [1 35];
            definput = {'3', '44100', '2'};
            answer = inputdlg(prompt, dlgtitle, dims, definput);
            
            % Recuperar parámetros de la caja de diálogo
            duration = str2double(answer{1});
            sample_rate = str2double(answer{2});
            num_channels = str2double(answer{3});

            % Grabar audio
            recObj = audiorecorder(sample_rate, 16, num_channels);
            disp('Start recording...');
            recordblocking(recObj, duration);
            disp('Recording complete.');

            % Recuperar la señal de audio en un vector
            x_in = 32*getaudiodata(recObj);
            
            % Graficar Canal 1 en UIAxes de App Designer
            plot(axes, x_in(:,1), 'v');
            title(axes, 'Señal Estereofónica: Canal 1');
            xlabel(axes, 'n');
            grid(axes, 'on');


end