ENT.Type = "point"
ENT.Base = "base_point"

-- Not a good solution!
-- Consider n ball spawners in one level
-- they will all use the same values
local temp = {}

-- Run whenever GMod decides. Typically before giving control to the player.
function ENT:Initialize()
	-- Create a point_combine_ball_launcher
	self.spawner = ents.Create( "point_combine_ball_launcher" )
	if ( IsValid( self.spawner ) ) then
		-- Copy the values from the loaded point_energy_ball_launcher
		for i, v in pairs(temp) do
			print(i, v)
			self.spawner:SetKeyValue( i, v )
		end
		
		-- Make adjustments since the properties of the 2 don't correspond 1:1
		
		-- Note: point_combine_ball_launcher doesn't express life time in
		-- seconds; it uses number of bounces. The two may be proportional, idk.
		-- Also, combine balls don't have a concept of "infinite life" so we
		-- just use an arbitrarily high number
		if ( temp.BallLifetime == "-1" ) then
			temp.BallLifetime = "10000";
		end
		self.spawner:SetKeyValue( "maxballbounces", temp.BallLifetime )
		-- MinLifeAfterPortal?
		
		-- Then create it!
		self.spawner:Spawn()
		print( "Made ball launcher at ", self:GetPos() )
	end
	
	
end

-- We need this hook to trap values that the BSP provides in order to properly
-- create the combine_lancher in ENT:Initialize. We store the values in a
-- temporary array, but this method doesn't work well if there are more than
-- one point_energy_ball_launcher; this is generally called before Initialize
-- but the order in which the two are called is not guarenteed.
--
-- key (string): The entity property key, corresponding to Hammer values
-- value (string): The value associated with said key
function ENT:KeyValue(key,value)
	temp[key] = value
	print("ENT:KeyValue", key, value)
end