if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
	resource.AddFile ("materials/Jaanus/rpc/rpc_blade.vmt")
	resource.AddFile ("materials/Jaanus/rpc/rpc_blade.vtf")
	resource.AddFile ("materials/Jaanus/rpc/rpc_blade_spec.vtf")
	resource.AddFile ("materials/Jaanus/rpc/rpc_body.vmt")
	resource.AddFile ("materials/Jaanus/rpc/rpc_body.vtf")
	resource.AddFile ("materials/Jaanus/rpc/rpc_body_spec.vtf")
	resource.AddFile ("materials/Jaanus/rpc/rpc_launcher.vmt")
	resource.AddFile ("materials/Jaanus/rpc/rpc_launcher.vtf")
	resource.AddFile ("materials/Jaanus/rpc/rpc_launcher_spec.vtf")

	resource.AddFile ("materials/rpc/selicon.vmt")
	resource.AddFile ("materials/rpc/selicon.vtf")
	
	resource.AddFile ("materials/rpc/selicon.vmt")
	resource.AddFile ("materials/rpc/selicon.vmt")
	
	resource.AddFile ("materials/VGUI/entities/rocket_propelled_chainsaw.vmt")
	resource.AddFile ("materials/VGUI/entities/rocket_propelled_chainsaw.vtf")
	
	resource.AddFile ("models/jaanus/rpc.dx80.vtx")
	resource.AddFile ("models/jaanus/rpc.dx90.vtx")
	resource.AddFile ("models/jaanus/rpc.mdl")
	resource.AddFile ("models/jaanus/rpc.phy")
	resource.AddFile ("models/jaanus/rpc.sw.vtx")
	resource.AddFile ("models/jaanus/rpc.vvd")
	resource.AddFile ("models/jaanus/rpc_launcher.dx80.vtx")
	resource.AddFile ("models/jaanus/rpc_launcher.dx90.vtx")
	resource.AddFile ("models/jaanus/rpc_launcher.mdl")
	resource.AddFile ("models/jaanus/rpc_launcher.phy")
	resource.AddFile ("models/jaanus/rpc_launcher.sw.vtx")
	resource.AddFile ("models/jaanus/rpc_launcher.vvd")
	
	resource.AddFile ("models/weapons/v_rpc.dx80.vtx")
	resource.AddFile ("models/weapons/v_rpc.dx90.vtx")
	resource.AddFile ("models/weapons/v_rpc.mdl")
	resource.AddFile ("models/weapons/v_rpc.sw.vtx")
	resource.AddFile ("models/weapons/v_rpc.vvd")
	
	resource.AddFile ("models/weapons/w_rpc.dx80.vtx")
	resource.AddFile ("models/weapons/w_rpc.dx90.vtx")
	resource.AddFile ("models/weapons/w_rpc.mdl")
	resource.AddFile ("models/weapons/w_rpc.sw.vtx")
	resource.AddFile ("models/weapons/w_rpc.phy")
	resource.AddFile ("models/weapons/w_rpc.vvd")
	
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Rocket Propelled Chainsaw"			
	SWEP.Author				= "Feihc"

	SWEP.Slot				= 4
	SWEP.SlotPos			= 3
	SWEP.ViewModelFOV		= 70
	SWEP.IconLetter			= "x"

	killicon.AddFont( "rocket_propelled_chainsaw", "HL2MPTypeDeath", "3", Color( 255, 255, 255, 255 ) );
	
end
-----------------------Main functions----------------------------
 
SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_HEAVY
 
function SWEP:Think() -- Called every frame
end

function SWEP:Initialize()
	if SERVER then
		self:SetWeaponHoldType(self.HoldType)
	end
end

function SWEP:PrimaryAttack()
	if self.Weapon:Clip1() <= 0 then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:TakePrimaryAmmo(1)
	
	local pos, dir = self.Weapon:GetAttachment(1).Pos, self.Weapon:GetAttachment(1).Ang
	local effect = EffectData()
		effect:SetOrigin(pos)
		effect:SetAngle(dir)
		effect:SetEntity(self.Weapon)
		effect:SetAttachment(1)
	util.Effect("MuzzleEffect", effect) 
	
	self.Owner:ViewPunch(Angle(-10,0,0))
	if SERVER then
		self.Owner:SetLocalVelocity(self.Owner:GetAimVector() * -250)
		
		local rocket = ents.Create("rpc_rocket")
			rocket:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector() * 50 + self.Owner:GetRight() * 10)
			rocket:SetAngles(self.Owner:EyeAngles())
			rocket:SetOwner(self.Owner)
			rocket.Baring = self.Owner:EyeAngles()
		rocket:Spawn()
		
		local phys = rocket:GetPhysicsObject()
		phys:ApplyForceCenter(self.Owner:GetAimVector() * 15000)
	end
end

-------------------------------------------------------------------

------------General Swep Info---------------
SWEP.Author   = "Feihc"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""
SWEP.Spawnable      = true
SWEP.AdminSpawnable  = true
-----------------------------------------------

------------Models---------------------------
SWEP.ViewModel      = "models/weapons/v_rpc.mdl"
SWEP.WorldModel   = "models/weapons/w_rpc.mdl"
-----------------------------------------------

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.9 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 15	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= 1	--Number of shots in next clip
SWEP.Primary.Automatic   	= false	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "rpg_round"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------
