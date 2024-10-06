function [signal, sample_rate, app_list_box_items, app_num_signals, app_SealdeentradaDropDown_Items, app_Sealdeentrada1DropDown_Items, app_Sealdeentrada2DropDown_Items, app_DropDown_Items, app_signalsData, app_num_sinteticas, app_num_importes, app_num_grabaciones] = signal_count_in_list_box(app_signalsData, app_list_box_items, app_num_sinteticas, app_num_importes, app_num_grabaciones, signal, sample_rate, type_of_signal, app_SealdeentradaDropDown_Items, app_Sealdeentrada1DropDown_Items, app_Sealdeentrada2DropDown_Items, app_DropDown_Items)
    app_num_signals = length(app_signalsData) + 1;
    app_signalsData{app_num_signals} = {signal, sample_rate};
   
    switch type_of_signal
        case 'sintetica'
            app_num_sinteticas = app_num_sinteticas + 1;
            signalName = ['Synth', num2str(app_num_sinteticas)];  % Name the signal (e.g., "Signal 1", "Signal 2")
            app_list_box_items{app_num_signals} = signalName;     % Add to the List Box
            app_SealdeentradaDropDown_Items{app_num_signals} = signalName;  %Add to the Input Signal Dropdown Button
            app_Sealdeentrada1DropDown_Items{app_num_signals} = signalName;
            app_Sealdeentrada2DropDown_Items{app_num_signals} = signalName;
            app_DropDown_Items{app_num_signals} = signalName;
        case 'importada'
            app_num_importes = app_num_importes + 1;
            signalName = ['Importe', num2str(app_num_importes)];  % Name the signal (e.g., "Signal 1", "Signal 2")
            app_list_box_items{app_num_signals} = signalName;     % Add to the List Box
            app_SealdeentradaDropDown_Items{app_num_signals} = signalName;  %Add to the Input Signal Dropdown Button
            app_Sealdeentrada1DropDown_Items{app_num_signals} = signalName;
            app_Sealdeentrada2DropDown_Items{app_num_signals} = signalName;
            app_DropDown_Items{app_num_signals} = signalName;
        case 'grabada'
            app_num_grabaciones = app_num_grabaciones + 1;
            signalName = ['Grabaci�n', num2str(app_num_grabaciones)];  % Name the signal (e.g., "Signal 1", "Signal 2")
            app_list_box_items{app_num_signals} = signalName;     % Add to the List Box
            app_SealdeentradaDropDown_Items{app_num_signals} = signalName;  %Add to the Input Signal Dropdown Button
            app_Sealdeentrada1DropDown_Items{app_num_signals} = signalName;
            app_Sealdeentrada2DropDown_Items{app_num_signals} = signalName;
            app_DropDown_Items{app_num_signals} = signalName;
    end
end