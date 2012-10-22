AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Rocket = {}
Rocket.Loop = Sound("Missile.Accelerate")
Rocket.Damage = 150
Rocket.Velocity = 1000
Rocket.Radius = 60
Rocket.Life = 5 -- To prevent rocket looping

ENT.Embers = NULL

function ENT:Initialize()

	self.model = "models/jaanus/rpc.mdl"
	self.Entity:SetModel( self.model ) 
 	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	local phys = self.Entity:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
	end
	
	self.DoomsDay = CurTime() + Rocket.Life
	self.ExplodeTime = 0
	self.PhysLock = false
	self.UpdatedPos = false
	self.Entity:EmitSound(Rocket.Loop)
	self.EngineLoop = CreateSound(self.Entity, Sound("vehicles/airboat/fan_blade_fullthrottle_loop1.wav"))
	self.EngineLoop:Play()
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WORLD)
	
end  

function ENT:PhysicsCollide( data, physobj )
	if data.HitEntity:IsWorld() then
		if !self.PhysLock then
			self.Entity:StopSound(Rocket.Loop)
			self.EngineLoop:FadeOut(0)
			--self.Light:Fire("turnoff", "", 0)
			local phys = self.Entity:GetPhysicsObject()
			phys:EnableMotion(false)
			self.PhysLock = true
			self.LockPos = data.HitPos
			self:CreateExplosion()
		end
	end
end

function ENT:Touch(hitEnt)
	hitEnt:TakeDamage(5, self.Entity:GetOwner())
end

function ENT:CreateExplosion()
	local expl = ents.Create("env_explosion")
	expl:SetPos(self.Entity:GetPos())
	expl:SetKeyValue("iMagnitude",Rocket.Damage)
	expl:SetOwner(self.Entity:GetOwner())
	expl:Spawn()
	expl:Fire("explode","",5)
	self.EngineLoop:FadeOut(5)
	self.Entity:Fire("kill", "", 5)
end


function ENT:OnTakeDamage( dmginfo )
	if dmginfo:IsExplosionDamage() then return end
	self.Entity:TakePhysicsDamage( dmginfo )
	
end

function ENT:KeyValue(key,value)
	self[key] = tonumber(value) or value
end

function ENT:SpawnFunction( ply, tr )

if ( !tr.Hit ) then return end

local SpawnPos = tr.HitPos + tr.HitNormal * 2
local ang = tr.HitNormal:Angle()
local ent = ents.Create( "sent_rocket" )
ent:SetPos( SpawnPos )
--ent:SetAngles(ang)
ent:Spawn()
ent:Activate()

return ent

end

function ENT:Think()
	if self.PhysLock then
		self.Entity:EmitSound(Sound("npc/manhack/grind" .. math.random(5) .. ".wav"))
		local effect2 = EffectData()
			effect2:SetOrigin(self.LockPos - self.Entity:GetForward() * 2.5)
			effect2:SetScale(.25)
			effect2:SetMagnitude(.25)
		util.Effect("MetalSpark", effect2)
		if !self.LockedPos then
			self.Entity:SetPos(self.LockPos)
			self.LockedPos = true
		end
	else
		local effect = EffectData()
			effect:SetOrigin(self.Entity:GetPos() - self.Entity:GetForward() * 55)
			effect:SetScale(.5)
			effect:SetAngle(self.Entity:GetAngles())
		util.Effect("MuzzleEffect", effect) 
		local effect3 = EffectData()
			effect3:SetOrigin(self.Entity:GetPos() - self.Entity:GetForward() * 60)
			effect3:SetRadius(5) --Radius
			effect3:SetMagnitude(1) --Die Time
		util.Effect("Rocket_Chainsaw_Smoke", effect3)
		local phys = self.Entity:GetPhysicsObject()
		phys:ApplyForceCenter(self.Entity:GetForward() * 99)
		for k, v in pairs(ents.FindInBox(self.Entity:WorldSpaceAABB())) do
			if v and v:IsValid() then
				if !(v == self.Entity) then
					v:TakeDamage(20, self.Entity:GetOwner())
					self.Entity:EmitSound(Sound("npc/manhack/grind_flesh" .. math.random(3) .. ".wav"))
				end
			end
		end
	end
	self.Entity:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self.Entity:StopSound(Rocket.Loop)
	self.EngineLoop:FadeOut(0)
end 