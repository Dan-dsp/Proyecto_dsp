function  [x, t, sample_rate] = generar_funciones(axes, value)
    switch value
        case 'Chirp'
            dlgtitle = 'Chirp Signal Parameters';
            prompt = {'Amplitud:','Frecuencia inicial:','Frecuencia final:', 'Frecuencia de muestreo:' ,'Duración de la señal:'};
            dims = [1 35];
            defect_input = {'1','100','22050','44100','2'};
            answer = inputdlg(prompt,dlgtitle,dims,defect_input);
            
    
            A = str2num(answer{1});    % Amplitude of the chirp
            f0 = str2num(answer{2});    % Initial frequency in Hz
            f1 = str2num(answer{3});    % Final frequency in Hz
            Fs = str2num(answer{4});    % Sampling frequency in Hz
            T = str2num(answer{5});    % Duration of the signal in seconds
            
            t = 0:1/Fs:T;      % Time vector from 0 to T with steps of 1/Fs
            x = chirp(t, f0, T, f1);
            
            % plot(app.UIAxes, app.x_in(:,1), 'v');
   
            
            sample_rate = Fs;
            
    
            stem(axes, t, x);
            title(axes, 'Señal Estereofónica: Canal 1');
            xlabel(axes, 'n');
            grid(axes, 'on');
            
    
         case 'Seno'
            disp('Se seleccionó la Seno');
            dlgtitle = 'Sine Signal Parameters';
            prompt = {'Ganancia:','Frecuencia Análoga:','Frecuencia Muestreo:', 'Fase (rad)' ,'Desplazamiento:','n_inicio:','n_final:' };
            dims = [1 35];
            defect_input = {'1','4410','44100','0','0', '0', '50000'};
            answer = inputdlg(prompt, dlgtitle, dims, defect_input);
            
            A=str2num(answer{1}); % Ganancia de la exponencial
            Fa=str2num(answer{2}); % Frecuencia análoga
            Fs=str2num(answer{3}); % Frecuencia de muestreo
            
            Fase=str2num(answer{4}); % Fase de la señal análoga (Rad)
            
            n0=str2num(answer{5});
            ni=str2num(answer{6});
            nf=str2num(answer{7});
            
            % disp(answer{1});
            % disp(answer{6});
            
            Ts=1/Fs; %Periodo de muestreo
            
            n6=ni:nf; %Instantes de tiempo
            
            t = n6*Ts; % Time vector en segundos dependiente del tiempo de muestreo

            variable = (2*pi*Fa*(n6-n0)/Fs+ Fase);
            result = 2*pi*Fa/Fs+ Fase;
            x = A*[sin(2*pi*Fa*t + Fase)]; %/(2*pi*Fa*(-55)/Fs+ Fase);
            
            sample_rate = Fs;

            stem(axes, n6,x);
            % xlabel('n'); ylabel('x(n)'); title(['Señal Senoidal, Fa=' num2str(Fa) ' Fs= ' num2str(Fs)]);grid on
            title(axes, 'Señal seno');
            xlabel(axes, 'n');
            grid(axes, 'on');
         case 'Coseno'
            disp('Se seleccionó la Coseno');
            % Agregar código para manejar la selección de Opción 1
            dlgtitle = 'Sine Signal Parameters';
            prompt = {'Ganancia:','Frecuencia Análoga:','Frecuencia Muestreo:', 'Fase (rad)' ,'Desplazamiento:','n_inicio:','n_final:' };
            dims = [1 35];
            defect_input = {'1','2205','44100','0','0', '0', '50000'};
            answer = inputdlg(prompt,dlgtitle,dims,defect_input);
            
            A=str2num(answer{1}); % Ganancia de la exponencial
            Fa=str2num(answer{2}); % Frecuencia análoga
            Fs=str2num(answer{3}); % Frecuencia de muestreo
            
            Fase=str2num(answer{4}); % Fase de la señal análoga (Rad)
            
            n0=str2num(answer{5});
            ni=str2num(answer{6});
            nf=str2num(answer{7});
            
            % disp(answer{1});
            % disp(answer{6});
            
            Ts=1/Fs; %Periodo de muestreo

            
            n6=ni:nf; %Instantes de tiempo
            variable = (2*pi*Fa*(n6-n0)/Fs+ Fase);
            result = 2*pi*Fa/Fs+ Fase
            x = A*[cos(2*pi*Fa*(n6-n0)/Fs+ Fase)]; %/(2*pi*Fa*(-55)/Fs+ Fase);
            
            sample_rate = Fs;
            t = n6;

            stem(axes, t,x);
            title(axes, 'Señal Estereofónica: Canal 1');
            xlabel(axes, 'n');
            grid(axes, 'on');
         case 'Diente de sierra'
            disp('Se seleccionó la Diente de sierra');
            % Agregar código para manejar la selección de Opción 1
            dlgtitle = 'Sine Signal Parameters';
            prompt = {'Ganancia:','Frecuencia Análoga:','Frecuencia Muestreo:', 'Fase (rad)' ,'Desplazamiento:','n_inicio:','n_final:' };
            dims = [1 35];
            defect_input = {'1','100','44100','0','0', '0', '50000'};
            answer = inputdlg(prompt,dlgtitle,dims,defect_input);
            
            A=str2num(answer{1}); % Ganancia de la exponencial
            Fa=str2num(answer{2}); % Frecuencia análoga
            Fs=str2num(answer{3}); % Frecuencia de muestreo
            
            Fase=str2num(answer{4}); % Fase de la señal análoga (Rad)
            
            n0=str2num(answer{5});
            ni=str2num(answer{6});
            nf=str2num(answer{7});
            
            % disp(answer{1});
            % disp(answer{6});
            
            Ts=1/Fs; %Periodo de muestreo
            
            n6=ni:nf; %Instantes de tiempo
            variable = (2*pi*Fa*(n6-n0)/Fs+ Fase);
            result = 2*pi*Fa/Fs+ Fase;
            x = A * sawtooth(2 * pi * Fa * (n6 - n0) / Fs + Fase);
            
            sample_rate = Fs;
            t = n6;

            stem(axes, n6,x);
            title(axes, 'Diente de sierra');
            xlabel(axes, 'n');
            grid(axes, 'on');
            
            
         case 'Rampa'
            disp('Se seleccionó la Rampa');
            dlgtitle = 'Ramp Signal Parameters';
            prompt = {'Pendiente:','Desplazamiento','n_inicio:','n_final:', 'Frecuencia Muestreo:'};
            dims = [1 35];
            defect_input = {'1','0', '0', '50000', '44100'};
            answer = inputdlg(prompt,dlgtitle,dims,defect_input);
            
            A=str2num(answer{1}); % Pendiente de la rampa
            n0=str2num(answer{2});
            ni=str2num(answer{3});
            nf=str2num(answer{4});
            Fs = str2num(answer{5});
            
            n3=ni:nf;  % Instantes de tiempo
            x =A*(n3-n0);
            
            sample_rate = Fs;
            t = n3;
            
            stem(axes, n3,x);
            % xlabel('n'); ylabel('x(n)'); title(['Señal Senoidal, Fa=' num2str(Fa) ' Fs= ' num2str(Fs)]);grid on
            title(axes, 'Rampa');
            xlabel(axes, 'n');
            grid(axes, 'on');
         case 'Escalón'
            disp('Se seleccionó la Escalón');
            dlgtitle = 'Step Signal Parameters';
            prompt = {'Amplitud:','Desplazamiento','n_inicio:','n_final:', 'Frecuencia Muestreo:'};
            dims = [1 35];
            defect_input = {'1','0', '0', '50000', '44100'};
            answer = inputdlg(prompt,dlgtitle,dims,defect_input);
            
            A=str2num(answer{1});
            n0=str2num(answer{2});
            ni=str2num(answer{3});
            nf=str2num(answer{4});
            Fs = str2num(answer{5});
            
            x= A*[zeros(1,abs(ni)+n0)  ones(1, abs(nf)+1-n0)  ];
            
            n2=ni:nf;  % Instantes de tiempo
            
            sample_rate = Fs;
            t = n2;
        
            stem(axes, n2,x);
            % xlabel('n'); ylabel('x(n)'); title(['Señal Senoidal, Fa=' num2str(Fa) ' Fs= ' num2str(Fs)]);grid on
            title(axes, 'Señal Estereofónica: Canal 1');
            xlabel(axes, 'n');
            grid(axes, 'on');
    end
    % disp(['Sample rate:', num2str(Fs), 'Hz']);
end

