AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self.Entity:SetModel("models/items/meloadeammo.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	timer.Simple(1, self.Explode, self)
end

function ENT:Explode()
	local Effect = EffectData()
	Effect:SetOrigin(self.Entity:GetPos())
	Effect:SetScale(1)
	Effect:SetMagnitude(50)
	util.Effect("Explosion", Effect, true, true)
	self.Entity:Remove()
	local melonpart = ents.Create("sent_melonade")
	melonpart:SetPos(self.Entity:GetPos())
	melonpart:Spawn()
	local phys = melonpart:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:SetMass(150)
		phys:Wake()
		phys:ApplyForceCenter(Vector(0,0,1)*50000)
	end
end