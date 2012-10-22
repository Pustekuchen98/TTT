include('shared.lua')

language.Add("sniperround_ammo", "40 mm Shell")

if (file.Exists("../materials/weapons/weapon_m79.vmt")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_m79")
end

function SWEP:CustomAmmoDisplay()
end

function SWEP:DrawWorldModel()
	
	self.Weapon:DrawModel()
end

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)

	surface.SetDrawColor(255, 255, 255, alpha)
	surface.SetTexture(self.WepSelectIcon)
	
	local fsin = 0
	
	if (self.BounceWeaponIcon == true) then
		fsin = math.sin(CurTime() * 10) * 5
	end
	
	y = y + 10
	x = x + 10
	wide = wide - 20
	
	surface.DrawTexturedRect(x + (fsin), y - (fsin), wide - fsin * 2, (wide / 2) + (fsin))
	
	self:PrintWeaponInfo(x + wide + 20, y + tall * 0.95, alpha)
end

function SWEP:AdjustMouseSensitivity()

	return nil	
end