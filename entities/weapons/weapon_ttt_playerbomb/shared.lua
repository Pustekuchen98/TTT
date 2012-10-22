if SERVER then
   AddCSLuaFile( "shared.lua" )
end   
   
SWEP.HoldType			= "normal"

SWEP.Slot				= 6
if CLIENT then
   SWEP.PrintName			= "Sticky bomb"
   SWEP.Instructions		= ""
   SWEP.Slot				= 6
   SWEP.SlotPos			= 0
   SWEP.IconLetter			= "u"
   
   SWEP.EquipMenuData = {
      type="Weapon",
      model="models/weapons/w_slam.mdl",
      name="Sticky bomb",
      desc="Bomb that can be placed on a player\nwithout them knowing it.\nCan be detonated on a dead player!"
   };

   SWEP.Icon = "VGUI/ttt/icon_list"
end

SWEP.Base = "weapon_tttbase"

SWEP.Spawnable          = false
SWEP.AdminSpawnable     = true
SWEP.ViewModel          = "models/weapons/v_c4.mdl"
SWEP.WorldModel         = "models/weapons/w_c4.mdl" --w_c4.mdl
SWEP.Weight         = 50
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false
SWEP.DrawCrosshair      = false
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo       = "none"
SWEP.Primary.Delay = 1.0

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = true
SWEP.Secondary.Ammo     = "none"
SWEP.Secondary.Delay = 1.0

SWEP.Planted = false;

SWEP.Kind = WEAPON_EQUIP
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.LimitedStock = true
SWEP.WeaponID = AMMO_PBOMB

SWEP.AllowDrop = true;

SWEP.BeepSound = Sound( "C4.PlantSound" );

local hidden = true;
local close = false;
local lastclose = false;

if CLIENT then
	function SWEP:DrawHUD( )
		local planted = self:GetNWBool( "Planted" );
		local tr = LocalPlayer( ):GetEyeTrace( );
		local close2;
		
		if tr.Entity:IsPlayer( ) and LocalPlayer( ):GetPos( ):Distance( tr.Entity:GetPos( ) ) <= 160 then
			close2 = true;
		else
			close2 = false;
		end;
		
		local planted_text = "Not Planted!";
		local close_text = "Not Close Enough!";
		
		if planted then
			if hidden == true then
				hidden = false
			end
			planted_text = "Planted!\nSecondary to Explode!";
			
			surface.SetFont( "ChatFont" );
			local size_x, size_y = surface.GetTextSize( planted_text );
			
			draw.RoundedBox( 6, ScrW( ) / 2 - size_x / 2 - 5, ScrH( ) - 100, size_x + 15, size_y + 10, Color( 0, 0, 0, 150 ) );
			draw.DrawText( planted_text, "ChatFont", ScrW( ) / 2, ScrH( ) - 100 + 5, Color( 255, 30, 30, 255 ), TEXT_ALIGN_CENTER );
		else
			if close2 then
				close_text = "You are Close Enough!\nPrimary to Plant!";
			end;
			
			surface.SetFont( "ChatFont" );
			local size_x, size_y = surface.GetTextSize( planted_text );
			
			surface.SetFont( "ChatFont" );
			local size_x2, size_y2 = surface.GetTextSize( close_text );
			
			draw.RoundedBox( 6, ScrW( ) / 2 - ( size_x2 / 2 ) - 7.5, ScrH( ) - 100, size_x2 + 20, size_y + size_y2 + 10, Color( 0, 0, 0, 150 ) );
			draw.DrawText( planted_text, "ChatFont", ScrW( ) / 2, ScrH( ) - 100 + 5, Color( 30, 30, 255, 255 ), TEXT_ALIGN_CENTER );
			draw.DrawText( close_text, "ChatFont", ScrW( ) / 2 , ScrH( ) - 100 + size_y + 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER );
		end;
	end;
end;

function SWEP:OnDrop()
	if SERVER then
	end
	self:Remove()
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end;

function SWEP:Think( )
	local ply = self.Owner;
	if not ValidEntity( ply ) then return; end;
	
	local tr = ply:GetEyeTrace( );
	
	if tr.Entity:IsPlayer( ) and ply:GetPos( ):Distance( tr.Entity:GetPos( ) ) <= 160 then
		close = true;
	else
		close = false;
	end;
	
	if self:GetNWBool( "Planted" ) == false then
		if lastclose == false and close then
			self.Weapon:SendWeaponAnim( ACT_SLAM_STICKWALL_ATTACH );
		elseif lastclose == true and not close then
			self.Weapon:SendWeaponAnim( ACT_SLAM_STICKWALL_IDLE );
		end;
	end;
	
	lastclose = close;
	
	if not hidden then
		if close and not self:GetNWBool( "Planted" ) then
			self.Weapon:SendWeaponAnim( ACT_SLAM_STICKWALL_ATTACH );
		elseif not close and not self:GetNWBool( "Planted" ) then
			self.Weapon:SendWeaponAnim( ACT_SLAM_STICKWALL_IDLE );
		elseif self:GetNWBool( "Planted" ) then
			self.Weapon:SendWeaponAnim( ACT_SLAM_DETONATOR_DRAW );
		end;
	end;
        if SERVER and not hidden and ValidEntity(self.Owner) and self.Owner:GetActiveWeapon() == self.Weapon then
      		self.Owner:DrawViewModel(false)
      		self.Owner:DrawWorldModel(false)
      		hidden = true
   	end
end;

function SWEP:PrimaryAttack()
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
   
   local ply = self.Owner;
   if not ValidEntity( ply ) then return; end;
   
   local tr = ply:GetEyeTrace(MASK_SHOT);
   
   if not self:GetNWBool( "Planted" ) then
		if close then
			if SERVER then
				self.PlantedPly = tr.Entity
				self:SetNWBool("Planted", true)
			end;
			self.Weapon:SendWeaponAnim( ACT_SLAM_STICKWALL_ATTACH2 );
		end;
			if hidden == true and self:GetNWBool( "Planted" ) == true then
				hidden = false
			end
   end;
end

function SWEP:SecondaryAttack()
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
   if self:GetNWBool( "Planted" ) and not self.JustSploded then
		self:BombSplode()
   end;
end

function SWEP:DoSplode( owner, plantedply, bool )
	if not bool then
		timer.Simple( 1, function( ) plantedply:EmitSound( self.BeepSound ); end );
		timer.Simple( 2, function( ) plantedply:EmitSound( self.BeepSound ); end );
		timer.Simple( 3, function( ) plantedply:EmitSound( self.BeepSound ); end );
		timer.Simple( 4, function( )
			local effectdata = EffectData()
			effectdata:SetOrigin(plantedply:GetPos())
			util.Effect("HelicopterMegaBomb", effectdata)
			
			plantedply.PlayerBombDie = true;
			
			local explosion = ents.Create("env_explosion")
			explosion:SetOwner(self.Owner)
			explosion:SetPos(plantedply:GetPos( ) + Vector( 0, 0, 10 ))
			explosion:SetKeyValue("iMagnitude", "170")
			explosion:SetKeyValue("iRadiusOverride", 0) 
			explosion:Spawn()
			explosion:Activate()
			explosion:Fire("Explode", "", 0)
			explosion:Fire("kill", "", 0)
			
			self.Owner:ConCommand( "use weapon_ttt_unarmed" );
			self:Remove( );
		end );
	else
		timer.Simple( 1, function( ) plantedply:EmitSound( self.BeepSound ); end );
		timer.Simple( 2, function( ) plantedply:EmitSound( self.BeepSound ); end );
		timer.Simple( 3, function( ) plantedply:EmitSound( self.BeepSound ); end );
		timer.Simple( 4, function( )
			local effectdata = EffectData()
			effectdata:SetOrigin(plantedply:GetPos())
			util.Effect("HelicopterMegaBomb", effectdata)
			
			local explosion = ents.Create("env_explosion")
			explosion:SetOwner(self.Owner)
			explosion:SetPos(plantedply:GetPos( ))
			explosion:SetKeyValue("iMagnitude", "170")
			explosion:SetKeyValue("iRadiusOverride", 0) 
			explosion:Spawn()
			explosion:Activate()
			explosion:Fire("Explode", "", 0)
			explosion:Fire("kill", "", 0)
			
			plantedply:Remove( );
			
			if self.Owner:GetActiveWeapon( ) == self then
				self.Owner:ConCommand( "use weapon_zm_improvised" );
			end;
			self:Remove( );
		end );
	end;
end;

function SWEP:BombSplode()
	local ply = self.Owner;
	if not ValidEntity( ply ) then return; end;
	
	if ValidEntity( self.PlantedPly ) and self.PlantedPly:Alive( ) then
		if SERVER then
			self:DoSplode( self.Owner, self.PlantedPly, false );
			self.JustSploded = true;
		end;
		self.Weapon:SendWeaponAnim( ACT_SLAM_DETONATOR_DETONATE );
	else
		if SERVER then
			if ValidEntity( self.PlantedPly ) and ValidEntity( self.PlantedPly.server_ragdoll ) then
				self:DoSplode( self.Owner, self.PlantedPly.server_ragdoll, true );
				self.JustSploded = true;
			else
				ply:PrintMessage( HUD_PRINTTALK, "The body this bomb has been planted to is no longer available!" );
			end;
		end;
		self.Weapon:SendWeaponAnim( ACT_SLAM_DETONATOR_DETONATE );
	end;
end;

function SWEP:Deploy( )
	//hidden = false;
	if self:GetNWBool( "Planted" ) == true then
		self:SetWeaponHoldType("normal")
		hidden = false
	end
	return true
end;

function SWEP:Reload()
   return false
end

function SWEP:OnDrop()
   self:Remove()
end

function SWEP:OnRemove()
   if CLIENT and ValidEntity(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
      RunConsoleCommand("lastinv")
   end
end
