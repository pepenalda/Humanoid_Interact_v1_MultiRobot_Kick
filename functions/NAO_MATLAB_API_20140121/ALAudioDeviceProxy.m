%% (c) Aldebaran Robotics - 2014
    
classdef ALAudioDeviceProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALAudioDeviceProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALAudioDevice',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function closeAudioInputs(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'closeAudioInputs', varargin);
        end
         
        function closeAudioOutputs(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'closeAudioOutputs', varargin);
        end
         
        function disableEnergyComputation(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'disableEnergyComputation', varargin);
        end
         
        function enableEnergyComputation(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableEnergyComputation', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function flushAudioOutputs(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'flushAudioOutputs', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getFrontMicEnergy(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getFrontMicEnergy', varargin);
        end
         
        function I = getLeftMicEnergy(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getLeftMicEnergy', varargin);
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
         
        function I = getOutputVolume(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getOutputVolume', varargin);
        end
         
        function I = getParameter(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getParameter', varargin);
        end
         
        function I = getRearMicEnergy(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getRearMicEnergy', varargin);
        end
         
        function I = getRightMicEnergy(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getRightMicEnergy', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = isAudioOutMuted(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isAudioOutMuted', varargin);
        end
         
        function I = isInputClosed(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isInputClosed', varargin);
        end
         
        function I = isOutputClosed(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isOutputClosed', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function muteAudioOut(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'muteAudioOut', varargin);
        end
         
        function openAudioInputs(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'openAudioInputs', varargin);
        end
         
        function openAudioOutputs(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'openAudioOutputs', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function playSine(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playSine', varargin);
        end
         
        function resetAudio(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'resetAudio', varargin);
        end
         
        function I = sendLocalBufferToOutput(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'sendLocalBufferToOutput', varargin);
        end
         
        function I = sendRemoteBufferToOutput(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'sendRemoteBufferToOutput', varargin);
        end
         
        function setClientPreferences(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setClientPreferences', varargin);
        end
         
        function setFileAsInput(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setFileAsInput', varargin);
        end
         
        function setOutputVolume(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setOutputVolume', varargin);
        end
         
        function setParameter(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setParameter', varargin);
        end
         
        function startMicrophonesRecording(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'startMicrophonesRecording', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function stopAudioOut(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopAudioOut', varargin);
        end
         
        function stopMicrophonesRecording(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopMicrophonesRecording', varargin);
        end
         
        function subscribe(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'subscribe', varargin);
        end
         
        function I = subscribeRemoteModule(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'subscribeRemoteModule', varargin);
        end
         
        function I = unSubscribeRemoteModule(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'unSubscribeRemoteModule', varargin);
        end
         
        function unsubscribe(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'unsubscribe', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
