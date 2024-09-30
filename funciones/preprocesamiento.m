function [x_processed] = preprocesamiento(x)

    [num_rows, num_columns] = size(x);
    type_of_signal = strings(1);

    if num_columns == 1
        type_of_signal = 'mono';
    elseif num_columns == 2
        type_of_signal = 'stereo';
    else
        disp('Your signal is neither stereo nor mono');
    end

    %Se realiza la normalización
    % x_normalized = normalizacion(x);
    x_processed = normalizacion(x, num_rows, num_columns);

    % Se detectan y eliminan los datos faltantes, se registran solo los
    % datos que sean número & se eliminan los que sean infinitos

    % x_non_missing_values = missing_values(x_normalized);
    % x_processed = x_non_missing_values;

    % x_are_only_numbers = not_a_number(x_non_missing_values);
    % x_finite_values = infinite_values(x_are_only_numbers);

    % La variable normalizada y con datos preprocesados se retorna
    % x_processed = x_finite_values;

end

function [x_normalized] = normalizacion(x, num_rows, num_columns)
    disp('You are using the normalize function');
    % Normalizar señal de audio entre -1 y 1
    x_normalized = zeros(num_rows, num_columns);
    for i = 1:num_columns
        x_normalized(:,i) = (2*(x(:,i)-min(x(:,i)))/(max(x(:,i))-min(x(:,i))))-1;
    end
end

function [x_normalized] = normalizacion_positive(x)
    disp('You are using the normalize function');
    % Normalizar señal de audio entre -1 y 1
    x_normalized = (x-min(x))/(max(x)-min(x));
end

function [x_normalized] = normalizacion_standar(x)
    x_normalized = (x-mean(x))/std(x);
end

function [x_non_missing_values] = missing_values(x)
    disp('You are using the missing_values function');

    % Initialize an empty array to store non-missing values
    outputArray = zeros(1, length(x));
    % Creates a variable to track the new length of the vector
    new_length = 0;
    
    % Loop through the input array to filter out missing values
    for i = 1:length(x)
        if (x(i) ~= NaN) || (x(i) ~= Inf)
            % Append the non-missing value to the output array
            outputArray(i) = x(i);
            % Vector's length tracking
            new_length = new_length + 1;
        end
    end
    % Assignement of the new vector with the new vector's length
    x_non_missing_values = outputArray(1:new_length);
end

% function [x_are_only_numbers] = not_a_number(x)
%     disp('You are using the not a number function');
%     x_are_only_numbers = x;
% end
% 
% function [x_finite] = infinite_values(x)
%     disp('You are using the infinite function');
%     x_finite = x;
% end