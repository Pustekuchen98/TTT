if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
	SWEP.HoldType			= "pistol"
	resource.AddFile("materials/models/gauge.vmt")
	resource.AddFile("materials/models/gauge.vtf")
	resource.AddFile("materials/models/handle.vmt")
	resource.AddFile("materials/models/handle.vtf")
	resource.AddFile("materials/models/hose.vmt")
	resource.AddFile("materials/models/hose.vtf")
	resource.AddFile("materials/models/tank.vmt")
	resource.AddFile("materials/models/tank.vtf")
	resource.AddFile("materials/models/toaster.vmt")
	resource.AddFile("materials/models/toaster.vtf")
	resource.AddFile("materials/models/v_hand_sheet.vmt")
	resource.AddFile("materials/models/v_hand_sheet.vtf")
	resource.AddFile("materials/models/v_hand_sheet_normal.vmt")
	resource.AddFile("materials/models/v_hand_sheet_normal.vtf")
	resource.AddFile("materials/models/waffle.vmt")
	resource.AddFile("materials/models/waffle.vtf")

	resource.AddFile("models/miniwaffle.dx80.vtf")
	resource.AddFile("models/miniwaffle.dx90.vtf")
	resource.AddFile("models/miniwaffle.mdl")
	resource.AddFile("models/miniwaffle.phy")
	resource.AddFile("models/miniwaffle.sw.vtx")
	resource.AddFile("models/miniwaffle.vvd")
	resource.AddFile("models/miniwaffle.xbox.vtx")
	resource.AddFile("models/toaster.dx80.vtx")
	resource.AddFile("models/toaster.dx90.vtx")
	resource.AddFile("models/toaster.mdl")
	resource.AddFile("models/toaster.phy")
	resource.AddFile("models/toaster.sw.vtx")
	resource.AddFile("models/toaster.vvd")
	resource.AddFile("models/toaster.xbox.vtx")
	resource.AddFile("models/waffle.dx80.vtx")
	resource.AddFile("models/waffle.dx90.vtx")
	resource.AddFile("models/waffle.mdl")
	resource.AddFile("models/waffle.phy")
	resource.AddFile("models/waffle.sw.vtx")
	resource.AddFile("models/waffle.vvd")
	resource.AddFile("models/waffle.xbox.vtx")

	resource.AddFile("models/weapons/v_toaster.dx80.vtx")
	resource.AddFile("models/weapons/v_toaster.dx90.vtx")
	resource.AddFile("models/weapons/v_toaster.mdl")
	resource.AddFile("models/weapons/v_toaster.sw.vtx")
	resource.AddFile("models/weapons/v_toaster.vvd")
	resource.AddFile("models/weapons/v_toaster.xbox.vtx")
	resource.AddFile("models/weapons/w_toaster.dx80.vtx")
	resource.AddFile("models/weapons/w_toaster.dx90.vtx")
	resource.AddFile("models/weapons/w_toaster.mdl")
	resource.AddFile("models/weapons/w_toaster.sw.vtx")
	resource.AddFile("models/weapons/w_toaster.vvd")
	resource.AddFile("models/weapons/w_toaster.xbox.vtx")

	resource.AddFile("settings/spawnlist/waffles.txt")

	resource.AddFile("sound/waffle_gun/cook.wav")

end

if (CLIENT) then
	SWEP.PrintName			= "Waffle Gun"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	
	SWEP.EquipMenuData = {
		type = "Waffle Gun.",
		desc = "Spread happiness with\nthe joy of waffles!\nPrimary fire can kill!"
	};

	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 3
end

SWEP.Author		= "Voiderest  Artist: Reefa"
SWEP.Contact		= ""
SWEP.Purpose		= "Make'n Waffles."
SWEP.Instructions	= "Primary: Make a mean waffle. Secondary: Make a nice waffle."

SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP
SWEP.CanBuy = {ROLE_DETECTIVE}
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ViewModel			= "models/weapons/v_toaster.mdl"
SWEP.WorldModel			= "models/weapons/w_toaster.mdl"

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 30
SWEP.Secondary.DefaultClip	= 30
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

/*---------------------------------------------------------
	Initialize
---------------------------------------------------------*/
function SWEP:Initialize()
	util.PrecacheSound("weapons/grenade_launcher1.wav")
	util.PrecacheSound("weapons/slam/mine_mode.wav")
	util.PrecacheSound("waffle_gun/cook.wav")
 	if ( SERVER ) then 
 		self:SetWeaponHoldType( self.HoldType ) 
	end
end

/*---------------------------------------------------------
	Reload
---------------------------------------------------------*/
function SWEP:Reload()
end

function SWEP:make_waffle(nice)
    local tr = self.Owner:GetEyeTrace()
	self.Weapon:EmitSound ("waffle_gun/cook.wav")
    self.BaseClass.ShootEffects (self)
    if (!SERVER) then return end
    local ent1 = ents.Create ("waffle")
	ent1:SetPos (self.Owner:EyePos() + (self.Owner:GetAimVector() * 32) + Vector(0, 0 , -10))
    ent1:SetAngles (self.Owner:EyeAngles()+Angle( 0, 0, 90 ))
    ent1:Spawn()
	local ent2 = ents.Create ("waffle")
	ent2:SetPos (self.Owner:EyePos() + (self.Owner:GetAimVector() * 32) + Vector(0, 0 , -10) + (self.Owner:GetRight()*4))
    ent2:SetAngles (self.Owner:EyeAngles()+Angle( 0, 0, 90 ))
    ent2:Spawn()
    local phys1 = ent1:GetPhysicsObject()
    local phys2 = ent2:GetPhysicsObject()
    local shot_length = tr.HitPos:Length()
	if nice then
		phys1:ApplyForceCenter (self.Owner:GetAimVector() * 10000)
		phys2:ApplyForceCenter (self.Owner:GetAimVector() * 10000)
	else
		phys1:ApplyForceCenter (self.Owner:GetAimVector() * math.pow (shot_length, 3))
		phys2:ApplyForceCenter (self.Owner:GetAimVector() * math.pow (shot_length, 3))
	end
    timer.Simple( 10, function() if ent1:IsValid() then ent1:Remove() end end )
    timer.Simple( 10, function() if ent2:IsValid() then ent2:Remove() end end )
	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 3 )
	self:Idle()
end

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Weapon:TakePrimaryAmmo( 2 )
    self.Weapon:EmitSound ("weapons/grenade_launcher1.wav")
	self:make_waffle(false)
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
	self.Owner:ViewPunch( Angle( -10, 0, 0 ) ) 
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    self.Weapon:EmitSound ("weapons/slam/mine_mode.wav")
	self:make_waffle(true)
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) ) 
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:Idle()
	return true
end

function SWEP:Idle()
	timer.Simple( 3, function() self.Weapon:SendWeaponAnim(ACT_VM_IDLE) end )
end
