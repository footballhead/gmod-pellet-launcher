-- I doubt these are right...
ENT.Type = "point"
ENT.Base = "base_point"

-- Run whenever GMod decides. Sometime before giving control to the player.
function ENT:Initialize()
	-- Create a dynamic prop instead
	self.entity = ents.Create( "prop_dynamic" )
	
	if ( IsValid( self.entity ) ) then
		-- Copy the values from the Hammer loaded entity
		for k, v in pairs( self.temp ) do
			print( "ENT:Initialize", "Elevator", k, v )
			self.entity:SetKeyValue( k, v )
		end
		
		-- Make adjustments since the properties of the 2 don't correspond 1:1
		-- Give model
		self.entity:SetKeyValue( "model", "models/props/round_elevator_body.mdl" )
		-- Collision: Use VPhysics
		self.entity:SetKeyValue( "solid", "6" )
		self.entity:SetKeyValue( "StartDisabled", "0" )
		self.entity:SetKeyValue( "spawnflags", "0" )
		
		-- try setting parent in a roundabout way
		self.entity:SetMoveType( MOVETYPE_NONE )
		self.entity:SetParent( ents.FindByName( self.temp["parentname"] )[1] )
		
		-- Then create it!
		self.entity:Spawn()
		-- Is Activate necessary? The wiki doesn't say when it should/shouldn't be called
		self.entity:Activate()
		print( "Made elevator at ", self:GetPos() )
	end
	
	-- is this necessary?
	self:Remove()
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
	print("ENT:KeyValue", "Elevator", key, value)
end