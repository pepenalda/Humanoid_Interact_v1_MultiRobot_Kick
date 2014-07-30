%% (c) Aldebaran Robotics - 2014
    
classdef ALSentinelProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALSentinelProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALSentinel',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function batteryPowerPluggedChanged(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'batteryPowerPluggedChanged', varargin);
        end
         
        function enableBatteryMeasure(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableBatteryMeasure', varargin);
        end
         
        function enableCheckRemainingRam(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableCheckRemainingRam', varargin);
        end
         
        function enableDefaultActionDoubleClick(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableDefaultActionDoubleClick', varargin);
        end
         
        function enableDefaultActionSimpleClick(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableDefaultActionSimpleClick', varargin);
        end
         
        function enableDefaultActionTripleClick(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableDefaultActionTripleClick', varargin);
        end
         
        function enableHeatMonitoring(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableHeatMonitoring', varargin);
        end
         
        function enablePowerMonitoring(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enablePowerMonitoring', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function exitNaoqi(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exitNaoqi', varargin);
        end
         
        function I = getBatteryLevel(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBatteryLevel', varargin);
        end
         
        function I = getBatteryLevelDesc(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBatteryLevelDesc', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getMethodHelp(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMethodHelp', varargin);
        end
         
        function I = getMethodList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMethodList', varargin);
        end
         
        function I = getModuleHelp(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getModuleHelp', varargin);
        end
         
        function I = getRemainingRam(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getRemainingRam', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function onBatteryMeasure(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'onBatteryMeasure', varargin);
        end
         
        function onMotorError(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'onMotorError', varargin);
        end
         
        function onTemperatureMeasure(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'onTemperatureMeasure', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function presentation(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'presentation', varargin);
        end
         
        function run(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'run', varargin);
        end
         
        function setPowerLimit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setPowerLimit', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
