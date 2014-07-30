%% (c) Aldebaran Robotics - 2014
    
classdef ALFrameManagerProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALFrameManagerProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALFrameManager',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function cleanBehaviors(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'cleanBehaviors', varargin);
        end
         
        function completeBehavior(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'completeBehavior', varargin);
        end
         
        function I = createAndPlayTimeline(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'createAndPlayTimeline', varargin);
        end
         
        function deleteBehavior(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'deleteBehavior', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function exitBehavior(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exitBehavior', varargin);
        end
         
        function I = getBehaviorPath(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBehaviorPath', varargin);
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
         
        function I = getMotionLength(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMotionLength', varargin);
        end
         
        function I = getTimelineFps(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getTimelineFps', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function gotoAndPlay(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'gotoAndPlay', varargin);
        end
         
        function gotoAndStop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'gotoAndStop', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function I = newBehavior(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'newBehavior', varargin);
        end
         
        function I = newBehaviorFromChoregraphe(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'newBehaviorFromChoregraphe', varargin);
        end
         
        function I = newBehaviorFromFile(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'newBehaviorFromFile', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function playBehavior(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playBehavior', varargin);
        end
         
        function playTimeline(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'playTimeline', varargin);
        end
         
        function setDeprecationWarningEnabled(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setDeprecationWarningEnabled', varargin);
        end
         
        function setTimelineFps(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setTimelineFps', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function stopTimeline(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopTimeline', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
    end
end
