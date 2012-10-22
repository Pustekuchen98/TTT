
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.StartDelay = CurTime() + 4
ENT.StartOnce = 0
ENT.StopDelay = CurTime()+19

ENT.MicroWaveSound = NULL
ENT.BangOne = NULL
ENT.BagnTwo = NULL


function ENT:Initialize()
	self.Entity:SetModel( "models/dav0r/hoverball.mdl")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	self.Entity:SetColor(255, 255, 255, 255)

	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)

	self.Entity:SetSolid(SOLID_VPHYSICS)	
    local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end

self.MicroWaveSound = CreateSound(self.Entity,"Microwave/WaveGrenade.mp3")

self.BangOne = CreateSound(self.Entity,"Microwave/Boom1.wav")
self.BagnTwo = CreateSound(self.Entity,"Microwave/Boom2.wav")

end

function ENT:PhysicsCollide( data, phys ) 

end

function ENT:Think()

	if CurTime() >= self.StartDelay then

		if self.StartOnce == 0 then
		self.StartOnce = 1
		self.MicroWaveSound:Play()
		end


	end

	
end

