

--Initializes the effect. The data is a table of data 
--which was passed from the server.
function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()

	local emitter = ParticleEmitter( self.Position )
		
		local particle = emitter:Add( "particles/smokey", self.Position )
			particle:SetVelocity(Vector(0,0,5))
			particle:SetDieTime( data:GetMagnitude() )
			particle:SetStartAlpha( 127 )
			particle:SetStartSize( data:GetRadius() )
			particle:SetEndSize( data:GetRadius() + 5 )
			particle:SetRoll( math.Rand( 360, 480 ) )
			particle:SetRollDelta( math.Rand( -1, 1 ) )
			particle:SetColor( 255, 255, 255 )
			particle:VelocityDecay( false )
			
	emitter:Finish()
	
end

--THINK
-- Returning false makes the entity die
function EFFECT:Think( )
	return false
end

-- Draw the effect
function EFFECT:Render()
	-- Do nothing - this effect is only used to spawn the particles in Init	
end



