%% (c) Aldebaran Robotics - 2014
    
classdef ALMotionProxy < handle
    properties
    end
    
    properties (GetAccess='public', SetAccess='private')
        ptrProxyNaoQi;
    end
    
    methods
        function obj = ALMotionProxy(ip, port)
            obj.ptrProxyNaoQi = matlabproxy('ALMotion',ip,port);
        end
    
        function I = call(obj, method, varargin)
            I = matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function callVoid(obj, method, varargin)
            matlabcall(obj.ptrProxyNaoQi,method, varargin);
        end 
    
        function angleInterpolation(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'angleInterpolation', varargin);
        end
         
        function angleInterpolationBezier(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'angleInterpolationBezier', varargin);
        end
         
        function angleInterpolationWithSpeed(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'angleInterpolationWithSpeed', varargin);
        end
         
        function I = areResourcesAvailable(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'areResourcesAvailable', varargin);
        end
         
        function changeAngles(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'changeAngles', varargin);
        end
         
        function changePosition(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'changePosition', varargin);
        end
         
        function changeTransform(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'changeTransform', varargin);
        end
         
        function closeHand(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'closeHand', varargin);
        end
         
        function exit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'exit', varargin);
        end
         
        function I = getAngles(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getAngles', varargin);
        end
         
        function I = getBodyNames(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBodyNames', varargin);
        end
         
        function I = getBrokerName(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getBrokerName', varargin);
        end
         
        function I = getCOM(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getCOM', varargin);
        end
         
        function I = getCollisionProtectionEnabled(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getCollisionProtectionEnabled', varargin);
        end
         
        function I = getFallManagerEnabled(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getFallManagerEnabled', varargin);
        end
         
        function I = getFootGaitConfig(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getFootGaitConfig', varargin);
        end
         
        function I = getFootSteps(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getFootSteps', varargin);
        end
         
        function I = getJointNames(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getJointNames', varargin);
        end
         
        function I = getLimits(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getLimits', varargin);
        end
         
        function I = getMass(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMass', varargin);
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
         
        function I = getMotionCycleTime(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMotionCycleTime', varargin);
        end
         
        function I = getMoveConfig(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getMoveConfig', varargin);
        end
         
        function I = getNextRobotPosition(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getNextRobotPosition', varargin);
        end
         
        function I = getPosition(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getPosition', varargin);
        end
         
        function I = getRobotConfig(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getRobotConfig', varargin);
        end
         
        function I = getRobotPosition(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getRobotPosition', varargin);
        end
         
        function I = getRobotVelocity(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getRobotVelocity', varargin);
        end
         
        function I = getSensorNames(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getSensorNames', varargin);
        end
         
        function I = getSmartStiffnessEnabled(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getSmartStiffnessEnabled', varargin);
        end
         
        function I = getStiffnesses(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getStiffnesses', varargin);
        end
         
        function I = getSummary(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getSummary', varargin);
        end
         
        function I = getTaskList(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getTaskList', varargin);
        end
         
        function I = getTransform(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getTransform', varargin);
        end
         
        function I = getUsage(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getUsage', varargin);
        end
         
        function I = getWalkArmsEnable(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getWalkArmsEnable', varargin);
        end
         
        function I = getWalkArmsEnabled(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'getWalkArmsEnabled', varargin);
        end
         
        function I = isCollision(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isCollision', varargin);
        end
         
        function I = isRunning(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'isRunning', varargin);
        end
         
        function killAll(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'killAll', varargin);
        end
         
        function killMove(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'killMove', varargin);
        end
         
        function I = killTask(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'killTask', varargin);
        end
         
        function killTasksUsingResources(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'killTasksUsingResources', varargin);
        end
         
        function killWalk(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'killWalk', varargin);
        end
         
        function move(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'move', varargin);
        end
         
        function moveInit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'moveInit', varargin);
        end
         
        function I = moveIsActive(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'moveIsActive', varargin);
        end
         
        function moveTo(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'moveTo', varargin);
        end
         
        function moveToward(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'moveToward', varargin);
        end
         
        function openHand(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'openHand', varargin);
        end
         
        function I = ping(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'ping', varargin);
        end
         
        function positionInterpolation(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'positionInterpolation', varargin);
        end
         
        function positionInterpolations(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'positionInterpolations', varargin);
        end
         
        function rest(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'rest', varargin);
        end
         
        function I = robotIsWakeUp(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'robotIsWakeUp', varargin);
        end
         
        function setAngles(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setAngles', varargin);
        end
         
        function I = setCollisionProtectionEnabled(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'setCollisionProtectionEnabled', varargin);
        end
         
        function setFallManagerEnabled(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setFallManagerEnabled', varargin);
        end
         
        function setFootSteps(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setFootSteps', varargin);
        end
         
        function setFootStepsWithSpeed(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setFootStepsWithSpeed', varargin);
        end
         
        function setMotionConfig(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setMotionConfig', varargin);
        end
         
        function setPosition(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setPosition', varargin);
        end
         
        function setSmartStiffnessEnabled(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setSmartStiffnessEnabled', varargin);
        end
         
        function setStiffnesses(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setStiffnesses', varargin);
        end
         
        function setTransform(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setTransform', varargin);
        end
         
        function setWalkArmsEnable(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setWalkArmsEnable', varargin);
        end
         
        function setWalkArmsEnabled(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setWalkArmsEnabled', varargin);
        end
         
        function setWalkTargetVelocity(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'setWalkTargetVelocity', varargin);
        end
         
        function stiffnessInterpolation(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stiffnessInterpolation', varargin);
        end
         
        function stop(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stop', varargin);
        end
         
        function stopMove(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopMove', varargin);
        end
         
        function stopWalk(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'stopWalk', varargin);
        end
         
        function transformInterpolation(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'transformInterpolation', varargin);
        end
         
        function transformInterpolations(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'transformInterpolations', varargin);
        end
         
        function updateTrackerTarget(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'updateTrackerTarget', varargin);
        end
         
        function I = version(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'version', varargin);
        end
         
        function I = wait(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'wait', varargin);
        end
         
        function waitUntilMoveIsFinished(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'waitUntilMoveIsFinished', varargin);
        end
         
        function waitUntilWalkIsFinished(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'waitUntilWalkIsFinished', varargin);
        end
         
        function wakeUp(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'wakeUp', varargin);
        end
         
        function walkInit(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'walkInit', varargin);
        end
         
        function I = walkIsActive(obj, varargin)
            I = matlabcall(obj.ptrProxyNaoQi, 'walkIsActive', varargin);
        end
         
        function walkTo(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'walkTo', varargin);
        end
         
        function wbEnable(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'wbEnable', varargin);
        end
         
        function wbEnableBalanceConstraint(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'wbEnableBalanceConstraint', varargin);
        end
         
        function wbEnableEffectorControl(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'wbEnableEffectorControl', varargin);
        end
         
        function wbEnableEffectorOptimization(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'wbEnableEffectorOptimization', varargin);
        end
         
        function wbFootState(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'wbFootState', varargin);
        end
         
        function wbGoToBalance(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'wbGoToBalance', varargin);
        end
         
        function wbSetEffectorControl(obj, varargin)
            matlabcall(obj.ptrProxyNaoQi, 'wbSetEffectorControl', varargin);
        end
         
    end
end
