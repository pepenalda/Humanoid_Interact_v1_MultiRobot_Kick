%% (c) Aldebaran Robotics - 2014
    
classdef ALRobotPostureProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALRobotPostureProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALRobotPosture',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function I = applyPosture(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'applyPosture', varargin);
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
         
        function I = getPostureFamily(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getPostureFamily', varargin);
        end
         
        function I = getPostureFamilyList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getPostureFamilyList', varargin);
        end
         
        function I = getPostureList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getPostureList', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = goToPosture(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'goToPosture', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function setMaxTryNumber(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setMaxTryNumber', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function stopMove(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopMove', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
