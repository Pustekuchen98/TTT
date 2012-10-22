
local tMats = {}
tMats.Glow1 = Material("sprites/light_glow02")
tMats.Glow2 = Material("sprites/flare1")

for _,mat in pairs(tMats) do

	mat:SetMaterialInt("$spriterendermode",9)
	mat:SetMaterialInt("$ignorez",1)
	mat:SetMaterialInt("$illumfactor",8)
	
end

local SmokeParticleUpdate = function(particle)

	if particle:GetStartAlpha() == 0 and particle:GetLifeTime() >= 0.5*particle:GetDieTime() then
		particle:SetStartAlpha(particle:GetEndAlpha())
		particle:SetEndAlpha(0)
		particle:SetNextThink(-1)
	else
		particle:SetNextThink(CurTime() + 0.1)
	end

	return particle

end


function EFFECT:Init(data)

	self.Scale = data:GetScale()
	self.ScaleSlow = math.sqrt(self.Scale)
	self.ScaleSlowest = math.sqrt(self.ScaleSlow)
	self.Normal = data:GetNormal()
	self.RightAngle = self.Normal:Angle():Right():Angle()
	self.Position = data:GetOrigin() - 12*self.Normal
	self.Position2 = self.Position + self.Scale*64*self.Normal

	local CurrentTime = CurTime()
	self.Duration = 0.5*self.Scale 
	self.KillTime = CurrentTime + self.Duration
	self.GlowAlpha = 200
	self.GlowSize = 100*self.Scale
	self.FlashAlpha = 100
	self.FlashSize = 0

	local emitter = ParticleEmitter(self.Position)


		




		
		--shock wave
			for i=1,math.ceil(self.Scale*20) do

				local vecang = Vector(math.Rand(-1,1),math.Rand(-1,1),0):GetNormalized()
				local velocity = math.Rand(1000,1000)*vecang
				local particle = emitter:Add("sprites/heatwave", self.Position - vecang*64*self.Scale - Vector(0,0,80*self.ScaleSlowest))
				local dietime = 1
				particle:SetVelocity(velocity)
				particle:SetDieTime(dietime)
				particle:SetLifeTime(0)
				particle:SetStartAlpha(100)
				particle:SetEndAlpha(0)
				particle:SetStartSize(160*self.ScaleSlowest)
				particle:SetEndSize(200*self.ScaleSlowest)
				particle:SetColor(255,255,255)

         end


--Mushroom Cloud
		for i=1,math.ceil(self.Scale*25) do

			local vecang = self.RightAngle
			vecang:RotateAroundAxis(self.Normal,math.Rand(0,360))
			vecang = vecang:Forward() + VectorRand()*0.1
			local velocity = math.Rand(100,500)*vecang
			local particle = emitter:Add("particles/mat1",  self.Position - vecang*32*self.Scale - self.Normal*16)
			local dietime = math.Rand(5.5,5.9)*self.Scale
			particle:SetVelocity(velocity*self.Scale)
			particle:SetGravity(Vector(0,0,math.Rand(25,25)))
			particle:SetAirResistance(50)
			particle:SetDieTime(dietime)
			particle:SetLifeTime(math.Rand(-0.12,-0.08))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetThinkFunction(SmokeParticleUpdate)
			particle:SetNextThink(CurrentTime + 0.5*dietime)
			particle:SetStartSize(math.Rand(300,300)*self.ScaleSlow)
			particle:SetEndSize(math.Rand(300,300)*self.ScaleSlow)
			particle:SetRoll(math.Rand(150,180))
			particle:SetRollDelta(0.6*math.random(-1,1))
			particle:SetColor(255,255,255)
			
		end
--Mushroom Cloud2
		for i=1,math.ceil(self.Scale*25) do

			local vecang = self.RightAngle
			vecang:RotateAroundAxis(self.Normal,math.Rand(0,360))
			vecang = vecang:Forward() + VectorRand()*0.1
			local velocity = math.Rand(100,700)*vecang
			local particle = emitter:Add("particles/mat1",  self.Position - vecang*32*self.Scale - self.Normal*16)
			local dietime = math.Rand(5.5,5.9)*self.Scale
			particle:SetVelocity(velocity*self.Scale)
			particle:SetGravity(Vector(0,0,math.Rand(50,50)))
			particle:SetAirResistance(50)
			particle:SetDieTime(dietime)
			particle:SetLifeTime(math.Rand(-0.12,-0.08))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetThinkFunction(SmokeParticleUpdate)
			particle:SetNextThink(CurrentTime + 0.5*dietime)
			particle:SetStartSize(math.Rand(300,300)*self.ScaleSlow)
			particle:SetEndSize(math.Rand(300,300)*self.ScaleSlow)
			particle:SetRoll(math.Rand(150,180))
			particle:SetRollDelta(0.6*math.random(-1,1))
			particle:SetColor(255,255,255)
			
		end
--Mushroom Cloud3
		for i=1,math.ceil(self.Scale*25) do

			local vecang = self.RightAngle
			vecang:RotateAroundAxis(self.Normal,math.Rand(0,360))
			vecang = vecang:Forward() + VectorRand()*0.1
			local velocity = math.Rand(100,500)*vecang
			local particle = emitter:Add("particles/mat1",  self.Position - vecang*32*self.Scale - self.Normal*16)
			local dietime = math.Rand(5.5,5.9)*self.Scale
			particle:SetVelocity(velocity*self.Scale)
			particle:SetGravity(Vector(0,0,math.Rand(100,100)))
			particle:SetAirResistance(50)
			particle:SetDieTime(dietime)
			particle:SetLifeTime(math.Rand(-0.12,-0.08))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetThinkFunction(SmokeParticleUpdate)
			particle:SetNextThink(CurrentTime + 0.5*dietime)
			particle:SetStartSize(math.Rand(300,300)*self.ScaleSlow)
			particle:SetEndSize(math.Rand(300,300)*self.ScaleSlow)
			particle:SetRoll(math.Rand(150,180))
			particle:SetRollDelta(0.6*math.random(-1,1))
			particle:SetColor(255,255,255)
			
		end
--Mushroom Cloud Middle
		for i=1,math.ceil(self.Scale*50) do

			local vecang = self.RightAngle
			vecang:RotateAroundAxis(self.Normal,math.Rand(0,360))
			vecang = vecang:Forward() + VectorRand()*0.1
			local velocity = math.Rand(50,700)*vecang
			local particle = emitter:Add("particles/mat1",  self.Position - vecang*32*self.Scale - self.Normal*16)
			local dietime = math.Rand(5.5,5.9)*self.Scale
			particle:SetVelocity(velocity*self.Scale)
			particle:SetGravity(Vector(0,0,math.Rand(0,0)))
			particle:SetAirResistance(50)
			particle:SetDieTime(dietime)
			particle:SetLifeTime(math.Rand(-0.12,-0.08))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetThinkFunction(SmokeParticleUpdate)
			particle:SetNextThink(CurrentTime + 0.5*dietime)
			particle:SetStartSize(math.Rand(300,300)*self.ScaleSlow)
			particle:SetEndSize(math.Rand(300,300)*self.ScaleSlow)
			particle:SetRoll(math.Rand(150,180))
			particle:SetRollDelta(0.6*math.random(-1,1))
			particle:SetColor(255,255,255)
			
		end


emitter:Finish()
	
	if self.Scale > 4 then
		surface.PlaySound("ambient/explosions/explode_8.wav")
		self.Entity:EmitSound("ambient/explosions/explode_4.wav")

	elseif self.Scale > 11 then
		surface.PlaySound("ambient/explosions/explode_8.wav")
		self.Entity:EmitSound("ambient/explosions/explode_1.wav")
	
	elseif self.Scale > 23 then
		surface.PlaySound("ambient/explosions/exp1.wav")
		surface.PlaySound("ambient/explosions/explode_4.wav")
		
	elseif self.Scale > 35 then
		surface.PlaySound("ambient/explosions/exp2.wav")
		surface.PlaySound("ambient/explosions/explode_6.wav")
	
	else
		self.Entity:EmitSound("ambient/explosions/explode_4.wav")
	end
	
end


--THINK
-- Returning false makes the entity die
function EFFECT:Think()
	local TimeLeft = self.KillTime - CurTime()
	local TimeScale = TimeLeft/self.Duration
	local FTime = FrameTime()
	if TimeLeft > 0 then 

		self.FlashAlpha = self.FlashAlpha - 200*FTime
		self.FlashSize = self.FlashSize + 60000*FTime
		
		self.GlowAlpha = 200*TimeScale
		self.GlowSize = TimeLeft*self.Scale

		return true
	else
		return false	
	end
end


-- Draw the effect
function EFFECT:Render()

--base glow
render.SetMaterial(tMats.Glow1)
render.DrawSprite(self.Position2,7000*self.GlowSize,5500*self.GlowSize,Color(255,240,220,self.GlowAlpha))

--blinding flash
	if self.FlashAlpha > 0 then
		render.SetMaterial(tMats.Glow2)
		render.DrawSprite(self.Position2,self.FlashSize,self.FlashSize,Color(255,245,215,self.FlashAlpha))
	end


end


