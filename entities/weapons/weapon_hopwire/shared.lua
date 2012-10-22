if SERVER then
	AddCSLuaFile( "shared.lua" )
	resource.AddFile("models/weapons/V_hopwire.dx80.vtx")
	resource.AddFile("models/weapons/V_hopwire.dx90.vtx")
	resource.AddFile("models/weapons/V_hopwire.sw.vtx")
	resource.AddFile("models/weapons/v_hopwire.mdl")
	resource.AddFile("models/weapons/v_hopwire.vvd")
	resource.AddFile("models/weapons/w_hopwire.dx80.vtx")
	resource.AddFile("models/weapons/w_hopwire.dx90.vtx")
	resource.AddFile("models/weapons/w_hopwire.mdl")
	resource.AddFile("models/weapons/w_hopwire.phy")
	resource.AddFile("models/weapons/w_hopwire.sw.vtx")
	resource.AddFile("models/weapons/w_hopwire.vvd")
	resource.AddFile("models/weapons/w_hopwire.jpg")

	resource.AddFile("materials/models/weapons/W_Hopwire/ball_sphere.vmt")
	resource.AddFile("materials/models/weapons/W_Hopwire/ball_sphere.vtf")


end

SWEP.Author		= "craze"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "Left click to throw a Hopwire.\nRight click to throw a Hopwire mine."
SWEP.HoldType = "grenade"
SWEP.Base = "weapon_tttbase"
SWEP.Kind			= WEAPON_EQUIP

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model("models/weapons/v_hopwire.mdl")
SWEP.WorldModel			= Model("models/weapons/w_hopwire.mdl")

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.PrintName			= "Hopwire"			
SWEP.Slot			= 0
SWEP.SlotPos			= 0
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

if CLIENT then

	SWEP.PrintName = "Hopwire"
	SWEP.Slot = 3
	
	SWEP.EquipMenuData = {
		type = "Hopwire grenade",
		desc = "Boom."
	};

end

