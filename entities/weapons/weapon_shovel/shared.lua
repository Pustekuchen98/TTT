if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
	resource.AddFile("materials/models/weapons/shovel/shovel1.vmt")
	resource.AddFile("materials/models/weapons/shovel/shovel1.vtf")
	resource.AddFile("materials/models/weapons/shovel/shovel2.vmt")
	resource.AddFile("materials/models/weapons/shovel/shovel2.vtf")
	resource.AddFile("materials/models/weapons/shovel/shovel3.vmt")
	resource.AddFile("materials/models/weapons/shovel/shovel3.vtf")
	
	resource.AddFile("materials/VGUI/entities/smodshovel_weapon.vmt")
	resource.AddFile("materials/VGUI/entities/smodshovel_weapon.vtf")
	
	resource.AddFile("models/weapons/v_shovel.dx80.vtx")
	resource.AddFile("models/weapons/v_shovel.dx90.vtx")
	resource.AddFile("models/weapons/v_shovel.mdl")
	resource.AddFile("models/weapons/v_shovel.sw.vtx")
	resource.AddFile("models/weapons/v_shovel.vvd")
	resource.AddFile("models/weapons/w_shovel.dx80.vtx")
	resource.AddFile("models/weapons/w_shovel.dx90.vtx")
	resource.AddFile("models/weapons/w_shovel.mdl")
	resource.AddFile("models/weapons/w_shovel.phy")
	resource.AddFile("models/weapons/w_shovel.sw.vtx")
	resource.AddFile("models/weapons/w_shovel.vvd")
	
	resource.AddFile("sound/weapons/shovel/shit1.wav")
	resource.AddFile("sound/weapons/shovel/shit2.wav")
	resource.AddFile("sound/weapons/shovel/shit3.wav")
	resource.AddFile("sound/weapons/shovel/shit4.wav")
	resource.AddFile("sound/weapons/shovel/shit5.wav")
	
	resource.AddFile("sound/weapons/shovel/shovel_fire.wav")
	resource.AddFile("sound/weapons/shovel/shovel_hit1.wav")
	resource.AddFile("sound/weapons/shovel/shovel_hit2.wav")
	resource.AddFile("sound/weapons/shovel/shovel_hit3.wav")
	resource.AddFile("sound/weapons/shovel/shovel_stab.wav")
	
end

if( CLIENT ) then
	SWEP.PrintName = "SMOD Shovel";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;
end

SWEP.Author			= "Jedrek"
SWEP.Instructions	= "Left click to hit someone/something. Right click to change hitting mode"
SWEP.Contact		= "No contacts for you :P."
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= true
SWEP.Kind = WEAPON_HEAVY
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;
  
SWEP.ViewModel      = "models/weapons/v_shovel.mdl"
SWEP.WorldModel   = "models/weapons/w_shovel.mdl"
  
-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 2 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 9999	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= -1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type

SWEP.Secondary.Delay			= 0.4 	--In seconds
SWEP.Secondary.Recoil			= 0		--Gun Kick
SWEP.Secondary.Damage			= 15	--Damage per Bullet
SWEP.Secondary.NumShots		= 1		--Number of shots per one fire
SWEP.Secondary.Cone			= 0 	--Bullet Spread
SWEP.Secondary.ClipSize		= -1	--Use "-1 if there are no clips"
SWEP.Secondary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Secondary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Secondary.Ammo         	= "none"	--Ammo Type

util.PrecacheSound("weapons/shovel/shovel_hit1.wav")
util.PrecacheSound("weapons/shovel/shovel_hit2.wav")
util.PrecacheSound("weapons/shovel/shovel_fire.wav")
util.PrecacheSound("weapons/shovel/shit1.wav")
util.PrecacheSound("weapons/shovel/shit1.wav")
util.PrecacheSound("weapons/shovel/shit1.wav")
util.PrecacheSound("weapons/shovel/shit1.wav")
util.PrecacheSound("weapons/shovel/shit1.wav")

SWEP.Animations = {
   ACT_VM_PRIMARYATTACK_1,
   ACT_VM_PRIMARYATTACK_2,
   ACT_VM_PRIMARYATTACK_4,
   ACT_VM_PRIMARYATTACK_5,
}

SWEP.Animations.Count = #SWEP.Animations

function SWEP:Initialize()
	if( SERVER ) then
			self:SetWeaponHoldType("melee");
	end
	self.Hit = { 
	Sound( "weapons/shovel/shovel_hit2.wav" )};
	self.FleshHit = {
  	Sound( "weapons/shovel/shovel_hit1.wav" ),
	Sound( "weapons/shovel/shit1.wav" ),
	Sound( "weapons/shovel/shit2.wav" ),
  	Sound( "weapons/shovel/shit3.wav" ),
	Sound( "weapons/shovel/shit4.wav" ),
	Sound( "weapons/shovel/shit5.wav" ) } ;
self.mode = 1
self.changemode = 0
end

function SWEP:Precache()
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_IDLE );
	return true;
end

function SWEP:PrimaryAttack()
if self.mode == 1 then
	if( CurTime() < self.NextStrike ) then return; end
	 self.NextStrike = ( CurTime() + 1.1 );
	 timer.Simple( 0.1, self.ThirdPAnim, self )
     timer.Simple( 0.30, self.ShootBullets, self )
	 self.Owner:SetAnimation( PLAYER_ATTACK1 );
	 self:SendWeaponAnim( self.Animations[ math.random( self.Animations.Count ) ] )
	 
elseif self.mode == 2 then
    if( CurTime() < self.NextStrike ) then return; end
	 self.NextStrike = ( CurTime() + 1.1 );
	 timer.Simple( 0.1, self.ThirdPAnim, self );
	 timer.Simple( 0.30, self.ModeTwo, self );
	 self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_3 );
	 self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
elseif self.mode == 3 then
	if( CurTime() < self.NextStrike ) then return; end
	 self.NextStrike = ( CurTime() + 2.0 );
	 self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_1 );
	 timer.Simple( 0.8, function() self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_5 ) end);
	 timer.Simple( 1.1, function() self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_4 ) end);
	 timer.Simple( 1.4, function() self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_5 ) end);
	 timer.Simple( 1.7, function() self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_4 ) end);
	 timer.Simple( 0.28, self.ModeThree, self );
	 timer.Simple( 0.75, self.ModeThree, self );
	 timer.Simple( 1.05, self.ModeThree, self );
	 timer.Simple( 1.35, self.ModeThree, self );
	 timer.Simple( 1.75, self.ModeThree, self );
	 timer.Simple( 0.1, self.ThirdPAnim, self );
	 timer.Simple( 0.6, self.ThirdPAnim, self );
	 timer.Simple( 0.9, self.ThirdPAnim, self );
	 timer.Simple( 1.2, self.ThirdPAnim, self );
	 timer.Simple( 1.5, self.ThirdPAnim, self ); 
	 
    end
end

function SWEP:ShootBullets()
	self.Weapon:EmitSound("weapons/shovel/shovel_fire.wav");
 	local trace = self.Owner:GetEyeTrace();
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 110 then
		if( trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass()=="prop_ragdoll" ) then
			self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] );
		else
			self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] );
		end
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 22
				bullet.Damage = 45
			self.Owner:FireBullets(bullet)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:ThirdPAnim()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:SecondaryAttack()
if self.mode == 1 and CurTime() > self.changemode then
self.changemode = CurTime() + 1
self.mode = 2
elseif self.mode == 2 and CurTime() > self.changemode then
self.changemode = CurTime() + 1
self.mode = 3
elseif self.mode == 3 and CurTime() > self.changemode then
self.changemode = CurTime() + 1
self.mode = 1
end

end

function SWEP:ModeTwo()	 
	self.Weapon:EmitSound("weapons/shovel/shovel_fire.wav");
 	local trace = self.Owner:GetEyeTrace();
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 110 then
		if( trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass()=="prop_ragdoll" ) then
			self.Owner:EmitSound( "weapons/shovel/shovel_stab.wav" );
		else
			self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] );
		end
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 30
				bullet.Damage = 30
			self.Owner:FireBullets(bullet)
	end
end

function SWEP:ModeThree()
	self.Weapon:EmitSound("weapons/shovel/shovel_fire.wav");
 	local trace = self.Owner:GetEyeTrace();
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 110 then
		if( trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass()=="prop_ragdoll" ) then
			self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] );
		else
			self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] );
		end
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 10
				bullet.Damage = 15
			self.Owner:FireBullets(bullet)
	end
end
