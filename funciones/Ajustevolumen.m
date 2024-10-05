function [prosig,prosigFs] = Ajustevolumen(datain, Fsin, potenciometro, modo)
    % Normalización del valor del potenciometro
    volume = potenciometro / 100;
    
    % Obtener el tamaño de la señal de entrada
    [numSamples, numChannels] = size(datain);  % numChannels será 1 para mono y >1 para estéreo
    
    % Ajuste de volumen según el modo
    if strcmp(modo, 'Amplitud constante')
        prosig = datain * volume;
        
    elseif strcmp(modo, 'Amplitud linealmente creciente')
        % Genera el vector de volumen que crece linealmente de 0 a volume
        volm = linspace(0, volume, numSamples)';
        
        % Si la señal es estéreo (más de 1 canal), replicamos el vector de volumen
        volm = repmat(volm, 1, numChannels);  % Ajusta el tamaño de volm para que coincida con datain
        
        % Aplicar ajuste de volumen a la señal
        prosig = datain .* volm;
        
    elseif strcmp(modo, 'Amplitud linealmente decreciente')
        % Genera el vector de volumen que decrece linealmente de volume a 0
        volm = linspace(volume, 0, numSamples)';
        
        % Si la señal es estéreo (más de 1 canal), replicamos el vector de volumen
        volm = repmat(volm, 1, numChannels);  % Ajusta el tamaño de volm para que coincida con datain
        
        % Aplicar ajuste de volumen a la señal
        prosig = datain .* volm;
        prosigFs = Fsin;
    end
end
