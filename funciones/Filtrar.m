function [filtrada,t,datain,freqmuestreoin] = Filtrar(entrada,selectedItem,graficain,signalsData,windowsize)
                     
            

            % Encontrar el índice del ítem seleccionado
            selectedSignalIndex = find(strcmp(entrada, selectedItem));
            signalData = signalsData{selectedSignalIndex};  % Retrieve signal and sample rate
            datain = signalData{1};
            freqmuestreoin = signalData{2};
           
              
            t= 0:1/signalData{2}:(length(signalData{1})-1)/signalData{2};%vector de tiempos para graficar
            plot(graficain, t, signalData{1});
            ventana = windowsize;
            

    selectedButton = app.FilterButtonGroup.SelectedObject;
    
    switch selectedButton.Text
        case 'FIR1'
            % Código para aplicar FIR1
        case 'FIR2'
            % Código para aplicar FIR2
        case 'FIR3'
            % Código para aplicar FIR3
        case 'IIR1'
            % Código para aplicar IIR1
    end


            
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