%% (c) Aldebaran Robotics - 2014
    
classdef ALSpeechRecognitionProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALSpeechRecognitionProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALSpeechRecognition',ip,port);
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
         
        function I = getAvailableLanguages(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getAvailableLanguages', varargin);
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
         
        function I = getLanguage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getLanguage', varargin);
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
         
        function I = getParameter(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getParameter', varargin);
        end
         
        function I = getPhoneticTranscription(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getPhoneticTranscription', varargin);
        end
         
        function I = getSubscribersInfo(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getSubscribersInfo', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function loadVocabulary(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'loadVocabulary', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function processRemote(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'processRemote', varargin);
        end
         
        function processSoundRemote(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'processSoundRemote', varargin);
        end
         
        function setAudioExpression(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setAudioExpression', varargin);
        end
         
        function setDebugMode(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setDebugMode', varargin);
        end
         
        function setLanguage(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setLanguage', varargin);
        end
         
        function setParameter(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setParameter', varargin);
        end
         
        function setVisualExpression(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setVisualExpression', varargin);
        end
         
        function setVocabulary(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setVocabulary', varargin);
        end
         
        function setWordListAsVocabulary(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setWordListAsVocabulary', varargin);
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
