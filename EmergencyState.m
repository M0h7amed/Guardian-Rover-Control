%% Bus data creator - Emergency/State Bus
clear elems

elems(1) = Simulink.BusElement;
elems(1).Name = 'forced_state'; elems(1).DataType = 'double';
elems(2) = Simulink.BusElement;
elems(2).Name = 'Emergency_flag'; elems(2).DataType = 'double';
elems(3) = Simulink.BusElement;
elems(3).Name = 'State_code'; elems(3).DataType = 'int32';

EmergencyStateBus = Simulink.Bus;
EmergencyStateBus.Elements = elems;