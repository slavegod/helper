local VelocityMover = {}
VelocityMover.__index = VelocityMover

local function lerp(a, b, t)
    return a + (b - a) * t
end

function VelocityMover.new(part)
    local self = setmetatable({}, VelocityMover)
    self.part = part
    self.moving = false
    return self
end

function VelocityMover:MoveTo(target, maxSpeed, acceleration)
    if not self.part or not self.part:IsA("BasePart") then return end
    
    self.moving = true
    local currentVelocity = Vector3.new(0, 0, 0)
    
    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function(dt)
        if not self.moving then
            connection:Disconnect()
            self.part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            return
        }
        
        local direction = (target - self.part.Position)
        local distance = direction.Magnitude
        
        if distance < 0.1 then
            self.moving = false
            self.part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            connection:Disconnect()
            return
        end
        
        direction = direction.Unit
        
        local targetVelocity = direction * maxSpeed
        currentVelocity = self.part.AssemblyLinearVelocity
        
        local newVelocity = Vector3.new(
            lerp(currentVelocity.X, targetVelocity.X, acceleration * dt),
            lerp(currentVelocity.Y, targetVelocity.Y, acceleration * dt),
            lerp(currentVelocity.Z, targetVelocity.Z, acceleration * dt)
        )
        
        self.part.AssemblyLinearVelocity = newVelocity
    end)
end

function VelocityMover:Stop()
    self.moving = false
    if self.part then
        self.part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
end

return VelocityMover
