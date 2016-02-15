ENT.Type = "point"
ENT.Base = "base_point"

-- Run whenever GMod decides. Sometime before giving control to the player.
function ENT:Initialize()
	-- Create a point_combine_ball_launcher
	self.spawner = ents.Create( "point_combine_ball_launcher" )
	
	if ( IsValid( self.spawner ) ) then
		-- Copy the values from the loaded point_energy_ball_launcher
		for k, v in pairs( self.temp ) do
			print( "ENT:Initialize", k, v )
			self.spawner:SetKeyValue( k, v )
		end
		
		-- Make adjustments since the properties of the 2 don't correspond 1:1
		
		-- Note: point_combine_ball_launcher doesn't express life time in
		-- seconds; it uses number of bounces. The two may be proportional, idk.
		-- Also, combine balls don't have a concept of "infinite life" so we
		-- just use an arbitrarily high number
		if ( self.temp.BallLifetime == "-1" ) then
			self.temp.BallLifetime = "10000";
		end
		self.spawner:SetKeyValue( "maxballbounces", self.temp.BallLifetime )
		-- MinLifeAfterPortal?
		
		-- Then create it!
		self.spawner:Spawn()
		print( "Made ball launcher at ", self:GetPos() )
	end
	
	
end

-- We need this hook to trap values that the BSP provides in order to properly
-- create the combine_lancher in ENT:Initialize. We store the values in a
-- temporary array which Initialize then uses to properly create the object.
--
-- key (string): The entity property key, corresponding to Hammer values
-- value (string): The value associated with said key
function ENT:KeyValue( key, value )
	-- Create a temp table if it doesn't exist. We need this check because
	-- KeyValue is called a lot and we don't want to make a new table each time.
	if ( self.temp == nil ) then
		self.temp = {}
	end
	
	-- Store the key-value pair for access during initializing
	self.temp[key] = value
	print("ENT:KeyValue", key, value)
end