%% (c) Aldebaran Robotics - 2014
    
classdef ALConnectionManagerProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALConnectionManagerProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALConnectionManager',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function connect(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'connect', varargin);
        end
         
        function disableTethering(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'disableTethering', varargin);
        end
         
        function disconnect(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'disconnect', varargin);
        end
         
        function enableTethering(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableTethering', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function forget(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'forget', varargin);
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
         
        function I = getTetheringEnable(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getTetheringEnable', varargin);
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
         
        function scan(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'scan', varargin);
        end
         
        function I = service(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'service', varargin);
        end
         
        function I = services(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'services', varargin);
        end
         
        function setServiceConfiguration(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setServiceConfiguration', varargin);
        end
         
        function setServiceInput(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setServiceInput', varargin);
        end
         
        function I = state(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'state', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function I = technologies(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'technologies', varargin);
        end
         
        function I = tetheringName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'tetheringName', varargin);
        end
         
        function I = tetheringPassphrase(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'tetheringPassphrase', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
