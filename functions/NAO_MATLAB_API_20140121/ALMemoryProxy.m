%% (c) Aldebaran Robotics - 2014
    
classdef ALMemoryProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALMemoryProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALMemory',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function declareEvent(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'declareEvent', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getData(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getData', varargin);
        end
         
        function I = getDataList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getDataList', varargin);
        end
         
        function I = getDataListName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getDataListName', varargin);
        end
         
        function I = getDataOnChange(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getDataOnChange', varargin);
        end
         
        function I = getDataPtr(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getDataPtr', varargin);
        end
         
        function I = getDescriptionList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getDescriptionList', varargin);
        end
         
        function I = getEventHistory(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getEventHistory', varargin);
        end
         
        function I = getEventList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getEventList', varargin);
        end
         
        function I = getExtractorEvent(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getExtractorEvent', varargin);
        end
         
        function I = getListData(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getListData', varargin);
        end
         
        function I = getMethodHelp(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMethodHelp', varargin);
        end
         
        function I = getMethodList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMethodList', varargin);
        end
         
        function I = getMicroEventList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMicroEventList', varargin);
        end
         
        function I = getModuleHelp(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getModuleHelp', varargin);
        end
         
        function I = getSubscribers(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getSubscribers', varargin);
        end
         
        function I = getTimestamp(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getTimestamp', varargin);
        end
         
        function I = getType(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getType', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function insertData(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'insertData', varargin);
        end
         
        function insertListData(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'insertListData', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function raiseEvent(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'raiseEvent', varargin);
        end
         
        function raiseMicroEvent(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'raiseMicroEvent', varargin);
        end
         
        function removeData(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'removeData', varargin);
        end
         
        function removeMicroEvent(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'removeMicroEvent', varargin);
        end
         
        function setDescription(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setDescription', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function subscribeToEvent(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'subscribeToEvent', varargin);
        end
         
        function subscribeToMicroEvent(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'subscribeToMicroEvent', varargin);
        end
         
        function unregisterModuleReference(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'unregisterModuleReference', varargin);
        end
         
        function unsubscribeToEvent(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'unsubscribeToEvent', varargin);
        end
         
        function unsubscribeToMicroEvent(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'unsubscribeToMicroEvent', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
