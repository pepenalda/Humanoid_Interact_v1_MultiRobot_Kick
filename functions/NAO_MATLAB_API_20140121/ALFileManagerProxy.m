%% (c) Aldebaran Robotics - 2014
    
classdef ALFileManagerProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALFileManagerProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALFileManager',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function I = dataFileExists(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'dataFileExists', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function I = fileExists(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'fileExists', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getFileCompletePath(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getFileCompletePath', varargin);
        end
         
        function I = getFileContents(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getFileContents', varargin);
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
         
        function I = getSystemSharedFolderPath(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getSystemSharedFolderPath', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = getUserSharedFolderPath(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUserSharedFolderPath', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function setUserSharedFolderPath(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setUserSharedFolderPath', varargin);
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
