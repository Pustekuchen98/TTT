function EFFECT:Init( data )
	
--	self.Position = data:GetOrigin()	

	self.Position = data:GetStart()
	self.Speed = data:GetOrigin()
	
	
	local emitter = ParticleEmitter( self.Position )		

			local particle = emitter:Add( "Effects/strider_pinch_dudv", self.Position )
--			local particle = emitter:Add( "Effects/strider_bulge_dudv.vtf", self.Position )

				particle:SetVelocity(self.Speed)
--				particle:SetParent(self.WeaponEnt)
				particle:SetLifeTime(0)
				particle:SetDieTime(1)
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize( 0)
				particle:SetEndSize( 300 )
				particle:SetRoll(0 )
				particle:SetRollDelta( 0)
				particle:SetColor( 255, 255, 255 )
				particle:VelocityDecay( false )		

	emitter:Finish()	
	end


function EFFECT:Think( )
	return false	
end

function EFFECT:Render()

end



