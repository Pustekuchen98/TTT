function EFFECT:Init( data )	

	self.Pos = data:GetStart()
	self.Ent = data:GetEntity()
	self.Att = data:GetAttachment()
	self.Alph = data:GetMagnitude()

	self.StartPos = self:GetTracerShootPos( self.Pos, self.Ent, self.Att )
	
	local emitter = ParticleEmitter( self.Pos )
local RanCol = math.random( 200, 255)	
		
			local particle = emitter:Add( "effects/smoke.vtf", self.StartPos )

				particle:SetVelocity(Vector(math.random(-2,2),math.random(-2,2), math.random(10, 20)))
				particle:SetLifeTime(0)
				particle:SetDieTime(1)
				particle:SetStartAlpha(self.Alph)
				particle:SetEndAlpha(0)
				particle:SetStartSize( 0.5)
				particle:SetEndSize( math.random(3, 5) )
				particle:SetRoll( math.Rand(0,50 ) )
				particle:SetRollDelta( math.Rand( -0.5, 0.5 ) )
				particle:SetColor( RanCol, RanCol, RanCol )
				particle:VelocityDecay( false )		

	emitter:Finish()	
	end


function EFFECT:Think( )
	return false	
end

function EFFECT:Render()

end



