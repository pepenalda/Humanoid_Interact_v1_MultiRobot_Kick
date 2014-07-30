%% (c) Aldebaran Robotics - 2014
    
classdef ALPhotoCaptureProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALPhotoCaptureProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALPhotoCapture',ip,port);
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
         
        function I = getCameraID(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getCameraID', varargin);
        end
         
        function I = getCaptureInterval(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getCaptureInterval', varargin);
        end
         
        function I = getColorSpace(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getColorSpace', varargin);
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
         
        function I = getPictureFormat(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getPictureFormat', varargin);
        end
         
        function I = getResolution(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getResolution', varargin);
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
         
        function setCameraID(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setCameraID', varargin);
        end
         
        function setCaptureInterval(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setCaptureInterval', varargin);
        end
         
        function setColorSpace(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setColorSpace', varargin);
        end
         
        function setPictureFormat(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setPictureFormat', varargin);
        end
         
        function setResolution(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setResolution', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function I = takePicture(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'takePicture', varargin);
        end
         
        function I = takePictures(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'takePictures', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
