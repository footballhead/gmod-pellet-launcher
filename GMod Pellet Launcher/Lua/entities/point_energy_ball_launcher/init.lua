-- point_energy_ball_launcher
-- Because Portal uses this and GMod doesn't
-- michaelhitchens.com

ENT.Type = "point"
ENT.Base = "base_point"

-- Not a good solution!
-- Consider n ball spawners in one level
-- they will all use the same values
local temp = {}

function ENT:Initialize()
	-- do something!
	local pos = self:GetPos();

	local spawner = ents.Create( "point_combine_ball_launcher" )
	if ( IsValid( spawner ) ) then
		
		for i, v in pairs(temp) do
			print(i, v)
			spawner:SetKeyValue( i, v )
		end
		spawner:SetKeyValue( "maxballbounces", temp.BallLifetime )
		--print("maxballbounces", temp.BallLifetime)
		
		spawner:Spawn()
		print("Made ball launcher")
	end
	
	
end

function ENT:KeyValue(key,value)
	temp[key] = value
	print("ENT:KeyValue", key, value)
end