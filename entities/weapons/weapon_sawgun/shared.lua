if (SERVER) then
	AddCSLuaFile("shared.lua")
end

SWEP.base = "weapon_base"
SWEP.Author = "Ender Wiggin";
SWEP.Contact = "Find me on darklandservers.com";
SWEP.Purpose = "To pwn things";
SWEP.Instructions = "Shoot to Kill";
SWEP.PrintName = "Razorblade Gun";
SWEP.Slot = 7;
SWEP.SlotPos = 1;
SWEP.DrawCrosshair = true;
SWEP.DrawAmmo = false;
SWEP.ViewModel = "models/weapons/v_RPG.mdl";
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl";
SWEP.ViewModelFOV = 64;
SWEP.HoldType = "pistol";
SWEP.Spawnable = false;
SWEP.AdminSpawnable = true;
SWEP.Weight = 3;
SWEP.AutoSwitchTo = false;
SWEP.AutoSwitchFrom = true;
SWEP.FiresUnderwater = true;

SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP

SWEP.Primary.ClipSize = 9999;
SWEP.Primary.DefaultClip = 9999;
SWEP.Primary.Recoil = 0;
SWEP.Primary.Spread = 0;
SWEP.Primary.Delay = 0.15;
SWEP.Primary.Automatic = true;
SWEP.Primary.TakeAmmo = 0;
SWEP.Primary.Message = "/n";
SWEP.Primary.Sound = "weapons/ar2/fire1.wav";


function SWEP:PrimaryAttack()
self.Weapon:EmitSound("weapons/crossbow/fire1.wav")
self.Weapon:SetNextPrimaryFire(CurTime() + 0.1)
self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
if SERVER then
local bar = ents.Create("prop_physics")
bar:SetModel("models/props_junk/sawblade001a.mdl")
bar:SetAngles(self.Owner:EyeAngles())-- Angle(0,90,0))
bar:SetPos(self.Owner:GetShootPos())
bar:SetOwner(self.Owner)
bar:SetPhysicsAttacker(self.Owner)
bar:Spawn()
local phys = bar:GetPhysicsObject()
phys:ApplyForceCenter(self.Owner:GetAimVector() * 1999999999)
phys:AddAngleVelocity(Vector(0,7500000,0))
bar:Fire("kill", "", 5)
end
end

function SWEP:Think()
end

function SWEP:Reload()
   self.Weapon:DefaultReload(ACT_VM_RELOAD)
   return true
end

function SWEP:Deploy()
   self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
   GAMEMODE:SetPlayerSpeed(self.Owner,190,350);
   return true
end

function SWEP:Holster()
   return true
end

function SWEP:OnRemove()
end

function SWEP:OnRestore()
end

function SWEP:Precache()
end

function SWEP:OwnerChanged()
end

function SWEP:Initialize()
    util.PrecacheSound(self.Primary.Sound)
     util.PrecacheSound(self.Secondary.Sound)
    if ( SERVER ) then
       self:SetWeaponHoldType( self.HoldType )
   end
end
function SWEP:throw_attack (model_file)
    local tr = self.Owner:GetEyeTrace();
    self.Weapon:EmitSound (self.Primary.Sound);
    self.BaseClass.ShootEffects (self);
    if (!SERVER) then return end;
    local ent = ents.Create ("prop_physics");
    ent:SetModel (model_file);
    ent:SetPos (self.Owner:EyePos() + (self.Owner:GetAimVector() * 16));
    ent:SetAngles (self.Owner:EyeAngles());
    ent:Spawn();
    local phys = ent:GetPhysicsObject();
    local shot_length = tr.HitPos:Length();
    phys:ApplyForceCenter (self.Owner:GetAimVector():GetNormalized() * math.pow (shot_length, 3));
    cleanup.Add (self.Owner, "props", ent);
    undo.Create ("Thrown model");
    undo.AddEntity (ent);
    undo.SetPlayer (self.Owner);
    undo.Finish();
end

