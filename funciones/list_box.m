function [list_of_items, selected_item, selected_signal, selected_sample_rate, selected_number_of_points] = list_box(signalsData,list_box_items, list_box_value)
    disp('You are in the list box');
    list_of_items = list_box_items;
    selected_item = list_box_value;
    
    % Encontrar el índice del ítem seleccionado
    selected_signal_idex = strcmp(list_box_items, selected_item);
    % selected_signal_idex = find(strcmp(list_box_items, selected_item));

    % Retrieve signal and sample rate
    signalData = signalsData{selected_signal_idex};  

    % 'signalData' contains {signal, sample rate}
    selected_signal = signalData{1};  % The actual signal data
    selected_sample_rate = signalData{2};  % The sample rate
    selected_number_of_points = (1:length(selected_signal));

    % graficar
end
