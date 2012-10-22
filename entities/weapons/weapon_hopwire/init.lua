AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function SWEP:Holster( )
	if timer.IsTimer("anim_timer"..tostring(self.Weapon)) then
		timer.Remove("anim_timer"..tostring(self.Weapon))
	end

	return true
end

function SWEP:Reload()
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()

	util.PrecacheSound( "buttons/button3.wav" )
	self.Weapon:EmitSound( "buttons/button3.wav", 100, 100 )

	if (!SERVER) then return end

	local ent = ents.Create( "hopwire" )
	ent:SetNetworkedBool( "Active", false )
	ent:SetPos( self.Owner:GetShootPos() )
	ent:SetAngles( self.Owner:GetAimVector() )
	ent:Spawn()
	ent:Activate()
	//ent:SetOwner(self.Owner)
	ent:GetPhysicsObject():ApplyForceCenter( self.Owner:GetAimVector() * 3000 )

	//self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )

	//self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_LOW )

	self.Weapon:SendWeaponAnim( ACT_VM_THROW )

	//self.Weapon:SetNextPrimaryFire( CurTime() + 1.2 )

	undo.Create("Hopwire")
	undo.AddEntity( ent )
	undo.SetPlayer( self.Owner )
	undo.Finish()

	timer.Create( "anim_timer"..tostring(self.Weapon), 0.1, 1, self.ResetAnim, self )

end

function SWEP:ResetAnim( )

	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )

end

function SWEP:SecondaryAttack()

	util.PrecacheSound( "buttons/button3.wav" )
	self.Weapon:EmitSound( "buttons/button3.wav", 100, 100 )

	if (!SERVER) then return end

	local ent = ents.Create( "hopwire_trap" )
	ent:SetNetworkedBool( "Active", false )
	ent:SetPos( self.Owner:GetShootPos() )
	ent:SetAngles( self.Owner:GetAimVector() )
	ent:Spawn()
	ent:Activate()
	//ent:SetOwner(self.Owner)
	ent:SetVar( "Owner", self.Owner )
	ent:GetPhysicsObject():ApplyForceCenter( self.Owner:GetAimVector() * 2000 )

	//self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )

	//self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_LOW )

	self.Weapon:SendWeaponAnim( ACT_VM_THROW )

	//self.Weapon:SetNextSecondaryFire( CurTime() + 1.2 )

	undo.Create("Hopwire")
	undo.AddEntity( ent )
	undo.SetPlayer( self.Owner )
	undo.Finish()

	timer.Create( "anim_timer"..tostring(self.Weapon), 0.1, 1, self.ResetAnim, self )

end
