%% Bus data creator - Sensor Array Bus

elems(1) = Simulink.BusElement;
elems(1).Name = 'Obstacle_F'; elems(1).DataType = 'boolean';
elems(2) = Simulink.BusElement;
elems(2).Name = 'Obstacle_R'; elems(2).DataType = 'boolean';
elems(3) = Simulink.BusElement;
elems(3).Name = 'Obstacle_L'; elems(3).DataType = 'boolean';
elems(4) = Simulink.BusElement;
elems(4).Name = 'Dist_F'; elems(4).DataType = 'double';
elems(5) = Simulink.BusElement;
elems(5).Name = 'Dist_R'; elems(5).DataType = 'double';
elems(6) = Simulink.BusElement;
elems(6).Name = 'Dist_L'; elems(6).DataType = 'double';

SensorArrayBus = Simulink.Bus;
SensorArrayBus.Elements = elems;