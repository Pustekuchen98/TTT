/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
///////////////////////Realistic Chainsaw////////////////
////////////Made by Archemyde////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include ("shared.lua")
include ("cl_init.lua")
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false



function SWEP:Think()
	if !self.Owner or self.Owner == NULL then return end
	if self.Owner:KeyPressed(IN_ATTACK) then
	idlesound:Stop()
	attacksound:Play()
	elseif self.Owner:KeyReleased(IN_ATTACK) then
	attacksound:Stop()
	idlesound:Play()
	else
	end
end
function SWEP:Holster()
	timer.Destroy( "IdleSound" )
	idlesound:Stop() -- stops the sound
	attacksound:Stop()
	self.Weapon:EmitSound("weapons/arch_chainsaw/chainsaw_die_01.wav")
	self.Weapon:StopSound("weapons/arch_chainsaw/chainsaw_start_01")
	self.Weapon:StopSound("weapons/arch_chainsaw/chainsaw_start_02")
	return true
end

