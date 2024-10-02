function [filtrada,datain,freqmuestreoin] = filtrar(entrada,selectedItem,graficain,signalsData,windowsize,filtroSeleccionado,app)
                     
            

            % Encontrar el índice del ítem seleccionado
            selectedSignalIndex = find(strcmp(entrada, selectedItem));
            signalData = signalsData{selectedSignalIndex};  % Retrieve signal and sample rate
            datain = signalData{1};
            freqmuestreoin = signalData{2};
           
              
            t= 0:1/signalData{2}:(length(signalData{1})-1)/signalData{2};%vector de tiempos para graficar
            plot(graficain, t, signalData{1});
            ventana = windowsize;
           
     
    switch filtroSeleccionado
        case 'FIR1'
            h= transpose (readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet','Filtro FIR 1'));
            filtrada= convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
        case 'FIR2'            
            h= transpose (readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet','Filtro FIR 2'));
            filtrada= convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
        case 'FIR3'
             h= transpose (readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet','Filtro FIR 3'));
             filtrada=convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
        case 'FIR4'
            h= transpose (readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet','Filtro FIR 4'));
            filtrada=convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
        case 'FIR(n)'
            h= app.valor_usuario;
            filtrada=convolucion(app, signalData{1}, h, ventana, signalData{2}); %convoluciona por bloques
        case 'IIR1'
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
             filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});

        case 'IIR2'            
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
             filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
             
        case 'IIR3'
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
             filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
             
        case 'IIR4'
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
             filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
             
        case 'IIR(n)'

               b = app.valor_usuariobk;
                    a= app.valor_usuarioak;
                    
             filtrada= ec_diference(app,signalData{1}, a, b, signalData{2});
                   
    end