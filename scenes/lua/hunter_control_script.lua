--local sim = require "sim"
--local simExtRosInterface = require "simExtRosInterface"
function sysCall_init()
    -- do some initialization here
    WHEEL_BASE = 0.650
    TRACK = 0.605
    MAX_STEER_ANGLE = 33 * math.pi / 180
    WHEEL_RADIUS = 0.165
    if simROS then
        sub=simROS.subscribe('/cmd_vel', 'geometry_msgs/Twist', 'setJointVelocities')
        simROS.subscriberTreatUInt8ArrayAsString(sub)
        pub=simROS.advertise('/odometry', 'nav_msgs/Odometry')
        simROS.publisherTreatUInt8ArrayAsString(pub)        
    else
        print("ROS interface was not found. Cannot run.")
	end
    lin_vel = 0
    steering_angle = 0
end

function sysCall_actuation()
    -- put your actuation code here
    left_steering_joint = sim.getObjectHandle('left_steering_joint')
    right_steering_joint = sim.getObjectHandle('right_steering_joint')
    left_angle, right_angle = steering_angles(steering_angle)
    if left_steering_joint then
        sim.setJointPosition(left_steering_joint, left_angle)
        -- sim.setJointTargetPosition(left_steering_joint, left_angle)
    end
    if right_steering_joint then
        sim.setJointPosition(right_steering_joint, right_angle)
        -- sim.setJointTargetPosition(right_steering_joint, right_angle)
    end
    left_rear_joint = sim.getObjectHandle('left_motor_joint')
    right_rear_joint = sim.getObjectHandle('right_motor_joint')
    motor_velocity = lin_vel / WHEEL_RADIUS
    if left_rear_joint then
        sim.setJointTargetVelocity(left_rear_joint, motor_velocity)
    end
    if right_rear_joint then
        sim.setJointTargetVelocity(right_rear_joint, motor_velocity)
    end
end

function sysCall_sensing()
    -- put your sensing code here
    -- left_steering_joint = sim.getObjectHandle('front_left_steering')
    -- if left_steering_joint then
    --    print('left_joint: '..(sim.getJointPosition(left_steering_joint) * 180 / math.pi)..', right_joint: '..(sim.getJointPosition(right_steering_joint) * 180 / math.pi))
    -- end
    if simROS then
        d = {}
	    d['header'] = {stamp=simROS.getTime(), frame_id="map"}
        d['child_frame_id']='isns_link'
        d['pose'] = {}
        d['twist'] = {}
        d['twist']['twist'] = {}
        hull = sim.getObjectHandle('hull')
        if hull then
            quat = sim.getObjectQuaternion(hull, -1)
            pos = sim.getObjectPosition(hull, -1)
            d['pose']['pose'] = {}
            d['pose']['pose']['orientation'] = {w=quat[4], x=quat[1], y=quat[2], z=quat[3]}
            d['pose']['pose']['position'] = {x=pos[1], y=pos[2], z=pos[3]}
            vel, ang_vel = sim.getObjectVelocity(hull)
            d['twist']['twist']['linear'] = {x=vel[1], y=vel[2], z=vel[3]}
            d['twist']['twist']['angular'] = {x=ang_vel[1], y=ang_vel[2], z=ang_vel[3]}
            -- print(d)
            simROS.publish(pub, d)
        end
    end
end

function sysCall_cleanup()
    -- do some clean-up here
    if simROS then   
        -- Shut down publisher and subscriber. Not really needed from a simulation script (automatic shutdown)
        simROS.shutdownSubscriber(sub)
        simROS.shutdownPublisher(pub)
    end
end

function steering_angles(angle)
    if angle > MAX_STEER_ANGLE then
        angle = MAX_STEER_ANGLE
    end
    if angle < - MAX_STEER_ANGLE then
            angle = -MAX_STEER_ANGLE
    end
    angle_abs = math.abs(angle)
    tan_angle = math.tan(angle_abs)
    --alpha1 = math.atan(WHEEL_BASE * tan_angle / (WHEEL_BASE - TRACK / 2 * tan_angle))
    --alpha2 = math.atan(WHEEL_BASE * tan_angle / (WHEEL_BASE + TRACK / 2 * tan_angle))
    alpha1 = angle_abs
    alpha2 = math.atan(WHEEL_BASE * tan_angle / (WHEEL_BASE + TRACK * tan_angle))
    if angle > 0 then
        return alpha1, alpha2
    else
        return -alpha2, -alpha1
    end
end

function setJointVelocities(msg)
    lin_vel = msg.linear.x
    steering_angle = msg.angular.z
end
-- See the user manual or the available code snippets for additional callback functions and details

