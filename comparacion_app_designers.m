% function GrabarButtonPushed(app, event)
function GrabarButtonPushed(app, event)
           [app.x_in, app.sample_rate] = grabar_pushed_button(app.UIAxes);
           app.t_in = (1:length(app.x_in));
end

% Button pushed function: ReproducirButton
function ReproducirButtonPushed(app, event)
            reproducir_pushed_button(app.x_in, app.sample_rate);
end

% Button pushed function: GuardarButton
function GuardarButtonPushed(app, event)
   % Ingresar los parámetros para grabar el audio
   prompt = {'Nombre del archivo:'};
   dlgtitle = 'Guardar archivo';
   dims = [1 35];
   definput = {'archivo'};
   answer = inputdlg(prompt, dlgtitle, dims, definput);
  
   % Recuperar parámetros de la caja de diálogo
   nombre_archivo = (answer{1});
   nombre_archivo_completo = [nombre_archivo, '.wav'];
   disp(nombre_archivo_completo);
   audiowrite(nombre_archivo_completo, app.x_in, app.sample_rate);
   % Increment the signal count and add to the cell array
   app.num_signals = length(app.signalsData) + 1;
   app.signalsData{app.num_signals} = {app.x_in, app.sample_rate};
   % Add an entry to the ListBox to represent this signal
   app.num_grabaciones = app.num_grabaciones + 1;
   signalName = ['Grabación', num2str(app.num_grabaciones)];  % Name the signal (e.g., "Signal 1", "Signal 2")
   app.ListBox.Items{app.num_signals} = signalName;     % Add to the List Box
   app.SealdeentradaDropDown.Items{app.num_signals} = signalName;  %Add to the Input Signal Dropdown Button
  
end


% Button down function: UIAxes
function UIAxesButtonDown(app, event)
  
end


% Button pushed function: ImportarButton
function ImportarButtonPushed(app, event)
   [filename, path] = uigetfile({'*.mp3;*.wav'});
   figure(app.UIFigure);
   fullFileName = fullfile(path, filename);  % Construye la ruta completa del archivo
  
   % Recuperar los datos importados
   [app.x_in, app.sample_rate] = audioread(fullFileName);
   app.t_in = (1:length(app.x_in));
   % sound(data, sample_rate);
   % Graficar Canal 1 en UIAxes de App Designer
   plot(app.UIAxes, app.x_in(:,1), 'v');
   title(app.UIAxes, 'Señal Estereofónica: Canal 1');
   xlabel(app.UIAxes, 'n');
   grid(app.UIAxes, 'on');
   % Increment the signal count and add to the cell array
   app.num_signals = length(app.signalsData) + 1;
   app.num_importes = app.num_importes + 1;
   app.signalsData{app.num_signals} = {app.x_in, app.sample_rate};
   % Add an entry to the ListBox to represent this signal
   signalName = ['Importe', num2str(app.num_importes)];  % Name the signal (e.g., "Signal 1", "Signal 2")
   app.ListBox.Items{app.num_signals} = signalName;     % Add to the List Box
   app.SealdeentradaDropDown.Items{app.num_signals} = signalName;  %Add to the Input Signal Dropdown Button
   app.Sealdeentrada1DropDown.Items{app.num_signals} = signalName;
   app.Sealdeentrada2DropDown.Items{app.num_signals} = signalName;
  
end

% Value changed function: TipodesealDropDown
function TipodesealDropDownValueChanged(app, event)
   app.valor = app.TipodesealDropDown.Value;
end

% Button pushed function: GenerarButton
function GenerarButtonPushed(app, event)
   % Botón que genera las funciones del dropdown menu
   [app.x_in, app.t_in, app.sample_rate] = generar_funciones(app.UIAxes, app.valor);
   % [app.x_in] = preprocesamiento(app.x_in);
   % Suppose 'signal' is your generated/recorded signal and 'Fs' is the sample rate
   % Increment the signal count and add to the cell array
   app.num_signals = length(app.signalsData) + 1;
   app.num_sinteticas = app.num_sinteticas + 1;
   app.signalsData{app.num_signals} = {app.x_in, app.sample_rate};
  
   % Add an entry to the ListBox to represent this signal
   signalName = ['Sintética', num2str(app.num_sinteticas)];  % Name the signal (e.g., "Signal 1", "Signal 2")
   app.ListBox.Items{app.num_signals} = signalName;     % Add to the List Box
   app.SealdeentradaDropDown.Items{app.num_signals} = signalName;  %Add to the Input Signal Dropdown Button
   app.Sealdeentrada1DropDown.Items{app.num_signals} = signalName;
   app.Sealdeentrada2DropDown.Items{app.num_signals} = signalName;
end

% Value changed function: ListBox
function ListBoxValueChanged(app, event)
   app.selectedItem = app.ListBox.Value;
   app.list_of_items = app.ListBox.Items;
   disp('You are in the list box');
   % Encontrar el índice del ítem seleccionado
   % selectedSignalIndex = strcmp(app.list_of_items, app.selectedItem);
   selectedSignalIndex = find(strcmp(app.ListBox.Items, selectedItem));
   signalData = app.signalsData{selectedSignalIndex};  % Retrieve signal and sample rate
   % 'signalData' contains {signal, sample rate}
   selectedSignal = signalData{1};  % The actual signal data
   selectedSampleRate = signalData{2};  % The sample rate
   selectedNumberofpoints = (1:length(selectedSignal));
   stem(app.UIAxes, selectedNumberofpoints, selectedSignal);
   title(app.UIAxes, 'Selected signal');
   xlabel(app.UIAxes, 'n');
   grid(app.UIAxes, 'on');
  
   % Now you can do something with the selected signal and sample rate, like playing it
   sound(selectedSignal, selectedSampleRate);
end


% Button pushed function: FiltrarButton
       function FiltrarButtonPushed(app, event)
                   
           selectedItem = app.SealdeentradaDropDown.Value;
           % Encontrar el índice del ítem seleccionado
           selectedSignalIndex = find(strcmp(app.SealdeentradaDropDown.Items, selectedItem));
           signalData = app.signalsData{selectedSignalIndex};  % Retrieve signal and sample rate
           app.datain = signalData{1};
           app.freqmuestreoin = signalData{2};
         
            
           t= 0:1/signalData{2}:(length(signalData{1})-1)/signalData{2};%vector de tiempos para graficar
           plot(app.UIAxes3_2, t, signalData{1});
           ventana = app.TamaodelaventanaSpinner.Value;
          
          
           if app.FIR1Button.Value
                   h= transpose (readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet','Filtro FIR 1'));
                   app.filtrada= convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
                  
           elseif app.FIR2Button.Value
                   h= transpose (readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet','Filtro FIR 2'));
                   app.filtrada= convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
                  
           elseif app.FIR3Button.Value
                   h= transpose (readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet','Filtro FIR 3'));
                   app.filtrada=convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
                  
           elseif app.FIR4Button.Value
                   h= transpose (readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet','Filtro FIR 4'));
                   app.filtrada=convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
                  
           elseif app.FIRnButton.Value
                   h= app.valor_usuario;
                   app.filtrada=convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques                  
                
           elseif app.IIR1Button.Value
                   T = readtable('Filtros_Prueba_Proyecto1_Entregable.xlsx','Sheet','Filtro IIR 1');
                   valores= cellfun(@str2double,T.Valores);
                   coeficiente= [T.Coeficiente];
                   okb= 1;
                   oka= 1;
                   for i= 1:length(valores)
                       if contains(coeficiente{i}, 'b')
                          b(okb)=valores(i);
                          okb= okb+1;
                       elseif contains(coeficiente{i}, 'a')
                            a(oka)=valores(i);
                            oka= oka+1;
                       end
                   end
            app.filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
           
             elseif app.IIR2Button.Value
                   T = readtable('Filtros_Prueba_Proyecto1_Entregable.xlsx','Sheet','Filtro IIR 2');
                   valores= cellfun(@str2double,T.Valores);
                   coeficiente= [T.Coeficiente];
                   okb= 1;
                   oka= 1;
                   for i= 1:length(valores)
                       if contains(coeficiente{i}, 'b')
                          b(okb)=valores(i);
                          okb= okb+1;
                       elseif contains(coeficiente{i}, 'a')
                            a(oka)=valores(i);
                            oka= oka+1;
                       end
                   end
            app.filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
           
            elseif app.IIR3Button.Value
                   T = readtable('Filtros_Prueba_Proyecto1_Entregable.xlsx','Sheet','Filtro IIR 3');
                   valores= cellfun(@str2double,T.Valores);
                   coeficiente= [T.Coeficiente];
                   okb= 1;
                   oka= 1;
                   for i= 1:length(valores)
                       if contains(coeficiente{i}, 'b')
                          b(okb)=valores(i);
                          okb= okb+1;
                       elseif contains(coeficiente{i}, 'a')
                            a(oka)=valores(i);
                            oka= oka+1;
                       end
                   end
            app.filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
           
            elseif app.IIR4Button.Value
                   T = readtable('Filtros_Prueba_Proyecto1_Entregable.xlsx','Sheet','Filtro IIR 4');
                   valores= cellfun(@str2double,T.Valores);
                   coeficiente= [T.Coeficiente];
                   okb= 1;
                   oka= 1;
                   for i= 1:length(valores)
                       if contains(coeficiente{i}, 'b')
                          b(okb)=valores(i);
                          okb= okb+1;
                       elseif contains(coeficiente{i}, 'a')
                            a(oka)=valores(i);
                            oka= oka+1;
                       end
                   end
            app.filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
           
           elseif app.IIRkButton.Value
               
                   b = app.valor_usuariobk;
                   a= app.valor_usuarioak;
                  
             app.filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
                 
           end
       end

% Button pushed function: CoeficientesFIRButton
       function CoeficientesFIRButtonPushed(app, event)
           respuesta = inputdlg('Ingresar los valores h(n) separados por espacio: ', 'Filter FIR - h(n)', [1 50]);
           int_valor_usuario = str2num(respuesta{:});
           int_valor_usuario = int_valor_usuario.';
           app.valor_usuario= int_valor_usuario;
          
       end
       % Button pushed function: CoeficientesIIRButton
       function CoeficientesIIRButtonPushed(app, event)
           respuesta_ab = inputdlg({'Ingresar los valores ak separados por espacio: ','Ingresar los valores bk separados por espacio: '}, 'Filter IIR - ak & bk', [1 50; 1 50]);
           int_valor_usuarioak = str2num(respuesta_ab{1});
           int_valor_usuariobk = str2num(respuesta_ab{2});
           int_valor_usuarioak = int_valor_usuarioak.';
           int_valor_usuariobk = int_valor_usuariobk.';
           app.valor_usuarioak = int_valor_usuarioak;
           app.valor_usuariobk = int_valor_usuariobk;
       end


% Button pushed function: ReproducirsealdeentradaButton
function ReproducirsealdeentradaButtonPushed(app, event)
 sound(app.datain, app.freqmuestreoin);
end


% Value changed function: SealdeentradaDropDown
function SealdeentradaDropDownValueChanged(app, event)
   value = app.SealdeentradaDropDown.Value;
end

% Value changed function: MododenormalizacinDropDown
function MododenormalizacinDropDownValueChanged(app, event)
   value = app.MododenormalizacinDropDown.Value;
   app.x_in = preprocesamiento(app.x_in, value);
end




% Button pushed function: NormalizeButton
function NormalizeButtonPushed(app, event)
   stem(app.UIAxes, app.t_in, app.x_in);
   title(app.UIAxes, 'Señal Estereofónica: Canal 1');
   xlabel(app.UIAxes, 'n');
   grid(app.UIAxes, 'on');
end

% Drop down opening function: SealdeentradaDropDown
function SealdeentradaDropDownOpening(app, event)
  
end

% Value changed function: Sealdeentrada1DropDown
function Sealdeentrada1DropDownValueChanged(app, event)
   value = app.Sealdeentrada1DropDown.Value;
   disp(value);
   disp(app.Sealdeentrada1DropDown.Items);
   % Encontrar el índice del ítem seleccionado
   selectedSignalIndex = strcmp(app.Sealdeentrada1DropDown.Items, value);
   signalData = app.signalsData{selectedSignalIndex};  % Retrieve signal and sample rate
   % 'signalData' contains {signal, sample rate}
   selectedSignal = signalData{1};  % The actual signal data
   selectedSampleRate = signalData{2};  % The sample rate
   selectedNumberofpoints = (1:length(selectedSignal));
  
   app.signal_1 = selectedSignal;
   app.sample_rate_1 = selectedSampleRate;
   app.length_1 = selectedNumberofpoints;
  
   stem(app.UIAxes3_3, selectedNumberofpoints, selectedSignal);
   title(app.UIAxes3_3, 'Signal 1');
   xlabel(app.UIAxes3_3, 'n');
   grid(app.UIAxes3_3, 'on');
  
end

% Value changed function: Sealdeentrada2DropDown
function Sealdeentrada2DropDownValueChanged(app, event)
   value = app.Sealdeentrada2DropDown.Value;
   disp(value);
   disp(app.Sealdeentrada2DropDown.Items);
   % Encontrar el índice del ítem seleccionado
   selectedSignalIndex = strcmp(app.Sealdeentrada2DropDown.Items, value);
   signalData = app.signalsData{selectedSignalIndex};  % Retrieve signal and sample rate
   % 'signalData' contains {signal, sample rate}
   selectedSignal = signalData{1};  % The actual signal data
   selectedSampleRate = signalData{2};  % The sample rate
   selectedNumberofpoints = (1:length(selectedSignal));
  
   stem(app.UIAxes3, selectedNumberofpoints, selectedSignal);
   title(app.UIAxes3, 'Signal 1');
   xlabel(app.UIAxes3, 'n');
   grid(app.UIAxes3, 'on');
  
end
% Button down function: UIAxes3_3
function UIAxes3_3ButtonDown(app, event)
  
end
% Button down function: UIAxes3
function UIAxes3ButtonDown(app, event)
  
end
% Button down function: UIAxes4
function UIAxes4ButtonDown(app, event)
  
end

