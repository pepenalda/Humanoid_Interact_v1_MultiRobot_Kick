%% (c) Aldebaran Robotics - 2014
    
classdef ALLauncherProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALLauncherProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALLauncher',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getGlobalModuleList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getGlobalModuleList', varargin);
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
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = isModulePresent(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isModulePresent', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = launchExecutable(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'launchExecutable', varargin);
        end
         
        function I = launchLocal(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'launchLocal', varargin);
        end
         
        function I = launchPythonModule(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'launchPythonModule', varargin);
        end
         
        function I = launchScript(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'launchScript', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
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
