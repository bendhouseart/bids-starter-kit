%% Template Matlab script to create an BIDS compatible _ieeg.json file
% This example lists all required and optional fields.
% When adding additional metadata please use camelcase
%
% DHermes, 2017
%%

clear all

root_dir = '.';
ieeg_project = 'template';
ieeg_sub = '01';
ieeg_ses = '01';
ieeg_task = 'LongExample';
ieeg_run = '01';

% you can also have acq- and proc-, but these are optional

ieeg_json_name = fullfile(root_dir,ieeg_project,[ 'sub-' ieeg_sub ],...
    ['ses-' ieeg_ses],...
    'ieeg',...
    ['sub-' ieeg_sub ...
    '_ses-' ieeg_ses ...
    '_task-' ieeg_task ...
    '_run-' ieeg_run '_ieeg.json']);

%%

% General fields, shared with MRI BIDS and MEG BIDS:
% Required fields:
ieeg_json.TaskName = 'visual'; % Name of the task (for resting state use the ?rest? prefix). No two tasks should have the same name. Task label is derived from this field by removing all non alphanumeric ([a-zA-Z0-9]) characters. 
ieeg_json.SamplingFrequency = 3051.76; %  Sampling frequency (in Hz) of the recording (e.g. 2400Hz)
ieeg_json.Manufacturer = 'Tucker Davis Technologies'; % Manufacturer of the amplifier system  (e.g. "TDT, blackrock")
% Optional fields:
ieeg_json.ManufacturersModelName = 'unknown'; % Manufacturer?s designation of the iEEG amplifier model (e.g. "TDT"). 
ieeg_json.TaskDescription = 'visual gratings and noise patterns'; % Longer description of the task.
ieeg_json.Instructions = 'look at the dot in the center of the screen and press the button when it changes color'; % Text of the instructions given to participants before the recording. This is especially important in context of resting state and distinguishing between eyes open and eyes closed paradigms. 
ieeg_json.CogAtlasID = 'NaN'; % URL of the corresponding Cognitive Atlas Task term
ieeg_json.CogPOID = 'NaN'; %  URL of the corresponding CogPO term
ieeg_json.InstitutionName = 'Stanford Hospital and Clinics'; %  The name of the institution in charge of the equipment that produced the composite instances. 
ieeg_json.InstitutionAddress = '300 Pasteur Dr, Stanford, CA 94305'; % The address of the institution in charge of the equipment that produced the composite instances. 
ieeg_json.DeviceSerialNumber = 'unknown'; % The serial number of the equipment that produced the composite instances. A pseudonym can also be used to prevent the equipment from being identifiable, as long as each pseudonym is unique within the dataset.

% General fields, shared with MEG BIDS:
% Required fields:
ieeg_json.EEGChannelCount = 0; % Number of EEG channels included in the recording (e.g. 0)  
ieeg_json.EOGChannelCount = 0; % Number of EOG channels included in the recording (e.g. 1)
ieeg_json.ECGChannelCount = 0; % Number of ECG channels included in the recording (e.g. 1)
ieeg_json.EMGChannelCount = 0; % Number of EMG channels included in the recording (e.g. 1)
ieeg_json.MiscChannelCount = 0; % Number of miscellaneous channels included in the recording (e.g. 1)
ieeg_json.TriggerChannelCount = 0; % Number of channels for digital (TTL bit level) triggers (e.g. 0) 
ieeg_json.PowerLineFrequency = 60; % Frequency (in Hz) of the power grid where the iEEG recording was done (i.e. 50 or 60) 
% Optional fields:
ieeg_json.SoftwareFilters = 'none'; % It is recommended to store the unprocessed data. However, if minimal software filtering is done, a list of temporal and/or spatial software filters applied can be listed here. Ideally  key:value pairs of pre-applied software filters and their parameter values (e.g. {"downsample": {"original samplingfrequency": "3050", "new sampling frequency": 1000}}, {"rereference": {"common average reference": channels 1:120}}) 
ieeg_json.RecordingDuration = 233.639; % Length of the recording in seconds (e.g. 3600)
ieeg_json.RecordingType = 'continuous'; %  ?continuous?, ?epoched? 
ieeg_json.EpochLength = 'Inf'; % Duration of individual epochs in seconds (e.g. 1). If recording was continuous, set value to ?Inf?.
ieeg_json.DeviceSoftwareVersion = 'unknown'; % Manufacturer?s designation of the acquisition software.
ieeg_json.SubjectArtefactDescription = ''; % Freeform description of the observed subject artefact and its possible cause (e.g. ?door open?, ?nurse walked into room at 2 min?, "Vagus Nerve Stimulator", ?non-removable implant?, ?seizure at 10 min?). If this field is left empty, it will be interpreted as absence of artifacts.

% Specific iEEG fields:
% Required fields:
ieeg_json.iEEGSurfChannelCount = 118; % Number of iEEG surface channels included in the recording (e.g. 120) 
ieeg_json.iEEGDepthChannelCount = 0; % Number of iEEG depth channels included in the recording (e.g. 8) 
ieeg_json.ChannelUnits = 'microVolt'; % Units of recording, this should be either microVolt or otherUnits (one of: ?microVolt? or ?otherUnits?)
ieeg_json.UnitsToMicroVoltFactor = 1; % Units to convert recording to microVolt (e.g. ?1? if already in microVolt) 
ieeg_json.iEEGReference = 'intracranial channel not included with data'; % iEEG reference channel (e.g. "left mastoid?, ?CAR?, "bipolar",  ?21? for channel 21, ?intracranial electrode, not included with data?), specific reference scheme is specified below. 
ieeg_json.HardwareFilters = 'bandpass: 0.5 - 300Hz'; % List of temporal hardware filters applied in Hz (e.g. 0.01 - 300Hz)
ieeg_json.iEEGSurfChannelManufacturer = 'AdTech'; % Manufacturer of the iEEG surface electrodes (e.g. AdTech) 
ieeg_json.iEEGDepthChannelManufacturer = 'NaN'; % anufacturer of the iEEG depth electrodes (e.g. AdTech) 
% Optional fields:
ieeg_json.iEEGPlacementScheme = 'right occipital temporal surface'; % General description of the placement of the iEEG electrodes. Left/right/bilateral/depth/surface (e.g. ?left frontal grid and bilateral hippocampal depth? or ?surface strip and STN depth?).
ieeg_json.iEEGReferenceScheme = ''; % Specify reference scheme if more complex than one channel or CAR.
ieeg_json.StimulationParameters = ''; % Optional field to add parameters for a DBS settings or ECoG stimulation paradigm. Note that event information such as stimulated electrodes and parameters should always be included in the events.
ieeg_json.Medication = ''; %  Optional field to add medication that the patient was on during a recording. 

jsonSaveDir = fileparts(ieeg_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

json_options.indent = '    '; % this just makes the json file look prettier when opened in a text editor
jsonwrite(ieeg_json_name,ieeg_json,json_options)



