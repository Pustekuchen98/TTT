if SERVER then
	AddCSLuaFile( "shared.lua" )

	resource.AddFile ("materials/VGUI/ttt/ied_detonator.vmt")
	resource.AddFile ("materials/VGUI/ttt/ied.vtf")
end

// Variables that are used on both client and server
SWEP.Gun = ("ied_detonator")
SWEP.Category				= "Other"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.Kind				= WEAPON_EQUIP
SWEP.DrawCrosshair			= false	
SWEP.Slot				= 3
SWEP.CanBuy				= {ROLE_TRAITOR}
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "fist"
SWEP.Icon = "VGUI/ttt/ied_detonator.vmt"

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_camphone.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Round 			= ("improvised_explosive")	--NAME OF ENTITY GOES HERE

SWEP.Primary.RPM			= 20					// This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1					// Size of a clip
SWEP.Primary.DefaultClip		= 1					// Default number of bullets in a clip
SWEP.Primary.Automatic			= false					// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Grenade"

SWEP.Secondary.ClipSize			= 1					// Size of a clip
SWEP.Secondary.DefaultClip		= 1					// Default number of bullets in a clip
SWEP.Secondary.Automatic		= false					// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""

function SWEP:Initialize()
	//if SERVER then
	self:SetWeaponHoldType("fist")
	//end

	    if CLIENT then
	
		SWEP.PrintName = "IED Detonator"
		SWEP.Slot = 3
		
		SWEP.EquipMenuData = {
			type = "IED",
			desc = "Remotely detonated bomb."
		};

     
        // Create a new table for every weapon instance
        self.VElements = table.FullCopy( self.VElements )
        self.WElements = table.FullCopy( self.WElements )
        self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
 
        self:CreateModels(self.VElements) // create viewmodels
        self:CreateModels(self.WElements) // create worldmodels
         
        // init view model bone build 
        self.BuildViewModelBones = function( s )
            if LocalPlayer():GetActiveWeapon() == self and self.ViewModelBoneMods then
                for k, v in pairs( self.ViewModelBoneMods ) do
                    local bone = s:LookupBone(k)
                    if (!bone) then continue end
                    local m = s:GetBoneMatrix(bone)
                    if (!m) then continue end
                    m:Scale(v.scale)
                    m:Rotate(v.angle)
                    m:Translate(v.pos)
                    s:SetBoneMatrix(bone, m)
                end
            end
        end
         
    end
	return true
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	//self:SetWeaponHoldType("grenade")                          	// Hold type styles; ar2 pistol shotgun rpg normal melee grenade smg slam fist melee2 passive knife
	return true
end

function SWEP:Precache()
	//util.PrecacheSound("RPG7F.single")
end


function SWEP:PrimaryAttack()
	if self:CanPrimaryAttack() then
		self.Weapon:TakePrimaryAmmo(1)
//		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
		timer.Simple( 0.2, self.Throw, self )

	end
end

function SWEP:Throw()
	//self.Owner:SetAnimation(PLAYER_ATTACK1)
	timer.Simple( 0, self.Grenada, self )
	timer.Simple( 1, self.Reload, self )
end


function SWEP:Grenada()
	aim = self.Owner:GetAimVector()
	side = aim:Cross(Vector(0,0,1))
	up = side:Cross(aim)
	pos = self.Owner:GetShootPos() + side * -5 + up * -10
	if SERVER then
	local rocket = ents.Create(self.Primary.Round)
	if !rocket:IsValid() then return false end
	rocket:SetNWEntity("Owner", self.Owner)
	rocket:SetAngles(aim:Angle()+Angle(90,0,0))
	rocket:SetPos(pos)
	rocket:SetOwner(self.Owner)
	rocket.Owner = self.Owner
	rocket:SetNWEntity("Owner", self.Owner)
	rocket:Spawn()
	local phys = rocket:GetPhysicsObject()
	phys:ApplyForceCenter(self.Owner:GetAimVector() * 1500)
	end
end

function SWEP:SecondaryAttack()

 	for k, v in pairs ( ents.FindByClass( "improvised_explosive") ) do	
		if v:GetNWEntity("Owner") == self.Owner then
			v.Boom=true end
	end	
	
	timer.Simple(.01, self.checkitycheckyoself, self)
	
end	

function SWEP:checkitycheckyoself()

		if self.Weapon:Clip1() == 0 
		&& self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) == 0 then
			self:NotYours()
		end
		
end

function SWEP:NotYours()
//	self.Owner:StripWeapon(self.Gun)
end

// bonemod stuff below just ignore
if CLIENT then
 
    SWEP.Icon = "VGUI/ttt/ied_detonator.vmt"
    SWEP.vRenderOrder = nil
    function SWEP:ViewModelDrawn()
         
        local vm = self.Owner:GetViewModel()
        if !ValidEntity(vm) then return end
         
        if (!self.VElements) then return end
         
        if vm.BuildBonePositions != self.BuildViewModelBones then
            vm.BuildBonePositions = self.BuildViewModelBones
        end
 
        if (self.ShowViewModel == nil or self.ShowViewModel) then
            vm:SetColor(255,255,255,255)
        else
            // we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
            vm:SetColor(255,255,255,1)
        end
         
        if (!self.vRenderOrder) then
             
            // we build a render order because sprites need to be drawn after models
            self.vRenderOrder = {}
 
            for k, v in pairs( self.VElements ) do
                if (v.type == "Model") then
                    table.insert(self.vRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.vRenderOrder, k)
                end
            end
             
        end
 
        for k, name in ipairs( self.vRenderOrder ) do
         
            local v = self.VElements[name]
            if (!v) then self.vRenderOrder = nil break end
         
            local model = v.modelEnt
            local sprite = v.spriteMaterial
             
            if (!v.bone) then continue end
             
            local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
             
            if (!pos) then continue end
             
            if (v.type == "Model" and ValidEntity(model)) then
 
                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
 
                model:SetAngles(ang)
                model:SetModelScale(v.size)
                 
                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() != v.material) then
                    model:SetMaterial( v.material )
                end
                 
                if (v.skin and v.skin != model:GetSkin()) then
                    model:SetSkin(v.skin)
                end
                 
                if (v.bodygroup) then
                    for k, v in pairs( v.bodygroup ) do
                        if (model:GetBodygroup(k) != v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end
                 
                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end
                 
                render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
                render.SetBlend(v.color.a/255)
                model:DrawModel()
                render.SetBlend(1)
                render.SetColorModulation(1, 1, 1)
                 
                if (v.surpresslightning) then
                    render.SuppressEngineLighting(false)
                end
                 
            elseif (v.type == "Sprite" and sprite) then
                 
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial(sprite)
                render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
                 
            elseif (v.type == "Quad" and v.draw_func) then
                 
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                 
                cam.Start3D2D(drawpos, ang, v.size)
                    v.draw_func( self )
                cam.End3D2D()
 
            end
             
        end
         
    end
 
    SWEP.wRenderOrder = nil
    function SWEP:DrawWorldModel()
         
        if (self.ShowWorldModel == nil or self.ShowWorldModel) then
            self:DrawModel()
        end
         
        if (!self.WElements) then return end
         
        if (!self.wRenderOrder) then
 
            self.wRenderOrder = {}
 
            for k, v in pairs( self.WElements ) do
                if (v.type == "Model") then
                    table.insert(self.wRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.wRenderOrder, k)
                end
            end
 
        end
         
        if (ValidEntity(self.Owner)) then
            bone_ent = self.Owner
        else
            // when the weapon is dropped
            bone_ent = self
        end
         
        for k, name in pairs( self.wRenderOrder ) do
         
            local v = self.WElements[name]
            if (!v) then self.wRenderOrder = nil break end
             
            local pos, ang
             
            if (v.bone) then
                pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
            else
                pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
            end
             
            if (!pos) then continue end
             
            local model = v.modelEnt
            local sprite = v.spriteMaterial
             
            if (v.type == "Model" and ValidEntity(model)) then
 
                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
 
                model:SetAngles(ang)
                model:SetModelScale(v.size)
                 
                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() != v.material) then
                    model:SetMaterial( v.material )
                end
                 
                if (v.skin and v.skin != model:GetSkin()) then
                    model:SetSkin(v.skin)
                end
                 
                if (v.bodygroup) then
                    for k, v in pairs( v.bodygroup ) do
                        if (model:GetBodygroup(k) != v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end
                 
                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end
                 
                render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
                render.SetBlend(v.color.a/255)
                model:DrawModel()
                render.SetBlend(1)
                render.SetColorModulation(1, 1, 1)
                 
                if (v.surpresslightning) then
                    render.SuppressEngineLighting(false)
                end
                 
            elseif (v.type == "Sprite" and sprite) then
                 
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial(sprite)
                render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
                 
            elseif (v.type == "Quad" and v.draw_func) then
                 
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                 
                cam.Start3D2D(drawpos, ang, v.size)
                    v.draw_func( self )
                cam.End3D2D()
 
            end
             
        end
         
    end
 
    function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
         
        local bone, pos, ang
        if (tab.rel and tab.rel != "") then
             
            local v = basetab[tab.rel]
             
            if (!v) then return end
             
            // Technically, if there exists an element with the same name as a bone
            // you can get in an infinite loop. Let's just hope nobody's that stupid.
            pos, ang = self:GetBoneOrientation( basetab, v, ent )
             
            if (!pos) then return end
             
            pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                 
        else
         
            bone = ent:LookupBone(bone_override or tab.bone)
 
            if (!bone) then return end
             
            pos, ang = Vector(0,0,0), Angle(0,0,0)
            local m = ent:GetBoneMatrix(bone)
            if (m) then
                pos, ang = m:GetTranslation(), m:GetAngle()
            end
             
            if (ValidEntity(self.Owner) and self.Owner:IsPlayer() and
                ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
                ang.r = -ang.r // Fixes mirrored models
            end
         
        end
         
        return pos, ang
    end
 
    function SWEP:CreateModels( tab )
 
        if (!tab) then return end
 
        // Create the clientside models here because Garry says we can't do it in the render hook
        for k, v in pairs( tab ) do
            if (v.type == "Model" and v.model and v.model != "" and (!ValidEntity(v.modelEnt) or v.createdModel != v.model) and
                    string.find(v.model, ".mdl") and file.Exists ("../"..v.model) ) then
                 
                v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
                if (ValidEntity(v.modelEnt)) then
                    v.modelEnt:SetPos(self:GetPos())
                    v.modelEnt:SetAngles(self:GetAngles())
                    v.modelEnt:SetParent(self)
                    v.modelEnt:SetNoDraw(true)
                    v.createdModel = v.model
                else
                    v.modelEnt = nil
                end
                 
            elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite)
                and file.Exists ("../materials/"..v.sprite..".vmt")) then
                 
                local name = v.sprite.."-"
                local params = { ["$basetexture"] = v.sprite }
                // make sure we create a unique name based on the selected options
                local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
                for i, j in pairs( tocheck ) do
                    if (v[j]) then
                        params["$"..j] = 1
                        name = name.."1"
                    else
                        name = name.."0"
                    end
                end
 
                v.createdSprite = v.sprite
                v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
                 
            end
        end
         
    end
 
    /**************************
        Global utility code
    **************************/
 
    // Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
    // Does not copy entities of course, only copies their reference.
    // WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
    function table.FullCopy( tab )
 
        if (!tab) then return nil end
         
        local res = {}
        for k, v in pairs( tab ) do
            if (type(v) == "table") then
                res[k] = table.FullCopy(v) // recursion ho!
            elseif (type(v) == "Vector") then
                res[k] = Vector(v.x, v.y, v.z)
            elseif (type(v) == "Angle") then
                res[k] = Angle(v.p, v.y, v.r)
            else
                res[k] = v
            end
        end
         
        return res
         
    end
     
end

SWEP.ViewModelBoneMods = {
	["v_weapon.Right_Pinky01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-6.814, -11.752, 0) },
	["v_weapon.Right_Thumb01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-39.007, 9.437, 0) },
	["v_weapon.Right_Index03"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 22.069, 0) },
	["v_weapon.Right_Ring03"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 36.312, 0) },
	["v_weapon.Right_Ring02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 61.724, 0) },
	["v_weapon.Right_Middle03"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 26.739, 0) },
	["v_weapon.Right_Ring01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 3.78, 0) },
	["v_weapon.Right_Middle01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 18.7, 0) },
	["v_weapon.Right_Index01"] = { scale = Vector(1, 1, 1), pos = Vector(0.582, 0, 0), angle = Angle(0, 11.956, 0) },
	["v_weapon.Knife_Handle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["v_weapon.Root26"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.144, 0), angle = Angle(0, 0, 0) },
	["v_weapon.Right_Middle02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 65.137, 0) },
	["v_weapon.Right_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-2.72, 14.6, 34.013) },
	["v_weapon.Right_Pinky02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.889, 5.419, 0) },
	["v_weapon.Right_Pinky03"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.744, 28.268, 0) },
	["v_weapon.Root27"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.288, 0), angle = Angle(0, 0, 0) },
	["v_weapon.Root28"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.87, 0), angle = Angle(0, 18.993, 0) },
	["v_weapon.Left_Arm"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) },
	["v_weapon.Right_Index02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 83.18, 0) }
}

SWEP.VElements = {
	["phone"] = { type = "Model", model = "models/weapons/w_camphon2.mdl", bone = "v_weapon.Knife_Handle", rel = "", pos = Vector(2.631, -2.471, 3.223), angle = Angle(-0.369, -139.825, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
//	["screen"] = { type = "Quad", bone = "v_weapon.knife_Parent", rel = "phone", pos = Vector(3.157, -0.65, 2.292), angle = Angle(0, -90.006, 90.543), size = 0.041, draw_func = 
//		function( weapon )
//           draw.SimpleText("Send?", "default", 0, 0, Color(0,0,205,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
//        end}
}
