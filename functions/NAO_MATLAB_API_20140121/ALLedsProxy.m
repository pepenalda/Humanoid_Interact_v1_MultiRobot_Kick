%% (c) Aldebaran Robotics - 2014
    
classdef ALLedsProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALLedsProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALLeds',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function createGroup(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'createGroup', varargin);
        end
         
        function earLedsSetAngle(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'earLedsSetAngle', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function fade(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'fade', varargin);
        end
         
        function fadeListRGB(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'fadeListRGB', varargin);
        end
         
        function fadeRGB(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'fadeRGB', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getIntensity(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getIntensity', varargin);
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
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = listGroup(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'listGroup', varargin);
        end
         
        function I = listGroups(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'listGroups', varargin);
        end
         
        function I = listLED(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'listLED', varargin);
        end
         
        function I = listLEDs(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'listLEDs', varargin);
        end
         
        function off(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'off', varargin);
        end
         
        function on(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'on', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function randomEyes(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'randomEyes', varargin);
        end
         
        function rasta(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'rasta', varargin);
        end
         
        function rotateEyes(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'rotateEyes', varargin);
        end
         
        function setIntensity(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setIntensity', varargin);
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
