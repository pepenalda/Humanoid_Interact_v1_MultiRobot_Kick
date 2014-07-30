%% (c) Aldebaran Robotics - 2014
    
classdef ALVisionToolboxProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALVisionToolboxProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALVisionToolbox',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function I = backlighting(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'backlighting', varargin);
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
         
        function halfPress(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'halfPress', varargin);
        end
         
        function I = isItDark(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isItDark', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = isVideoRecording(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isVideoRecording', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function setWhiteBalance(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setWhiteBalance', varargin);
        end
         
        function startVideoRecord(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'startVideoRecord', varargin);
        end
         
        function startVideoRecord_adv(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'startVideoRecord_adv', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function stopTPR(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopTPR', varargin);
        end
         
        function I = stopVideoRecord(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'stopVideoRecord', varargin);
        end
         
        function takePicture(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'takePicture', varargin);
        end
         
        function takePictureRegularly(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'takePictureRegularly', varargin);
        end
         
        function takePictures(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'takePictures', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
