if ( SERVER ) then

AddCSLuaFile( "shared.lua" )

SWEP.HoldType = "Pistol"

resource.AddFile ("materials/VGUI/ttt/icon.deagle.vmt")
resource.AddFile ("materials/VGUI/ttt/icon.deagle.vtf")

end

if ( CLIENT ) then
SWEP.Category = "E-deagle";
SWEP.PrintName = "E-deagle"
SWEP.Author = "Ultimatly Awes0me!"
SWEP.Contact		= ""
SWEP.Purpose = ""
SWEP.Instructions = "Primary:Lightning"
SWEP.Slot = 3
SWEP.IconLetter = "f"

SWEP.EquipMenuData = {
                type = "Electric DEagle",
                desc = "Lightning cannon.\nUse responsibly.\nAim away from face."
        };




SWEP.Icon = "VGUI/ttt/icon_deagle.vmt"

SWEP.ViewModelFlip		= true

killicon.AddFont("cse_deagle","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))

end

SWEP.DrawCrosshair = true
SWEP.DrawAmmo = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_PISTOL
SWEP.ViewModel			= "models/weapons/v_pist_deagle.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_deagle.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false


SWEP.Primary.Recoil = 20
SWEP.Primary.Damage = 50
SWEP.Primary.NumShots = 0
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = 1
SWEP.Primary.Delay = 4
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Recoil = 20
SWEP.Secondary.Damage = 50
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0.0
SWEP.Secondary.ClipSize = 9999
SWEP.Secondary.Delay = 0.0
SWEP.Secondary.DefaultClip = 9998
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"


function SWEP:PrimaryAttack()


if ( !self:CanPrimaryAttack() ) then return end

self.Weapon:EmitSound(Sound("Weapon_DEagle.Single"))

self:ShootBullet( 0, 0, 0 )

self:TakePrimaryAmmo( 0 )

self.Owner:ViewPunch( Angle( 0, 0, 0 ) )
self.Weapon:SetNextPrimaryFire( CurTime() + 0.15 )

local trace = self.Owner:GetEyeTrace()
local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetNormal( trace.HitNormal )
effectdata:SetEntity( trace.Entity )
effectdata:SetAttachment( trace.PhysicsBone )
util.Effect( "super_explosion", effectdata )

local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetStart( self.Owner:GetShootPos() )
effectdata:SetAttachment( 1 )
effectdata:SetEntity( self.Weapon )
util.Effect( "ToolTracer", effectdata )
if (SERVER) then
local owner=self.Owner
if self.Owner.SENT then
owner=self.Owner.SENT.Entity
end

local explosion = ents.Create( "env_explosion" )
explosion:SetPos(trace.HitPos)
explosion:SetKeyValue( "iMagnitude" , "30" )
explosion:SetPhysicsAttacker(owner)
explosion:SetOwner(owner)
explosion:Spawn()
explosion:Fire("explode","",0)
explosion:Fire("kill","",0 )

end
end

