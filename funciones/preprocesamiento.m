function [x_processed] = preprocesamiento(x)
    %Se realiza la normalización
    x_normalized = normalizacion(x);

    % Se detectan y eliminan los datos faltantes, se registran solo los
    % datos que sean número & se eliminan los que sean infinitos
    x_non_missing_values = missing_values(x_normalized);
    x_are_only_numbers = not_a_number(x_non_missing_values);
    x_finite_values = infinite_values(x_are_only_numbers);

    % La variable normalizada y con datos preprocesados se retorna
    x_processed = x_finite_values;

end

function [x_normalized] = normalizacion(x)
    disp('You are using the normalize function');
    % Normalizar señal de audio entre -1 y 1
    % x_normalized = (2*(x-min(x))/(max(x)-min(x)))-1;
    x_normalized = x;
end

function [x_non_missing_values] = missing_values(x)
    disp('You are using the missing_values function');
    x_non_missing_values = x;
end

function [x_are_only_numbers] = not_a_number(x)
    disp('You are using the not a number function');
    x_are_only_numbers = x;
end

function [x_finite] = infinite_values(x)
    disp('You are using the infinite function');
    x_finite = x;
end