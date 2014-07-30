%% (c) Aldebaran Robotics - 2014
    
classdef ALResourceManagerProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALResourceManagerProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALResourceManager',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function I = areResourcesFree(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'areResourcesFree', varargin);
        end
         
        function I = areResourcesOwnedBy(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'areResourcesOwnedBy', varargin);
        end
         
        function createResource(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'createResource', varargin);
        end
         
        function createResourcesList(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'createResourcesList', varargin);
        end
         
        function deleteResource(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'deleteResource', varargin);
        end
         
        function enableStateResource(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'enableStateResource', varargin);
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
         
        function I = isInGroup(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isInGroup', varargin);
        end
         
        function I = isResourceFree(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isResourceFree', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = ownersGet(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ownersGet', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function releaseResource(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'releaseResource', varargin);
        end
         
        function releaseResources(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'releaseResources', varargin);
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
         
        function I = waitForOptionalResourcesTree(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'waitForOptionalResourcesTree', varargin);
        end
         
        function waitForResource(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'waitForResource', varargin);
        end
         
        function waitForResourcesTree(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'waitForResourcesTree', varargin);
        end
         
    end
end
