    function [filsig, filsigFs] = filtrar(app,entrada, sample_rate, windowsize, filtroSeleccionado)
        % Inicializar variables de salida
        filsigFs = sample_rate;
    
        % Leer coeficientes de los filtros desde un archivo de Excel
        switch filtroSeleccionado
            case 'FIR1'
                h = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro FIR 1', 'Range', 'B6:B31'));
            case 'FIR2'
                h = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro FIR 2', 'Range', 'B6:B31'));
            case 'FIR3'
                h = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro FIR 3', 'Range', 'B6:B46'));
            case 'FIR4'
                h = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro FIR 4', 'Range', 'B6:B46'));
            case 'IIR1'
                h_numerador = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filro IIR 1', 'Range', 'B6:B11'));
                h_denominador = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filro IIR 1', 'Range', 'B13:B18'));
                h = {h_numerador, h_denominador};  % Usar los coeficientes proporcionados
            case 'IIR2'
                h_numerador = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro IIR 2', 'Range', 'B6:B11'));
                h_denominador = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro IIR 2', 'Range', 'B13:B18'));
                h = {h_numerador, h_denominador};  % Usar los coeficientes proporcionados
            case 'IIR3'
                h_numerador = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro IIR 3', 'Range', 'B7:B13'));
                h_denominador = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro IIR 3', 'Range', 'B15:B21'));
                h = {h_numerador, h_denominador};  % Usar los coeficientes proporcionados
            case 'IIR4'
                h_numerador = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro IIR 4', 'Range', 'B6:B12'));
                h_denominador = transpose(readmatrix('Filtros_Prueba_Proyecto1_Entregable.xlsx', 'Sheet', 'Filtro IIR 4', 'Range', 'B14:B20'));
                h = {h_numerador, h_denominador};  % Usar los coeficientes proporcionados
        end
    
        % Llamar a la funcin de convolucin
        if iscell(h)  % Para filtros IIR
            filsig = app.ec_diference(entrada, h{1}, h{2}, sample_rate);
        else  % Para filtros FIR
            filsig = app.convolucion(entrada, h, windowsize, sample_rate);
        end
    end
