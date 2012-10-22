if SERVER then 
	AddCSLuaFile ( "shared.lua" )
end

SWEP.PrintName            = "Speed booster"
SWEP.Slot                = 3
SWEP.SlotPos            = 2
SWEP.DrawAmmo            = false
SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP
SWEP.Weight                = 5
SWEP.Author            = "Cal"
SWEP.Contact        = ""
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Purpose        = "Run Fast"
SWEP.Instructions    = "Woop!"
SWEP.ViewModel            = "models/weapons/v_pistol.mdl"
SWEP.WorldModel            = "models/weapons/w_pistol.mdl"

if CLIENT then

   SWEP.PrintName    = "Speed booster";
   SWEP.Slot         = 3;
   SWEP.SlotPos = 2;

   SWEP.ViewModelFlip = false;

   SWEP.EquipMenuData = {
      type = "Speed booster",
      desc = "Zoom!"
   };


end


SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic        = false
SWEP.Primary.Ammo            = "none"
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo            = "none"
/*---------------------------------------------------------
    Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
end

/*---------------------------------------------------------
   Think does nothing
---------------------------------------------------------*/
function SWEP:Think()
end


/*---------------------------------------------------------
    PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

    self.Owner:PrintMessage( HUD_PRINTCENTER, "Speed Activated" )
    self.Owner:SetRunSpeed(2500)
    self.Owner:SetWalkSpeed(1250)

    local effectdata2 = EffectData()
    effectdata2:SetStart( self.Owner:GetPos() + Vector(0,0,60) )
    effectdata2:SetOrigin( self.Owner:GetPos()  + Vector(0,0,60) )
    effectdata2:SetScale( 1 )
    util.Effect( "balloon_pop", effectdata2 )

    self.Owner:EmitSound("npc/combine_soldier/vo/off1.wav", 500, 200)

end

/*---------------------------------------------------------
    SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

    self.Owner:PrintMessage( HUD_PRINTCENTER, "Speed Deactivated" )
    self.Owner:SetRunSpeed(500)
    self.Owner:SetWalkSpeed(250)

    local effectdata2 = EffectData()
    effectdata2:SetStart( self.Owner:GetPos() + Vector(0,0,60) )
    effectdata2:SetOrigin( self.Owner:GetPos()  + Vector(0,0,60) )
    effectdata2:SetScale( 1 )
    util.Effect( "balloon_pop", effectdata2 )

    self.Owner:EmitSound("npc/combine_soldier/vo/off1.wav", 500, 200)

end
