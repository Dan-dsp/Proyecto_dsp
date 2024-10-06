function [app_signal, app_sample_rate] = drop_down_value_signal(app_SealdeentradaDropDown_Items, app_SealdeentradaDropDown_Value, app_signalsData)
    selectedSignalIndex = strcmp(app_SealdeentradaDropDown_Items, app_SealdeentradaDropDown_Value);
    signalData = app_signalsData{selectedSignalIndex};  % Retrieve signal and sample rate
    app_signal = signalData{1};
    app_sample_rate = signalData{2};
end

