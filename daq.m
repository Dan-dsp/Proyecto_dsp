% Button pushed function: DAQButton
function daq(app)
    % Reset the DAQ devices configuration
    daqreset;
    dev = daqlist; % Get the list of connected DAQ devices

    % Check if there is no DAQ device connected
    if isempty(dev)
        f = msgbox("No DAQ connected. Please try again.", "Error", "warn");
        return; % Exit if no devices are found
    else
        Devices = table2array(dev(:,3));
        numDev = table2array(dev(:,2));
        vendor = table2array(dev(:,1));
        [indx,tf] = listdlg('PromptString', 'Select a device:','SelectionMode', 'single','ListString', Devices);
    end

    % Proceed if a device was selected
    if tf
        selectedVendor = vendor{indx};
        % Check for device vendor
        if strcmp(selectedVendor, "digilent")
            f = msgbox("Unsupported device vendor: digilent", "Warning", "warn");

        elseif strcmp(selectedVendor, "ni")
            % Open input dialog to ask user for port number and time duration
            prompt = {'Enter the port (e.g., ai0):','Enter the capture time (s):'};
            dlgtitle = 'DAQ Data Configuration';
            dims = [1 35];
            definput = {'ai0','10'};
            answer = inputdlg(prompt, dlgtitle, dims, definput);

            % Validate user input
            if isempty(answer)
                disp('Operation cancelled by user.');
                return;
            end
            port = answer{1};
            captureTime = str2double(answer{2});
            if isnan(captureTime) || captureTime <= 0
                errordlg('Please enter a valid capture time.');
                return;
            end

            % Configure the DAQ device
            d = daq(selectedVendor);
            d.Rate = app.SampleNumberEditField.Value; % Assume this value is set correctly in the app
            % Note: 'app.fs' seems to be unused, consider removing it if not needed

            % Add input channel
            nidevice = addinput(d, numDev{indx}, port, "Voltage");
            nidevice.TerminalConfig = "SingleEnded";

            % Start reading the data
            data = read(d, seconds(captureTime));

            %% NOTE: Assumes 'app.Switch' is a UI element that determines the plot target
            switch app.Switch.Value
                case 'Input 1'
                    app.fs1 = d.Rate;
                    app.inx1 = data.Time';
                    app.iny1 = data.Variables';
                    stem(app.input1, app.inx1, app.iny1);
                    title(app.input1, 'Input 1 Data');
                    xlabel(app.input1, 'Time (s)');
                    ylabel(app.input1, 'Voltage (V)');
                case 'Input 2'
                    app.fs2 = d.Rate;
                    app.inx2 = data.Time';
                    app.iny2 = data.Variables';
                    stem(app.input2, app.inx2, app.iny2);
                    title(app.input2, 'Input 2 Data');
                    xlabel(app.input2, 'Time (s)');
                    ylabel(app.input2, 'Voltage (V)');
            end
        end
    end
end



