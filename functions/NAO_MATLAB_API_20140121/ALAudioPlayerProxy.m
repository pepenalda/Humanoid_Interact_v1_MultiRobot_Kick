%% (c) Aldebaran Robotics - 2014
    
classdef ALAudioPlayerProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALAudioPlayerProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALAudioPlayer',ip,port);
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
         
        function I = getCurrentPosition(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getCurrentPosition', varargin);
        end
         
        function I = getFileLength(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getFileLength', varargin);
        end
         
        function I = getLoadedFilesIds(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getLoadedFilesIds', varargin);
        end
         
        function I = getLoadedFilesNames(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getLoadedFilesNames', varargin);
        end
         
        function I = getMasterVolume(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMasterVolume', varargin);
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
         
        function I = getVolume(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getVolume', varargin);
        end
         
        function goTo(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'goTo', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = loadFile(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'loadFile', varargin);
        end
         
        function pause(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'pause', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function play(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'play', varargin);
        end
         
        function playFile(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playFile', varargin);
        end
         
        function playFileFromPosition(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playFileFromPosition', varargin);
        end
         
        function playFileInLoop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playFileInLoop', varargin);
        end
         
        function playInLoop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playInLoop', varargin);
        end
         
        function playSine(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playSine', varargin);
        end
         
        function playWebStream(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playWebStream', varargin);
        end
         
        function setMasterVolume(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setMasterVolume', varargin);
        end
         
        function setPanorama(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setPanorama', varargin);
        end
         
        function setVolume(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setVolume', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function stopAll(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopAll', varargin);
        end
         
        function unloadAllFiles(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'unloadAllFiles', varargin);
        end
         
        function unloadFile(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'unloadFile', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
