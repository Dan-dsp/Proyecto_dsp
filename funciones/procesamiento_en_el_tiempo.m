function signal = procesamiento_en_el_tiempo(tipo_de_procesamiento)
    switch tipo_de_procesamiento
        case 'desplazar'
            signal = desplazar();
        case 'sumar'
            a
        case 'multiplicar'
            a
        case 'inversa'
            a
        case 'estereo a mono'
            a
        case 'mono a estereo'
            a
        case 'estereo con dos monos'
            a
        case 'volumen del audio'
            a
    end
end

    function signal = desplazar()
    dlgtitle = 'Desplazar señal';
    prompt = {'Amplitud:','Frecuencia inicial:','Frecuencia final:', 'Frecuencia de muestreo:' ,'Duración de la señal:'};
    dims = [1 35];
    defect_input = {'1','100','22050','44100','2'};
    answer = inputdlg(prompt,dlgtitle,dims,defect_input);
    

    A = str2num(answer{1});    % Amplitude of the chirp
    f0 = str2num(answer{2});    % Initial frequency in Hz
    f1 = str2num(answer{3});    % Final frequency in Hz
    Fs = str2num(answer{4});    % Sampling frequency in Hz
    T = str2num(answer{5});    % Duration of the signal in seconds

end