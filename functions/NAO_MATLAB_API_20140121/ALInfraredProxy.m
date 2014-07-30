%% (c) Aldebaran Robotics - 2014
    
classdef ALInfraredProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALInfraredProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALInfrared',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function confRemoteRecordSave(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'confRemoteRecordSave', varargin);
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
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function initReception(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'initReception', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function send32(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'send32', varargin);
        end
         
        function send8(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'send8', varargin);
        end
         
        function sendIpAddress(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'sendIpAddress', varargin);
        end
         
        function sendRemoteKey(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'sendRemoteKey', varargin);
        end
         
        function sendRemoteKeyWithTime(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'sendRemoteKeyWithTime', varargin);
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
