%% (c) Aldebaran Robotics - 2014
    
classdef DCMProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = DCMProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('DCM',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function calibration(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'calibration', varargin);
        end
         
        function I = createAlias(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'createAlias', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
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
         
        function I = getPrefix(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getPrefix', varargin);
        end
         
        function I = getTime(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getTime', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function I = preferences(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'preferences', varargin);
        end
         
        function set(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'set', varargin);
        end
         
        function setAlias(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setAlias', varargin);
        end
         
        function special(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'special', varargin);
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
