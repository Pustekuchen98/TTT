
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction(ply, tr) // Spawn function needed to make it appear on the spawn menu
	if (!tr.HitWorld) then return end

	local ent = ents.Create("mini_waffle") // Create the entity
	ent:SetPos(tr.HitPos + Vector(0, 0, 10))
	ent:Spawn() // Spawn it

	return ent // You need to return the entity to make it work
end 

function ENT:Initialize()
	
	self.Entity:SetModel( "models/miniwaffle.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS ) // Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS ) // after all, gmod is a physics
	self.Entity:SetSolid( SOLID_VPHYSICS ) // Toolbox
	
	util.PrecacheSound("vo/SandwichEat09.wav")
	util.PrecacheSound("")
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
	
	if ( activator:IsPlayer() ) then
		activator:EmitSound ("vo/SandwichEat09.wav")
		local health = activator:Health()
		activator:SetHealth( health + 5 )
		self.Entity:Remove()
	end
end


