//CONTENTS of Interest
//Line 96- Reloading Speed
//Line 150- Entity Velocity Speed
//Line 259- Scope Stages (default is two)

if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "ar2"
	
	resource.AddFile ("materials/models/weapons/v_inf_a35/barrel.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/barrel.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/barrel_mask.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/cartridg.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/cartridge.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/cartridge_mask.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/handle.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/handle.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/handle_mask.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/main.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/main.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/main_mask.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/rails.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/rails.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/rails_mask.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/shell.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/shell.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/shell_mask.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/shell_normal.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/SUSAT.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/SUSAT.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/susat_mask.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/tga.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/tga.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/Vertgrip.vmt")
	resource.AddFile ("materials/models/weapons/v_inf_a35/Vertgrip.vtf")
	resource.AddFile ("materials/models/weapons/v_inf_a35/vertgrip_mask.vtf")
	
	resource.AddFile ("materials/sprites/tf_crosshair_01.vmt")
	resource.AddFile ("materials/sprites/tf_crosshair_01.vtf")
	
	resource.AddFile ("materials/VGUI/entities/weapon_m79.vmt")
	resource.AddFile ("materials/VGUI/entities/weapon_m79.vtf")
	
	resource.AddFile ("materials/weapons/scopes/scope_frontline.vmt")
	resource.AddFile ("materials/weapons/scopes/scope_frontline.vtf")
	
	resource.AddFile ("models/weapons/v_a35.dx80.vtx")
	resource.AddFile ("models/weapons/v_a35.dx90.vtx")
	resource.AddFile ("models/weapons/v_a35.mdl")
	resource.AddFile ("models/weapons/v_a35.sw.vtx")
	resource.AddFile ("models/weapons/v_a35.vvd")
	resource.AddFile ("models/weapons/w_a35.dx80.vtx")
	resource.AddFile ("models/weapons/w_a35.dx90.vtx")
	resource.AddFile ("models/weapons/w_a35.mdl")
	resource.AddFile ("models/weapons/w_a35.sw.vtx")
	resource.AddFile ("models/weapons/w_a35.vvd")
	resource.AddFile ("models/weapons/w_a35.phy")
	
	resource.AddFile ("sound/weapons/A35/40mm_explode.wav")
	resource.AddFile ("sound/weapons/A35/a35_deploy.wav")
	resource.AddFile ("sound/weapons/A35/a35_empty.wav")
	resource.AddFile ("sound/weapons/A35/a35_insert.wav")
	resource.AddFile ("sound/weapons/A35/a35_launch.wav")
	resource.AddFile ("sound/weapons/A35/a35_reload.wav")
	
end

if (CLIENT) then
	SWEP.PrintName 			= "A-35 Launcher"
	SWEP.Author 			= ""
	SWEP.Category			= "Other"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 65
	SWEP.Slot 			= 3
	SWEP.SlotPos 			= 1
	SWEP.Crosshair = 		"sprites/tf_crosshair_01"	//adding later
	
end

// SWEP.Base 			= "weapon_cs_base"

SWEP.Spawnable 			= true
SWEP.AdminSpawnable 		= true

SWEP.ViewModel			= "models/weapons/v_a35.mdl"
SWEP.WorldModel			= "models/weapons/w_a35.mdl"
SWEP.Kind = WEAPON_HEAVY
SWEP.Base = "weapon_tttbase"

SWEP.Primary.Recoil 		= 8.50
SWEP.Primary.Damage 		= 0
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 		= 0.05
SWEP.Primary.ClipSize 		= 8
SWEP.Primary.Delay 		= 0.50
SWEP.Primary.DefaultClip 	= 24
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 		= "sniperround"
SWEP.Primary.DeploySound    	= "weapons/a35/a35_deploy.wav"
// SWEP.Primary.ReloadSound  	= "weapons/xm1014/xm1014_insertshell.wav"	//adding reload sound later on in project
SWEP.Primary.DeployDelay	= 2.5

SWEP.InfiniteAmmo                       = false
SWEP.UseScope                           = true
SWEP.WeaponDeploySpeed                  = 1

SWEP.UnzoomedPrimaryAutomatic           = false
SWEP.UnzoomedPrimaryDelay               = 0.50
SWEP.UnzoomedPrimaryCone                = 0.025
SWEP.UnzoomedPrimaryDamage              = 31
SWEP.UnzoomedPrimaryRecoil              = 1.5
SWEP.UnzoomedTracerFreq                 = 1
SWEP.UnzoomedDrawCrosshair		= false

SWEP.ZoomedPrimaryAutomatic             = false
SWEP.ZoomedPrimaryDelay                 = 0.50
SWEP.ZoomedPrimaryCone                  = 0
SWEP.ZoomedPrimaryDamage                = 31
SWEP.ZoomedPrimaryRecoil                = 1.5
SWEP.ZoomedTracerFreq                   = 0
SWEP.ZoomedDrawCrosshair		= false

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.data 			= {}
SWEP.mode 			= "grenade"
SWEP.data.newclip 		= false

SWEP.data.grenade 		= {}
SWEP.data.grenade.Cone 		= 0
SWEP.data.grenade.NumShots 	= 1
SWEP.data.grenade.Delay		= 1
SWEP.data.grenade.Trace		= None
SWEP.data.grenade.Impact	= None
SWEP.data.grenade.Sound		= Sound("weapons/a35/a35_launch.wav")

function SWEP:Reload()
	
	self:SetZoomed( false )
	
	if ( self.Weapon:GetNetworkedBool( "reloading", false ) ) then return end
	

	if ( self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		
		self.Weapon:SetNetworkedBool( "reloading", true )
		self.Weapon:SetVar( "reloadtimer", CurTime() + 0.3 )
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
                if (SERVER) then
                	self.Owner:SetFOV( self.OriginalFOV, 0.3 )
                end
		self:SetZoomed(false)
                self.ScopeLevel = 0		
	end

end

function SWEP:Think()
	if self.Weapon:Clip1() > self.Primary.ClipSize then
		self.Weapon:SetClip1(self.Primary.ClipSize)
	end
	if self.Weapon:GetNetworkedBool( "reloading") == true then
	
		if self.Weapon:GetNetworkedInt( "reloadtimer") < CurTime() then
			if self.unavailable then return end
			
			if (( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0) && self.Weapon:GetNetworkedInt( "reloadtimer") < CurTime()) then
				local o = CurTime()+.5
				self.Weapon:SetNextPrimaryFire(o)
				self.Weapon:SetNextPrimaryFire(o)
				self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
				self.Weapon:SetNetworkedBool( "reloading", false)
			else
				self.Weapon:SetNetworkedInt( "reloadtimer", CurTime() + .5 )
				self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
				self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
				self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
				if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0) then
					self.Weapon:SetNextPrimaryFire(CurTime()+1.5)
					self.Weapon:SetNextSecondaryFire(CurTime()+1.5)
				else
					self.Weapon:SetNextPrimaryFire(CurTime()+.49)
					self.Weapon:SetNextSecondaryFire(CurTime()+.5)
				end
			end
			
		end
	
	end
end

function SWEP:ReloadAction()
	self.Weapon:SetNetworkedBool( "reloading", false )
	self.Reloading = "no"
end

function SWEP:PrimaryAttack()

	local tr = self.Owner:GetEyeTrace()

	if ( !self:CanPrimaryAttack() ) then return end

	self.Reloadaftershoot = CurTime() + self.Primary.Delay
	self.Weapon:TakePrimaryAmmo( 1 )
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:EmitSound(self.data[self.mode].Sound)

	if self.mode == "grenade" then
		
		local ent = ents.Create ("a35_grenade")
		local PlayerAim = self.Owner:GetAimVector()

		local v = self.Owner:GetShootPos()
			v = v + self.Owner:GetForward() * 5
			v = v + self.Owner:GetRight() * 9
			v = v + self.Owner:GetUp() * -8.5
		ent:SetPos( v )

		ent:SetAngles(PlayerAim:Angle())
		ent.GrenadeOwner = self.Owner
		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		local shot_length = tr.HitPos:Length()

		self.Force = 15000	//velocity of object

		phys:ApplyForceCenter(self.Owner:GetAimVector() * self.Force * 1000 + Vector(0 ,0 ,0))
			
		self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * (self.Primary.Recoil), math.Rand(-1,1) * (self.Primary.Recoil), 0))	

		self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)

		self.Owner:SetAnimation(PLAYER_ATTACK1)
	else
		if (self:GetIronsights() == true) then
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil, self.data[self.mode].NumShots, self.data[self.mode].Cone)

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * 0.2, math.Rand(-1,1) * 0.2, 0))

		else
			self:CSShootBullet(self.data[self.mode].Damage, self.Primary.Recoil, self.data[self.mode].NumShots, self.data[self.mode].Cone)

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * 0.2, math.Rand(-1,1) * 0.2, 0))

		end
	end

	if ((SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
	end
end

function SWEP:CheckReload()

end

function SWEP:DrawHUD()

	if ( self.Weapon:GetNetworkedBool( "Ironsights" ) ) then return end

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0
	local scale = 10 * self.Primary.Cone

	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

	if ( self.Weapon:GetNetworkedBool( "Zoomed" ) ) then
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.SetTexture(surface.GetTextureID("weapons/scopes/scope_frontline"))
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( x - (ScrH() / 2), 0, ScrH(), ScrH() )
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect(0, 0, x - (ScrH() / 2), ScrH() )
		surface.DrawRect(x + (ScrH() / 2), 0, ScrW() - (x + (ScrH() / 2)), ScrH() )
	end

end


function SWEP:SetZoomed( b )

	self.Weapon:SetNetworkedBool( "Zoomed", b )

end

function SWEP:Initialize()

	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
		self:SetNPCMinBurst( 30 )
		self:SetNPCMaxBurst( 30 )
		self:SetNPCFireRate( 0.01 )
	end

        self.Primary.Automatic = self.UnzoomedPrimaryAutomatic
        self.Primary.Delay = self.UnzoomedPrimaryDelay
        self.Primary.Cone = self.UnzoomedPrimaryCone
        self.Primary.Damage = self.UnzoomedPrimaryDamage
        self.Primary.Recoil = self.UnzoomedPrimaryRecoil
        self.TracerFreq = self.UnzoomedTracerFreq
	self.DrawCrosshair = self.UnzoomedDrawCrosshair
        self.ScopeLevel = 0

        self.Weapon:SetDeploySpeed( self.WeaponDeploySpeed )

	self.Weapon:SetNetworkedBool( "Zoomed", false )

	self.Weapon:SetNetworkedBool( "Ironsights", false )

end

function SWEP:AdjustMouseSensitivity()
	if self.ScopeLevel == 0 then
		return -1
	end
	if self.ScopeLevel == 1 then
		return 0.1
	end
end

SWEP.NextSecondaryAttack = 0

function SWEP:SecondaryAttack()
    if not self.IronSightsPos then return end
    if self.Weapon:GetNextSecondaryFire() > CurTime() then return end

    bIronsights = not self:GetIronsights()

    self:SetIronsights( bIronsights )

    if SERVER then
        self:SetZoom(bIronsights)
     else
        self:EmitSound(self.Secondary.Sound)
    end

    self.Weapon:SetNextSecondaryFire( CurTime() + 0.3)
end



function SWEP:SetZoomed( b )

	self.Weapon:SetNetworkedBool( "Zoomed", b )

end

function SWEP:OwnerChanged()

end

function SWEP:Deploy()
	
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Weapon:EmitSound( Sound( self.Primary.DeploySound ) )
	self.Weapon:SetNextPrimaryFire( self.Primary.DeployDelay )
	
	self:SetIronsights(false)

	return true
end

function SWEP:Holster()

	return true
end

function SWEP:CanPrimaryAttack()

	if ( self.Weapon:Clip1() <= 0 ) then
	
		self:EmitSound( "weapons/a35/a35_empty.wav" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false
		
	end

	return true

end

function SWEP:OnRemove()

end

if CLIENT then
   local scope = surface.GetTextureID("sprites/scope")
   function SWEP:DrawHUD()
      if self:GetIronsights() then
         surface.SetDrawColor( 0, 0, 0, 255 )

         local x = ScrW() / 2.0
         local y = ScrH() / 2.0
         local scope_size = ScrH()

         -- crosshair
         local gap = 80
         local length = scope_size
        surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )

         gap = 0
         length = 50
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )


         -- cover edges
         local sh = scope_size / 2
         local w = (x - sh) + 2
         surface.DrawRect(0, 0, w, scope_size)
         surface.DrawRect(x + sh - 2, 0, w, scope_size)

         surface.SetDrawColor(255, 0, 0, 255)
         surface.DrawLine(x, y, x + 1, y + 1)



         -- scope
         surface.SetTexture(scope)
         surface.SetDrawColor(255, 255, 255, 255)

         surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)

      else
         return self.BaseClass.DrawHUD(self)
      end
   end

 function SWEP:AdjustMouseSensitivity()
      return (self:GetIronsights() and 0.2) or nil
   end
end

