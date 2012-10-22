AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
local melonparts = {
	"models/props_junk/watermelon01_chunk01a.mdl",
	"models/props_junk/watermelon01_chunk01b.mdl",
	"models/props_junk/watermelon01_chunk01c.mdl",
	"models/props_junk/watermelon01_chunk02a.mdl",
	"models/props_junk/watermelon01_chunk02b.mdl",
	"models/props_junk/watermelon01_chunk02c.mdl",
	}
local melonpartsnum = 35

for k,v in pairs(melonparts) do
	util.PrecacheModel(v)
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create("sent_melonade")
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
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
	for i=1, melonpartsnum do
		local melonpart = ents.Create("prop_physics")
		melonpart:SetModel(melonparts[math.random(1, table.Count(melonparts))])
		melonpart:SetPos(self.Entity:GetPos())
		melonpart:Spawn()
		local c 
		if math.random(1,2) == 1 then
			c = Color(255,0,0,255)
		else
			c = Color(0,255,0,255)
		end
		util.SpriteTrail(melonpart,0, c, false, 28, 0, 7, 1/14, "trails/lol.vmt")
		local phys = melonpart:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:SetMass(500)
			phys:Wake()
			phys:ApplyForceCenter(Vector(math.random(5-5000,5000),math.random(5-5000,5000),math.random(5-5000,5000))*phys:GetMass())
		end
		melonpart:Fire("kill", "", "1.5")
	end
	self.Entity:Remove()
end