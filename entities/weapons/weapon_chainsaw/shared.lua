/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
///////////////////////Realistic Chainsaw////////////////
////////////Made by Archemyde////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
if SERVER then
	AddCSLuaFile( "shared.lua" )
	resource.AddFile ("models/weapons/v_chainsaw.mdl")
	resource.AddFile ("models/weapons/w_chainsaw.mdl")
	resource.AddFile ("sound/weapons/arch_chainsaw/chainsaw_attack.wav")
	resource.AddFile ("sound/weapons/arch_chainsaw/chainsaw_die_01.wav")
	resource.AddFile ("sound/weapons/arch_chainsaw/chainsaw_idle.wav")
	resource.AddFile ("sound/weapons/arch_chainsaw/chainsaw_start_01.wav")
	resource.AddFile ("sound/weapons/arch_chainsaw/chainsaw_start_02.wav")
	resource.AddFile ("materials/effects/blooddrop.vmt")
	resource.AddFile ("materials/effects/bloodstream.vmt")
	resource.AddFile ("materials/models/weapons/w_chainsaw/body.vmt")
	resource.AddFile ("materials/models/weapons/w_chainsaw/body.vtf")
	resource.AddFile ("materials/models/weapons/w_chainsaw/body_n.vtf")
	resource.AddFile ("materials/models/weapons/w_chainsaw/chainsaw.vmt")
	resource.AddFile ("materials/models/weapons/w_chainsaw/chainsaw.vtf")
	resource.AddFile ("materials/models/weapons/w_chainsaw/chainsaw_chain.vmt")
	resource.AddFile ("materials/models/weapons/w_chainsaw/chainsaw_chain.vtf")
	resource.AddFile ("materials/models/weapons/w_chainsaw/chainsaw_exp.vtf")
	resource.AddFile ("materials/models/weapons/w_chainsaw/parts.vmt")
	resource.AddFile ("materials/models/weapons/w_chainsaw/parts.vtf")
	resource.AddFile ("materials/models/weapons/w_chainsaw/parts_n.vtf")
	resource.AddFile ("materials/models/weapons/v_chainsaw/body.vmt")
	resource.AddFile ("materials/models/weapons/v_chainsaw/body.vtf")
	resource.AddFile ("materials/models/weapons/v_chainsaw/body_n.vtf")
	resource.AddFile ("materials/models/weapons/v_chainsaw/chainsaw.vmt")
	resource.AddFile ("materials/models/weapons/v_chainsaw/chainsaw.vtf")
	resource.AddFile ("materials/models/weapons/v_chainsaw/chainsaw_chain.vmt")
	resource.AddFile ("materials/models/weapons/v_chainsaw/chainsaw_chain.vtf")
	resource.AddFile ("materials/models/weapons/v_chainsaw/chainsaw_exp.vtf")
	resource.AddFile ("materials/models/weapons/v_chainsaw/parts.vmt")
	resource.AddFile ("materials/models/weapons/v_chainsaw/parts.vtf")
	resource.AddFile ("materials/models/weapons/v_chainsaw/parts_n.vtf")

	resource.AddFile ("materials/archysaw/sprite_bloodspray1.vmt")
	resource.AddFile ("materials/archysaw/sprite_bloodspray2.vmt")
	resource.AddFile ("materials/archysaw/sprite_bloodspray3.vmt")
	resource.AddFile ("materials/archysaw/sprite_bloodspray4.vmt")
	resource.AddFile ("materials/archysaw/sprite_bloodspray5.vmt")
	resource.AddFile ("materials/archysaw/sprite_bloodspray6.vmt")
	resource.AddFile ("materials/archysaw/sprite_bloodspray7.vmt")
	resource.AddFile ("materials/archysaw/sprite_bloodspray8.vmt")
	resource.AddFile ("materials/vgui/entities/realistic_chainsaw.vmt")
	resource.AddFile ("materials/vgui/entities/realistic_chainsaw.vtf")

end


sounds = {
	"attack",
	"die_01",
	"idle",
	"start_01", 
	"start_02"
}

SWEP.Author = "Archemyde"
SWEP.Base = "weapon_tttbase"
SWEP.ViewModel = "models/weapons/v_chainsaw.mdl"
SWEP.WorldModel = "models/weapons/w_chainsaw.mdl"
SWEP.Category = "Archy's SWEPs"
SWEP.Kind			= WEAPON_EQUIP
SWEP.Spawnable = true
SWEP.Slot			= 6
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 8
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 0.01

if CLIENT then

SWEP.EquipMenuData = {
                type = "Chainsaw",
                desc = "Overpowered meat slicer.\nPrimary to carve,\nsecondary to rev."
        };

end



SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Damage = 45
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 1.2

SWEP.WalkSpeed = 215
SWEP.HoldType = "physgun"

SWEP.LastShootTime = 0

SWEP.IsMelee = true

function SWEP:Initialize()
    self:SetWeaponHoldType("physgun")
	self:SetDeploySpeed(0.5)
	self.LastShootTime = 0
	chainsawidle_Sound = Sound("weapons/arch_chainsaw/chainsaw_idle.wav")
idlesound = CreateSound(self.Weapon, chainsawidle_Sound )
chainsawattack_Sound = Sound("weapons/arch_chainsaw/chainsaw_attack.wav")
attacksound = CreateSound(self.Weapon, chainsawattack_Sound )
if CLIENT then
emitter = ParticleEmitter(self:GetPos())
end
end
function SWEP:Deploy()
	self.Weapon:EmitSound( "weapons/arch_chainsaw/chainsaw_start_0"..math.random( 1, 2 )..".wav",40,100 )
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	timer.Create( "IdleSoundStart", 3, 1, function()
idlesound:Play() -- starts the sound
end
)
end

function SWEP:Reload()
	return false
end

function SWEP:Precache()
	util.PrecacheSound("physics/wood/wood_plank_impact_hard1.wav")
	util.PrecacheSound("physics/wood/wood_plank_impact_hard2.wav")
	util.PrecacheSound("physics/wood/wood_plank_impact_hard3.wav")
	util.PrecacheSound("physics/wood/wood_plank_impact_hard4.wav")
	util.PrecacheSound("physics/wood/wood_plank_impact_hard5.wav")
	util.PrecacheSound("physics/flesh/flesh_impact_bullet1.wav")
	util.PrecacheSound("physics/flesh/flesh_impact_bullet2.wav")
	util.PrecacheSound("physics/flesh/flesh_impact_bullet3.wav")
	util.PrecacheSound("physics/flesh/flesh_impact_bullet4.wav")
	util.PrecacheSound("physics/flesh/flesh_impact_bullet5.wav")
	util.PrecacheSound("weapons/knife/knife_slash1.wav")
	util.PrecacheSound("weapons/knife/knife_slash2.wav")
end
local function StabCallback(attacker, trace, dmginfo)
	if trace.Hit and trace.HitPos:Distance(trace.StartPos) <= 62 then
	attacksound:ChangePitch( 50 )
		attacker:GetActiveWeapon():SendWeaponAnim(ACT_VM_HITCENTER)
		attacker:ViewPunch( Angle( math.random(-1,1), math.random(-1,1), 0 ) )
		if trace.MatType == MAT_FLESH or trace.MatType == MAT_BLOODYFLESH or trace.MatType == MAT_ANTLION or trace.MatType == MAT_ALIENFLESH then
			local effectdata = EffectData()
			effectdata:SetOrigin(trace.HitPos)
			effectdata:SetMagnitude(math.random(1, 3))
			effectdata:SetEntity(ent)
			util.Effect("bloodstream", effectdata)
			util.Decal("Blood", trace.HitPos + trace.HitNormal * 8, trace.HitPos - trace.HitNormal * 8)
				else
				local Effect = EffectData()
				Effect:SetOrigin(trace.HitPos)
				Effect:SetEntity(ent)
				Effect:SetMagnitude(0.2)
				Effect:SetScale(0.2)
				Effect:SetRadius(5)
				Effect:SetColor(Color(0,0,255,255))
				util.Effect("sparks", Effect)
				attacker:EmitSound( "npc/manhack/grind"..math.random( 1, 5 )..".wav",40,100 )
				util.Decal("ManhackCut", trace.HitPos + trace.HitNormal * 8, trace.HitPos - trace.HitNormal * 8)
		end
		if trace.Entity:IsValid() then
			return {damage = true, effects = false}
		end
	else
	attacksound:ChangePitch( 100 )
		attacker:GetActiveWeapon():SendWeaponAnim(ACT_VM_HITCENTER)
		if SERVER then
			--attacker:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 40, math.random(65, 70))
		end
	end
	return {effects = false, damage = false}
end
local function SlashCallback(attacker, trace, dmginfo)
	if trace.Hit and trace.HitPos:Distance(trace.StartPos) <= 62 then
		attacker:GetActiveWeapon():SendWeaponAnim(ACT_VM_MISSCENTER)
		if trace.MatType == MAT_FLESH or trace.MatType == MAT_BLOODYFLESH or trace.MatType == MAT_ANTLION or trace.MatType == MAT_ALIENFLESH then
			local effectdata = EffectData()
			effectdata:SetOrigin(trace.HitPos)
			effectdata:SetMagnitude(math.random(1, 3))
			effectdata:SetEntity(ent)
			util.Effect("bloodstream", effectdata)
			util.Decal("Blood", trace.HitPos + trace.HitNormal * 8, trace.HitPos - trace.HitNormal * 8)
				else
				local Effect = EffectData()
				Effect:SetOrigin(trace.HitPos)
				Effect:SetEntity(ent)
				Effect:SetMagnitude(0.2)
				Effect:SetScale(0.2)
				Effect:SetRadius(5)
				Effect:SetColor(Color(0,0,255,255))
				util.Effect("sparks", Effect)
				attacker:EmitSound( "npc/manhack/grind_flesh"..math.random( 1, 3 )..".wav", 40, 50 )
				util.Decal("ManhackCut", trace.HitPos + trace.HitNormal * 8, trace.HitPos - trace.HitNormal * 8)
		end
		if trace.Entity:IsValid() then
			return {damage = true, effects = false}
		end
	else
		attacker:GetActiveWeapon():SendWeaponAnim(ACT_VM_MISSCENTER)
		if SERVER then
			--attacker:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 40, math.random(65, 70))
		end
	end
	return {effects = false, damage = false}
end
function SWEP:CanPrimaryAttack()
	if self.Owner:Team() == TEAM_UNDEAD then self.Owner:PrintMessage(HUD_PRINTCENTER, "Great Job!") self.Owner:Kill() return false end
	if self.Owner:GetNetworkedBool("IsHolding") then return false end

	return self:CanSecondaryAttack()
end
function SWEP:CanSecondaryAttack()
	if self.Owner:Team() == TEAM_UNDEAD then self.Owner:PrintMessage(HUD_PRINTCENTER, "Great Job!") self.Owner:Kill() return false end
	if self.Owner:GetNetworkedBool("IsHolding") then return false end

	return self:GetNextSecondaryFire() <= CurTime()
end

function SWEP:PrimaryAttack()
	if self:CanSecondaryAttack() then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self.Owner:ViewPunch( Angle( math.random(-0.5,0.5), math.random(-0.5,0.5), 0 ) )
		if CLIENT then return end
		
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force = 2
		bullet.Damage = self.Primary.Damage
		bullet.HullSize = 1.75
		bullet.Callback = StabCallback
		self.Owner:FireBullets(bullet)
	end
end
function SWEP:SecondaryAttack()
	if self:CanSecondaryAttack() then
		self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
		self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
		self:SetWeaponHoldType("melee2")
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self.Owner:EmitSound("weapons/arch_chainsaw/chainsaw_die_01.wav", 30, 100)
		self.Owner:ViewPunch( Angle( -10, 0, 0 ) )
			timer.Create( "setmeleetype", 0.5, 1, function()
			self:SetWeaponHoldType("physgun")
			end)
			timer.Create( "Down", 0.1, 1, function()
			self.Owner:ViewPunch( Angle( 10, 0, 0 ) )
			end)
		if CLIENT then return end
		
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force = 2
		bullet.Damage = self.Secondary.Damage
		bullet.HullSize = 1.75
		bullet.Callback = SlashCallback
		self.Owner:FireBullets(bullet)
	end
end
function SWEP:Holster()
	timer.Destroy( "IdleSound" )
	idlesound:Stop() -- stops the sound
	attacksound:Stop()
	self.Owner:EmitSound("weapons/arch_chainsaw/chainsaw_die_01.wav",30,100)
	self.Owner:StopSound("weapons/arch_chainsaw/chainsaw_start_01",30,100)
	self.Owner:StopSound("weapons/arch_chainsaw/chainsaw_start_02",30,100)
	return true
end
if CLIENT then

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	draw.SimpleText(self.PrintName, "HUDFontSmallAA", x + wide * 0.5, y + tall * 0.5, COLOR_RED, TEXT_ALIGN_CENTER)
	draw.SimpleText(self.PrintName, "HUDFontSmallAA", XNameBlur2 + x + wide * 0.5, YNameBlur + y + tall * 0.5, color_blur1, TEXT_ALIGN_CENTER)
	draw.SimpleText(self.PrintName, "HUDFontSmallAA", XNameBlur + x + wide * 0.5, YNameBlur + y + tall * 0.5, color_blu1, TEXT_ALIGN_CENTER)
end

end
