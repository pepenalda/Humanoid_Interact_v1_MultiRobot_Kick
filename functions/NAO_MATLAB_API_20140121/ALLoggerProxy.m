%% (c) Aldebaran Robotics - 2014
    
classdef ALLoggerProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALLoggerProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALLogger',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function debug(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'debug', varargin);
        end
         
        function error(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'error', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function fatal(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'fatal', varargin);
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
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function info(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'info', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function logInFile(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'logInFile', varargin);
        end
         
        function logInForwarder(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'logInForwarder', varargin);
        end
         
        function logInStd(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'logInStd', varargin);
        end
         
        function logInSys(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'logInSys', varargin);
        end
         
        function lowDebug(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'lowDebug', varargin);
        end
         
        function lowInfo(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'lowInfo', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function removeHandler(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'removeHandler', varargin);
        end
         
        function separator(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'separator', varargin);
        end
         
        function setFilter(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setFilter', varargin);
        end
         
        function setVerbosity(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setVerbosity', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function I = verbosity(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'verbosity', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
        function warn(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'warn', varargin);
        end
         
    end
end
