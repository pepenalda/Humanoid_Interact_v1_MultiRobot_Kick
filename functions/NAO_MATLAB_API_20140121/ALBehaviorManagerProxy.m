%% (c) Aldebaran Robotics - 2014
    
classdef ALBehaviorManagerProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALBehaviorManagerProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALBehaviorManager',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function addDefaultBehavior(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'addDefaultBehavior', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function I = getBehaviorNames(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBehaviorNames', varargin);
        end
         
        function I = getBehaviorTags(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBehaviorTags', varargin);
        end
         
        function I = getBehaviorsByTag(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBehaviorsByTag', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getDefaultBehaviors(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getDefaultBehaviors', varargin);
        end
         
        function I = getInstalledBehaviors(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getInstalledBehaviors', varargin);
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
         
        function I = getRunningBehaviors(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getRunningBehaviors', varargin);
        end
         
        function I = getSystemBehaviorNames(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getSystemBehaviorNames', varargin);
        end
         
        function I = getTagList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getTagList', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = getUserBehaviorNames(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUserBehaviorNames', varargin);
        end
         
        function I = installBehavior(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'installBehavior', varargin);
        end
         
        function I = isBehaviorInstalled(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isBehaviorInstalled', varargin);
        end
         
        function I = isBehaviorPresent(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isBehaviorPresent', varargin);
        end
         
        function I = isBehaviorRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isBehaviorRunning', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function playDefaultProject(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playDefaultProject', varargin);
        end
         
        function I = preloadBehavior(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'preloadBehavior', varargin);
        end
         
        function I = removeBehavior(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'removeBehavior', varargin);
        end
         
        function removeDefaultBehavior(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'removeDefaultBehavior', varargin);
        end
         
        function runBehavior(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'runBehavior', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function stopAllBehaviors(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopAllBehaviors', varargin);
        end
         
        function stopBehavior(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopBehavior', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
