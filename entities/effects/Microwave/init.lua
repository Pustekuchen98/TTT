

EFFECT.Mat = Material( "sprites/heatwave" )

/*---------------------------------------------------------
   Init( data table )
---------------------------------------------------------*/
function EFFECT:Init( data )

	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	// Keep the start and end pos - we're going to interpolate between them
	self.StartPosition = data:GetOrigin()
	self.EndPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )

	self.Alpha = data:GetMagnitude()

end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )

	self.Alpha = self.Alpha - FrameTime() * 2048
	
	self.StartPosition = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.Entity:SetRenderBoundsWS( self.StartPosition, self.EndPos )
	
	if (self.Alpha < 10) then return false end
	return true

	end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )

	if ( self.Alpha < 1 ) then return end
	
	
		
	
	self.Length = (self.StartPosition - self.EndPos):Length()
		
	render.SetMaterial( self.Mat )
	local texcoord = math.Rand( 0, 1 )
	
	
	for i=1, 6 do
	
		
		
		render.DrawBeam( self.StartPosition, 										// Start
					 self.EndPos,			// End
					 8,				// Width
					 texcoord,			// Start tex coord
					 texcoord + self.Length / 128,	// End tex coord
					 Color( 255, 255, 255, self.Alpha ) )// Color (optional)
	end

end
