%% (c) Aldebaran Robotics - 2014
    
classdef ALTextToSpeechProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALTextToSpeechProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALTextToSpeech',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function disableNotifications(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'disableNotifications', varargin);
        end
         
        function enableNotifications(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableNotifications', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function I = getAvailableLanguages(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getAvailableLanguages', varargin);
        end
         
        function I = getAvailableVoices(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getAvailableVoices', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getLanguage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getLanguage', varargin);
        end
         
        function I = getLanguageEncoding(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getLanguageEncoding', varargin);
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
         
        function I = getParameter(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getParameter', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = getVoice(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getVoice', varargin);
        end
         
        function I = getVolume(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getVolume', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function loadVoicePreference(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'loadVoicePreference', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function say(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'say', varargin);
        end
         
        function sayToFile(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'sayToFile', varargin);
        end
         
        function sayToFileAndPlay(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'sayToFileAndPlay', varargin);
        end
         
        function setLanguage(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setLanguage', varargin);
        end
         
        function setParameter(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setParameter', varargin);
        end
         
        function setVoice(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setVoice', varargin);
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
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
