/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
///////////////////////Realistic Chainsaw////////////////
////////////Made by Archemyde////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
include ("shared.lua")
SWEP.PrintName = "Chainsaw"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 57
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

SWEP.Slot = 6
XNameBlur = 0
XNameBlur2 = 0
YNameBlur = 0
YNameBlur2 = 0

local color_blur1 = Color(100, 20, 0, 220)
local color_blur2 = Color(100, 20, 0, 140)
local smoke = { 
	"particle/smokesprites_0001",
	"particle/smokesprites_0002",
	"particle/smokesprites_0003",
	"particle/smokesprites_0004",
	"particle/smokesprites_0005",
	"particle/smokesprites_0006",
	"particle/smokesprites_0007",
	"particle/smokesprites_0008",
	"particle/smokesprites_0009",
	"particle/smokesprites_0010",
	"particle/smokesprites_0012",
	"particle/smokesprites_0013",
	"particle/smokesprites_0014",
	"particle/smokesprites_0015",
	"particle/smokesprites_0016"
}

function SWEP:Think()
emitter:SetPos(self:GetPos())
local BoneIndx = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
local position = self.Owner:GetBonePosition( BoneIndx )
local particle = emitter:Add( table.Random(smoke), position)
		particle:SetDieTime( 1 )
		particle:SetStartAlpha( 10 )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( 0 )
		particle:SetEndSize( math.Rand( 20, 30 ) )
		particle:SetRoll( math.Rand( 360, 480 ) )
		particle:SetRollDelta( math.Rand( -1, 1 ) )
		particle:SetColor( 180, 180, 180 )
		particle:SetVelocity(VectorRand()*10+vector_up*40)
		particle:SetGravity(Vector(math.Rand(-100,100),math.Rand(-100,100),math.Rand(150,200)))
		particle:SetAirResistance(100)
		particle:SetCollide(true)
end
