clear classes

% py.importlib.import_module('eeg');
cykit = py.eeg.EEG;
tic();
a = cykit.get_data()
b = cykit.get_data()
c = cykit.get_data()
toc();