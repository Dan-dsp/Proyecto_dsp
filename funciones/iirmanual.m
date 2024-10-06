function [filsig,filsigFs] = iirmanual(app,entrada, sample_rate)
        filsigFs = sample_rate;
        respuesta_ab = inputdlg({'Ingresar los valores ak separados por espacio: ','Ingresar los valores bk separados por espacio: '}, 'Filter IIR - ak & bk', [1 50; 1 50]);
        h_numerador = str2num(respuesta_ab{1});  % respuesta{1} es la cadena de entrada
        h_denominador = str2num(respuesta_ab{2});
        h = {h_numerador, h_denominador};  % Usar los coeficientes proporcionados
        filsig = app.ec_diference(entrada, h{1}, h{2}, sample_rate);

end