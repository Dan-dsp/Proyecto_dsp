function [filsig,filsigFs] = firmanual(app,entrada, sample_rate, windowsize)
        filsigFs = sample_rate;
        respuesta = inputdlg('Ingresar los valores h(n) separados por espacio: ', 'Filter FIR - h(n)', [1 50]);
        h = str2num(respuesta{1});  % respuesta{1} es la cadena de entrada
        filsig = app.convolucion(entrada, h, windowsize, sample_rate);

end