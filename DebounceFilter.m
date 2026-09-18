function DebounceFilter(block)
setup(block);

function setup(block)

block.NumInputPorts  = 1;
block.NumOutputPorts = 1;

block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

block.InputPort(1).Dimensions        = 1;
block.InputPort(1).DatatypeID  = 8;   % boolean
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

block.OutputPort(1).Dimensions       = 1;
block.OutputPort(1).DatatypeID  = 8;  % boolean
block.OutputPort(1).Complexity  = 'Real';

block.NumDialogPrms     = 0;
block.SampleTimes = [0.01 0];
block.SimStateCompliance = 'DefaultSimState';

block.RegBlockMethod('PostPropagationSetup', @DoPostPropSetup);
block.RegBlockMethod('Start',      @Start);
block.RegBlockMethod('Outputs',    @Outputs);
block.RegBlockMethod('Update',     @Update);
block.RegBlockMethod('Terminate',  @Terminate);

%% ------------------------------------------------------------------
function DoPostPropSetup(block)
block.NumDworks = 2;

block.Dwork(1).Name            = 'Counter';
block.Dwork(1).Dimensions      = 1;
block.Dwork(1).DatatypeID      = 6;      % int32
block.Dwork(1).Complexity      = 'Real';
block.Dwork(1).UsedAsDiscState = true;

block.Dwork(2).Name            = 'StableValue';
block.Dwork(2).Dimensions      = 1;
block.Dwork(2).DatatypeID      = 8;      % boolean
block.Dwork(2).Complexity      = 'Real';
block.Dwork(2).UsedAsDiscState = true;

%% ------------------------------------------------------------------
function Start(block)
block.Dwork(1).Data = int32(0);   % counter starts at 0
block.Dwork(2).Data = false;      % stable output starts false

%% ------------------------------------------------------------------
function Outputs(block)
block.OutputPort(1).Data = block.Dwork(2).Data;

%% ------------------------------------------------------------------
function Update(block)
COUNT_THRESHOLD = int32(3);

in      = block.InputPort(1).Data;
counter = block.Dwork(1).Data;
stable  = block.Dwork(2).Data;

if in == stable
    counter = int32(0);
else
    counter = counter + int32(1);
    if counter >= COUNT_THRESHOLD
        stable  = in;
        counter = int32(0);
    end
end

block.Dwork(1).Data = counter;
block.Dwork(2).Data = stable;

%% ------------------------------------------------------------------
function Terminate(block)
%end Terminate