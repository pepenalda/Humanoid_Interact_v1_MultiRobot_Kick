%% (c) Aldebaran Robotics - 2014
    
classdef ALBacklightingDetectionProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALBacklightingDetectionProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALBacklightingDetection',ip,port);
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
         
        function I = getActiveCamera(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getActiveCamera', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getCurrentPeriod(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getCurrentPeriod', varargin);
        end
         
        function I = getCurrentPrecision(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getCurrentPrecision', varargin);
        end
         
        function I = getFrameRate(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getFrameRate', varargin);
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
         
        function I = getMyPeriod(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMyPeriod', varargin);
        end
         
        function I = getMyPrecision(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMyPrecision', varargin);
        end
         
        function I = getOutputNames(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getOutputNames', varargin);
        end
         
        function I = getResolution(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getResolution', varargin);
        end
         
        function I = getSubscribersInfo(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getSubscribersInfo', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = isPaused(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isPaused', varargin);
        end
         
        function I = isProcessing(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isProcessing', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function pause(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'pause', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function I = setActiveCamera(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'setActiveCamera', varargin);
        end
         
        function I = setFrameRate(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'setFrameRate', varargin);
        end
         
        function setParameter(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setParameter', varargin);
        end
         
        function I = setResolution(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'setResolution', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function subscribe(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'subscribe', varargin);
        end
         
        function unsubscribe(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'unsubscribe', varargin);
        end
         
        function updatePeriod(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'updatePeriod', varargin);
        end
         
        function updatePrecision(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'updatePrecision', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
