function [x_processed] = preprocesamiento(x, case_variable)

    [num_rows, num_columns] = size(x);
    type_of_signal = strings(1);

    if num_columns == 1
        type_of_signal = 'mono';
    elseif num_columns == 2
        type_of_signal = 'stereo';
    else
        disp('Your signal is neither stereo nor mono');
    end

    switch case_variable
        case '-------'
            x_processed = x;
        case 'Between -1 y 1'
            x_processed = normalizacion(x, num_rows, num_columns);
        case 'Between 0 and 1'
            x_processed = normalizacion_positive(x, num_rows, num_columns);
        case 'Standard normalization'
            x_processed = normalizacion_standard(x, num_rows, num_columns);
    end

    % x_processed = missing_values(x_processed, num_rows, num_columns);

    %Se realiza la normalización
    % x_normalized = normalizacion(x);
    

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
    disp('You are using the normalize function -1 to 1');
    % Normalizar señal de audio entre -1 y 1
    x_normalized = zeros(num_rows, num_columns);

    for i = 1:num_columns
        x_normalized(:,i) = (2*(x(:,i)-min(x(:,i)))/(max(x(:,i))-min(x(:,i))))-1;
    end
end

function [x_normalized] = normalizacion_positive(x, num_rows, num_columns)
    disp('You are using the normalize function 0 to 1');
    % Normalizar señal de audio entre -1 y 1
    x_normalized = zeros(num_rows, num_columns);

    for i = 1:num_columns
        x_normalized(:,i) = (x(:,i)-min(x(:,i)))/(max(x(:,i))-min(x(:,i)));
    end
end

function [x_normalized] = normalizacion_standard(x, num_rows, num_columns)
    disp('You are using the normalize standard function');
    % Normalizar señal de audio entre -1 y 1
    x_normalized = zeros(num_rows, num_columns);

    for i = 1:num_columns
        x_normalized(:,i) = (x(:,i)-mean(x(:,i)))/std(x(:,i));
    end
    
end

function [x_non_missing_values] = missing_values(x, num_rows, num_columns)
    disp('You are using the missing_values function');

    % Initialize an empty array to store non-missing values
    x_temp_array = zeros(num_rows, num_columns);
    % Creates a variable to track the new length of the vector
    new_length_i = 0;
    for j = 1:num_columns    
        % Loop through the input array to filter out missing values
        for i = 1:num_rows
            if (~isnan(x(i, j))) || (x(i,j) ~= Inf)
                % Append the non-missing value to the output array
                x_temp_array(i, j) = x(i, j);
                % Vector's length tracking
                new_length_i = new_length_i + 1;
            end
        end
    end
    % Assignement of the new vector with the new vector's length
    x_non_missing_values = x_temp_array(1:new_length_i, 1:num_columns);
end

