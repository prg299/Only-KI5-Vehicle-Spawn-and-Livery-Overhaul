-- Attributed original variant bodies; enabled only with their optional base pack.
return {
{script="Base.93fordF250jplandscaping",provider="93fordF350",definition=[==[	vehicle 93fordF250jplandscaping
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF150CabBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.5667,
		}

		skin
		{
			texture = Vehicles/Vehicles_93fordF350_Shell_JPLandscaping,
		}

		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350_Mask,
		textureLights = Vehicles/Vehicles_93fordF350_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 5.5556,
		mass = 700,
		physicsChassisShape = 2.0000 1.3778 5.5556,
		centerOfMassOffset = 0.0000 0.8444 -0.2778,
		shadowExtents = 2.1542 5.5483,
		shadowOffset = 0.0000 -0.2681,
		engineForce = 4110,
		maxSpeed = 80f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.4444 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.7000 3.5556 0.9111,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7222 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 0.3222 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 0.3222 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 1.6000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 1.6000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.7333 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.7333 0.4222 0.4222,
		}

		template = F3502SeatsFront,
		template = F3502TrunkCompartmentStock,

		part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F2502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f250bed
			{
				file = 93fordF250BedBase,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model f250Int
			{
				file = 93fordF250Interior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model fx50_int
			{
				file = 93fordFx50Interior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
				offset = 0.0000 0.0000 0.8600,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = F1502Windshields,
		template = F3502WindowsFront,
		template = F3502DoorsFront,
		template = F1502Armor,
		template = F2502Bumpers,
		template = F1502SideSteps,
		template = F2502MudflapsStock,
		template = F1502Roofrack,
		template = F3502TiresStock,
		template = F1502SpareTires,
		template = F3502RoofLights,
		template = F2502TruckBedAddonsOFF,
		template = F2502TruckBedAddons,
		template = F2502TruckBedCover,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
        template = F2502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350airport",provider="93fordF350",definition=[==[	vehicle 93fordF350airport
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1333,
		}

		skin
		{
			texture = Vehicles/Vehicles_93fordF350_Shell_Airport,
		}

		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350pd_Mask,
		textureLights = Vehicles/Vehicles_93fordF350utility_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.4444,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.4444,
		centerOfMassOffset = 0.0000 0.8444 0.0000,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6111 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.8667 3.5556 0.9111,
		}

        area Roofrack
		{
			xywh = 0.0000 -1.8889 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F3502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model f350lights
			{
				file = 93fordF350Lights,
			}

            model fx50_int
            {
                file = 93fordFx50Interior,
            }

            model f350_bed
            {
                file = 93fordF350BaseBed,
            }

            model f350longint
            {
                file = 93fordFx50LongbedInterior,
            }

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = F3502Windshields,
		template = F3502Windows,
		template = F3502Doors,
		template = F3502Armor,
		template = F3502Bumpers,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502Roofrack,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = F3502TruckBedAddonsON,
		template = F3502TruckBedAddons,
        template = F3502TruckBedCover,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350as",provider="93fordF350",definition=[==[	vehicle 93fordF350as
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1333,
		}

		skin
		{
			texture = Vehicles/Vehicles_93fordF350_Shell_AS,
		}

		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350pd_Mask,
		textureLights = Vehicles/Vehicles_93fordF350utility_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.4444,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.4444,
		centerOfMassOffset = 0.0000 0.8444 0.0000,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6111 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.8667 3.5556 0.9111,
		}

        area Roofrack
		{
			xywh = 0.0000 -1.8889 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F3502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model f350lights
			{
				file = 93fordF350Lights,
			}

            model fx50_int
            {
                file = 93fordFx50Interior,
            }

            model f350_bed
            {
                file = 93fordF350BaseBed,
            }

            model f350longint
            {
                file = 93fordFx50LongbedInterior,
            }

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = F3502Windshields,
		template = F3502Windows,
		template = F3502Doors,
		template = F3502Armor,
		template = F3502Bumpers,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502Roofrack,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = F3502TruckBedAddonsON,
		template = F3502TruckBedAddons,
        template = F3502TruckBedCover,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350fossoil",provider="93fordF350",definition=[==[	vehicle 93fordF350fossoil
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1333,
		}

		skin
		{
			texture = Vehicles/Vehicles_93fordF350_Shell_fossoil,
		}

		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350pd_Mask,
		textureLights = Vehicles/Vehicles_93fordF350utility_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.4444,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.4444,
		centerOfMassOffset = 0.0000 0.8444 0.0000,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6111 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.8667 3.5556 0.9111,
		}

        area Roofrack
		{
			xywh = 0.0000 -1.8889 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F3502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model f350lights
			{
				file = 93fordF350Lights,
			}

            model fx50_int
            {
                file = 93fordFx50Interior,
            }

            model f350_bed
            {
                file = 93fordF350BaseBed,
            }

            model f350longint
            {
                file = 93fordFx50LongbedInterior,
            }

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = F3502Windshields,
		template = F3502Windows,
		template = F3502Doors,
		template = F3502Armor,
		template = F3502Bumpers,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502Roofrack,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = F3502TruckBedAddonsON,
		template = F3502TruckBedAddons,
        template = F3502TruckBedCover,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350mccoy",provider="93fordF350",definition=[==[	vehicle 93fordF350mccoy
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1556,
		}

		skin
		{
			texture = Vehicles/Vehicles_93fordF350_Shell_mccoy,
		}

		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350utility_Mask,
		textureLights = Vehicles/Vehicles_93fordF350utility_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350utility_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350utility_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

        lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.6222,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.6222,
		centerOfMassOffset = 0.0000 0.8444 -0.0889,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.7889 1.7556 0.7778,
		}

		area StorageLeft
		{
			xywh = 1.3889 -1.8889 0.7778 2.6889,
		}

		area StorageRight
		{
			xywh = -1.3889 -1.8889 0.7778 2.6889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
            container
            {
                capacity = 100,
            }
        }

		template = F3502utilitySideStorage,
		template = F3502utilityTrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

            model f350lights
			{
				file = 93fordF350Lights,
			}

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model fx50_int
			{
				file = 93fordFx50Interior,
			}

			model f350_bedutil
			{
				file = 93fordF350UtilityBed,
			}

			model f350longintutil
			{
				file = 93fordF350UtilityInterior,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
                offset = 0 -0.1 0,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = F3502Windshields,
		template = F3502Windows,
		template = F3502Doors,
		template = F3502utilityArmor,
		template = F3502Bumpers,
		template = F3502utilityBumperRear,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK10calloway",provider="76chevyKseries",definition=[==[	vehicle 76chevyK10calloway
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.1111,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseries_Shell_calloway,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseries_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 4.9111,
		mass = 700,
		physicsChassisShape = 1.9778 1.3333 4.9111,
		centerOfMassOffset = 0.0000 0.8222 -0.0333,
		shadowExtents = 1.9765 5.3483,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 3900,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8222 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.9333 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7000 3.2000 3.4889,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.5222 3.2000 0.8444,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.5000 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.5000 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.6222 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.6222 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.3778 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentK10,
		template = CH76TrunkDoorK10,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76Armor,
		template = CH76BumpersK10,
		template = CH76Roofrack,
		template = CH76Tires,
		template = CH76SpareTireBed,
		template = CH76BedCoverK10M,
		template = CH76BedExtrasToolbox,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyCab10
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedBod10
			{
				file = 76chevyK10Bed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBed20
			{
				file = 76chevyK10InteriorBed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff10
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5375 -0.0556,
			extents = 1.9556 0.7556 4.8889,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3074,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0556 0.7178,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.4667,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK10camille",provider="76chevyKseries",definition=[==[	vehicle 76chevyK10camille
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.1111,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseries_Shell_weldingbycamille,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseries_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 4.9111,
		mass = 700,
		physicsChassisShape = 1.9778 1.3333 4.9111,
		centerOfMassOffset = 0.0000 0.8222 -0.0333,
		shadowExtents = 1.9765 5.3483,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 3900,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8222 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.9333 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7000 3.2000 3.4889,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.5222 3.2000 0.8444,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.5000 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.5000 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.6222 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.6222 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.3778 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentK10,
		template = CH76TrunkDoorK10,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76Armor,
		template = CH76BumpersK10,
		template = CH76Roofrack,
		template = CH76Tires,
		template = CH76SpareTireBed,
		template = CH76BedCoverK10M,
		template = CH76BedExtrasToolbox,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyCab10
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedBod10
			{
				file = 76chevyK10Bed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBed20
			{
				file = 76chevyK10InteriorBed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff10
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5375 -0.0556,
			extents = 1.9556 0.7556 4.8889,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3074,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0556 0.7178,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.4667,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK10fossoil",provider="76chevyKseries",definition=[==[	vehicle 76chevyK10fossoil
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.1111,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseries_Shell_fossoil,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseries_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 4.9111,
		mass = 700,
		physicsChassisShape = 1.9778 1.3333 4.9111,
		centerOfMassOffset = 0.0000 0.8222 -0.0333,
		shadowExtents = 1.9765 5.3483,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 3900,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8222 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.9333 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7000 3.2000 3.4889,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.5222 3.2000 0.8444,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.5000 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.5000 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.6222 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.6222 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.3778 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentK10,
		template = CH76TrunkDoorK10,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76Armor,
		template = CH76BumpersK10,
		template = CH76Roofrack,
		template = CH76Tires,
		template = CH76SpareTireBed,
		template = CH76BedCoverK10M,
		template = CH76BedExtrasToolbox,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,
			
			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab10
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedBod10
			{
				file = 76chevyK10Bed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBed20
			{
				file = 76chevyK10InteriorBed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff10
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5375 -0.0556,
			extents = 1.9556 0.7556 4.8889,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3074,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0556 0.7178,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.4667,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK10kentuckylumber",provider="76chevyKseries",definition=[==[	vehicle 76chevyK10kentuckylumber
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.1111,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseries_Shell_kentuckylumber,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseries_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 4.9111,
		mass = 700,
		physicsChassisShape = 1.9778 1.3333 4.9111,
		centerOfMassOffset = 0.0000 0.8222 -0.0333,
		shadowExtents = 1.9765 5.3483,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 3900,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8222 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.9333 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7000 3.2000 3.4889,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.5222 3.2000 0.8444,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.5000 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.5000 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.6222 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.6222 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.3778 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentK10,
		template = CH76TrunkDoorK10,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76Armor,
		template = CH76BumpersK10,
		template = CH76Roofrack,
		template = CH76Tires,
		template = CH76SpareTireBed,
		template = CH76BedCoverK10M,
		template = CH76BedExtrasToolbox,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,
			
			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab10
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedBod10
			{
				file = 76chevyK10Bed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBed20
			{
				file = 76chevyK10InteriorBed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff10
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5375 -0.0556,
			extents = 1.9556 0.7556 4.8889,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3074,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0556 0.7178,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.4667,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK10yingswood",provider="76chevyKseries",definition=[==[	vehicle 76chevyK10yingswood
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.1111,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseries_Shell_yingswood,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseries_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 4.9111,
		mass = 700,
		physicsChassisShape = 1.9778 1.3333 4.9111,
		centerOfMassOffset = 0.0000 0.8222 -0.0333,
		shadowExtents = 1.9765 5.3483,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 3900,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.2556,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8222 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.9333 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7000 3.2000 3.4889,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.5222 3.2000 0.8444,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.5000 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.5000 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.6222 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.6222 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.3778 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentK10,
		template = CH76TrunkDoorK10,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76Armor,
		template = CH76BumpersK10,
		template = CH76Roofrack,
		template = CH76Tires,
		template = CH76SpareTireBed,
		template = CH76BedCoverK10M,
		template = CH76BedExtrasToolbox,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyCab10
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedBod10
			{
				file = 76chevyK10Bed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBed20
			{
				file = 76chevyK10InteriorBed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff10
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5375 -0.0556,
			extents = 1.9556 0.7556 4.8889,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3074,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0556 0.7178,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.4667,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK20kimble",provider="76chevyKseries",definition=[==[	vehicle 76chevyK20kimble
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.0222,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseries_Shell_kimble,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseries_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 5.2444,
		mass = 730,
		physicsChassisShape = 1.9778 1.3333 5.2444,
		centerOfMassOffset = 0.0000 0.8222 -0.0667,
		shadowExtents = 1.9765 5.7372,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.5667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.5667,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.9667 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0778 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7000 3.2000 3.4889,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.5222 3.2000 0.8444,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.6222 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.6222 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.7778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.7778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.5222 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.5222 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentK20,
		template = CH76TrunkDoorK20,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76Armor,
		template = CH76BumpersK20,
		template = CH76Roofrack,
		template = CH76Tires,
		template = CH76SpareTireBed,
		template = CH76SpareTireRoof,
		template = CH76BedCoverK20M,
		template = CH76BedExtrasToolbox,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,
			
			model 76chevyCab20
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedBod20
			{
				file = 76chevyK20Bed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBed20
			{
				file = 76chevyK20InteriorBed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -0.3128,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.0872,
			extents = 1.9556 0.7556 5.1778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.4407,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0556 0.8555,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.8222,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK20mccoy",provider="76chevyKseries",definition=[==[	vehicle 76chevyK20mccoy
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.0222,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseries_Shell_mccoy,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseries_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 5.2444,
		mass = 730,
		physicsChassisShape = 1.9778 1.3333 5.2444,
		centerOfMassOffset = 0.0000 0.8222 -0.0667,
		shadowExtents = 1.9765 5.7372,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.5667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.5667,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.9667 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0778 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7000 3.2000 3.4889,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.5222 3.2000 0.8444,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.6222 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.6222 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.7778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.7778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.5222 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.5222 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentK20,
		template = CH76TrunkDoorK20,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76Armor,
		template = CH76BumpersK20,
		template = CH76Roofrack,
		template = CH76Tires,
		template = CH76SpareTireBed,
		template = CH76SpareTireRoof,
		template = CH76BedCoverK20F,
		template = CH76BedExtrasToolbox,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab20
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedBod20
			{
				file = 76chevyK20Bed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBed20
			{
				file = 76chevyK20InteriorBed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -0.3128,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.0872,
			extents = 1.9556 0.7556 5.1778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.4407,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0556 0.8555,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.8222,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK20mrc",provider="76chevyKseries",definition=[==[	vehicle 76chevyK20mrc
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.0222,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseries_Shell_marchridge,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseries_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 5.2444,
		mass = 730,
		physicsChassisShape = 1.9778 1.3333 5.2444,
		centerOfMassOffset = 0.0000 0.8222 -0.0667,
		shadowExtents = 1.9765 5.7372,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.5667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.5667,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.9667 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0778 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.7000 3.2000 3.4889,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.5222 3.2000 0.8444,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.6222 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.6222 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.7778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.7778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.5222 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.5222 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentK20,
		template = CH76TrunkDoorK20,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76Armor,
		template = CH76BumpersK20,
		template = CH76Roofrack,
		template = CH76Tires,
		template = CH76SpareTireBed,
		template = CH76SpareTireRoof,
		template = CH76BedCoverK20F,
		template = CH76BedExtrasToolbox,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyCab20
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedBod20
			{
				file = 76chevyK20Bed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBed20
			{
				file = 76chevyK20InteriorBed,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -0.3128,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.0872,
			extents = 1.9556 0.7556 5.1778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.4407,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0556 0.8555,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.8222,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK20utilityDpw",provider="76chevyKseries",definition=[==[	vehicle 76chevyK20utilityDpw
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.0778,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseriesUtility_Shell_whiteBlue,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseriesUtility_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 5.4667,
		mass = 770,
		physicsChassisShape = 1.9778 1.3333 5.4667,
		centerOfMassOffset = 0.0000 0.8222 -0.2333,
		shadowExtents = 1.9765 5.6372,
		shadowOffset = 0.0000 -0.1699,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.3556 1.7556 0.7778,
		}

		area StorageLeft
		{
			xywh = 1.3778 -1.3667 0.7778 2.6889,
		}

		area StorageRight
		{
			xywh = -1.3778 -1.3667 0.7778 2.6889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.5444 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.5444 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.6556 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.6556 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.4556 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.4556 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentUtility,
		template = CH76utilitySideStorage,
		template = CH76utilityTrunkDoorShort,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76ArmorUtilityShort,
		template = CH76BumpersUtilityShort,
		template = CH76Tires,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab20
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyboxBod
			{
				file = 76chevyKseriesUtilBox,
				offset = 0.0000 0.0000 0.7995,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedboxint
			{
				file = 76chevyKseriesUtilInterior,
				offset = 0.0000 0.0000 0.7995,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -0.3128,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.2999,
			extents = 1.9556 0.7556 5.4222,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3618,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0596 0.7667,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.8889,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK20utilityFossoil",provider="76chevyKseries",definition=[==[	vehicle 76chevyK20utilityFossoil
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.0778,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseriesUtility_Shell_fossoil,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseriesUtility_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 5.4667,
		mass = 770,
		physicsChassisShape = 1.9778 1.3333 5.4667,
		centerOfMassOffset = 0.0000 0.8222 -0.2333,
		shadowExtents = 1.9765 5.6372,
		shadowOffset = 0.0000 -0.1699,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.3556 1.7556 0.7778,
		}

		area StorageLeft
		{
			xywh = 1.3778 -1.3667 0.7778 2.6889,
		}

		area StorageRight
		{
			xywh = -1.3778 -1.3667 0.7778 2.6889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.5444 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.5444 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.6556 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.6556 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.4556 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.4556 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentUtility,
		template = CH76utilitySideStorage,
		template = CH76utilityTrunkDoorShort,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76ArmorUtilityShort,
		template = CH76BumpersUtilityShort,
		template = CH76Tires,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab20
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyboxBod
			{
				file = 76chevyKseriesUtilBox,
				offset = 0.0000 0.0000 0.7995,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedboxint
			{
				file = 76chevyKseriesUtilInterior,
				offset = 0.0000 0.0000 0.7995,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -0.3128,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.2999,
			extents = 1.9556 0.7556 5.4222,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3618,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0596 0.7667,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.8889,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK20utilityMcCoy",provider="76chevyKseries",definition=[==[	vehicle 76chevyK20utilityMcCoy
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 -0.0778,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseriesUtility_Shell_mccoy,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseriesUtility_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 5.4667,
		mass = 770,
		physicsChassisShape = 1.9778 1.3333 5.4667,
		centerOfMassOffset = 0.0000 0.8222 -0.2333,
		shadowExtents = 1.9765 5.6372,
		shadowOffset = 0.0000 -0.1699,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 2,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -1.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -1.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat2,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.3556 1.7556 0.7778,
		}

		area StorageLeft
		{
			xywh = 1.3778 -1.3667 0.7778 2.6889,
		}

		area StorageRight
		{
			xywh = -1.3778 -1.3667 0.7778 2.6889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.5444 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.5444 0.7778 1.0000,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.6556 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.6556 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.4556 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.4556 0.4222 0.4222,
		}

		template = CH76Seats,
		template = CH76TrunkCompartmentUtility,
		template = CH76utilitySideStorage,
		template = CH76utilityTrunkDoorShort,
		template = CH76EngineDoor,
		template = CH76Windshields,
		template = CH76Windows,
		template = CH76Doors,
		template = CH76ArmorUtilityShort,
		template = CH76BumpersUtilityShort,
		template = CH76Tires,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab20
			{
				file = 76chevyK10Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyboxBod
			{
				file = 76chevyKseriesUtilBox,
				offset = 0.0000 0.0000 0.7995,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntSC
			{
				file = 76chevyKseriesSCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedboxint
			{
				file = 76chevyKseriesUtilInterior,
				offset = 0.0000 0.0000 0.7995,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -0.3128,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.2999,
			extents = 1.9556 0.7556 5.4222,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3618,
			extents = 1.6000 0.5778 0.7778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0596 0.7667,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.8889,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK30CCutilityDpw",provider="76chevyKseries",definition=[==[	vehicle 76chevyK30CCutilityDpw
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.3333,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseriesUtility_Shell_whiteBlue,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseriesUtility_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 6.3333,
		mass = 812,
		physicsChassisShape = 1.9778 1.3333 6.3333,
		centerOfMassOffset = 0.0000 0.8222 -0.2444,
		shadowExtents = 1.9765 6.7261,
		shadowOffset = 0.0000 -0.1922,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.1889,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.1889,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 -0.4222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 -0.7778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 -0.4222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 -0.7222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.3111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.8000 1.7556 0.7778,
		}

		area StorageLeft
		{
			xywh = 1.3778 -1.8222 0.7778 2.6889,
		}

		area StorageRight
		{
			xywh = -1.3778 -1.8222 0.7778 2.6889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.9222 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.9222 0.7778 1.0000,
		}

		area SeatRearLeft
		{
			xywh = 1.3778 0.0111 0.7778 0.8222,
		}

		area SeatRearRight
		{
			xywh = -1.3778 0.0111 0.7778 0.8222,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 2.0667 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 2.0667 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.8556 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.8556 0.4222 0.4222,
		}

		template = CH76SeatsK30,
		template = CH76TrunkCompartmentUtility,
		template = CH76utilitySideStorage,
		template = CH76utilityTrunkDoor,
		template = CH76EngineDoor,
		template = CH76WindshieldsK30,
		template = CH76WindowsK30,
		template = CH76DoorsK30,
		template = CH76ArmorUtility,
		template = CH76BumpersUtility,
		template = CH76Tires,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab30
			{
				file = 76chevyK30Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyboxBod
			{
				file = 76chevyKseriesUtilBox,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCC
			{
				file = 76chevyKseriesCCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedboxint
			{
				file = 76chevyKseriesUtilInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -1.1123,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.2851,
			extents = 1.9556 0.7556 6.2222,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3333,
			extents = 1.6000 0.5778 1.6000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0617 1.1556,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.7082,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK30CCutilityFossoil",provider="76chevyKseries",definition=[==[	vehicle 76chevyK30CCutilityFossoil
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.3333,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseriesUtility_Shell_fossoil,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseriesUtility_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 6.3333,
		mass = 812,
		physicsChassisShape = 1.9778 1.3333 6.3333,
		centerOfMassOffset = 0.0000 0.8222 -0.2444,
		shadowExtents = 1.9765 6.7261,
		shadowOffset = 0.0000 -0.1922,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.1889,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.1889,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 -0.4222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 -0.7778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 -0.4222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 -0.7222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.3111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.8000 1.7556 0.7778,
		}

		area StorageLeft
		{
			xywh = 1.3778 -1.8222 0.7778 2.6889,
		}

		area StorageRight
		{
			xywh = -1.3778 -1.8222 0.7778 2.6889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.9222 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.9222 0.7778 1.0000,
		}

		area SeatRearLeft
		{
			xywh = 1.3778 0.0111 0.7778 0.8222,
		}

		area SeatRearRight
		{
			xywh = -1.3778 0.0111 0.7778 0.8222,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 2.0667 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 2.0667 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.8556 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.8556 0.4222 0.4222,
		}

		template = CH76SeatsK30,
		template = CH76TrunkCompartmentUtility,
		template = CH76utilitySideStorage,
		template = CH76utilityTrunkDoor,
		template = CH76EngineDoor,
		template = CH76WindshieldsK30,
		template = CH76WindowsK30,
		template = CH76DoorsK30,
		template = CH76ArmorUtility,
		template = CH76BumpersUtility,
		template = CH76Tires,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab30
			{
				file = 76chevyK30Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyboxBod
			{
				file = 76chevyKseriesUtilBox,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCC
			{
				file = 76chevyKseriesCCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedboxint
			{
				file = 76chevyKseriesUtilInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -1.1123,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.2851,
			extents = 1.9556 0.7556 6.2222,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3333,
			extents = 1.6000 0.5778 1.6000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0617 1.1556,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.7082,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.76chevyK30CCutilityMcCoy",provider="76chevyKseries",definition=[==[	vehicle 76chevyK30CCutilityMcCoy
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 76chevyKBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.3333,
		}

		skin
		{
			texture = Vehicles/Vehicles_76chevyKseriesUtility_Shell_mccoy,
		}

		textureRust = Vehicles/Vehicles_76chevyKseries_Rust,
		textureMask = Vehicles/Vehicles_76chevyKseriesUtility_Mask,
		textureLights = Vehicles/Vehicles_76chevyKseries_Lights,
		textureDamage1Shell = Vehicles/Vehicles_76chevyKseries_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_76chevyKseries_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_76chevyKseries_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9778 1.3333 6.3333,
		mass = 812,
		physicsChassisShape = 1.9778 1.3333 6.3333,
		centerOfMassOffset = 0.0000 0.8222 -0.2444,
		shadowExtents = 1.9765 6.7261,
		shadowOffset = 0.0000 -0.1922,
		engineForce = 4000,
		maxSpeed = 75f,
		engineLoudness = 85,
		engineQuality = 74,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 35,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 450,
		rearEndHealth = 250,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 1.7333,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.1889,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.1889,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 0.3889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 0.1111,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4778 0.0444 -0.4222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3000 -0.9556 -0.7778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4778 0.0444 -0.4222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9556 -0.7222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.3111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.8000 1.7556 0.7778,
		}

		area StorageLeft
		{
			xywh = 1.3778 -1.8222 0.7778 2.6889,
		}

		area StorageRight
		{
			xywh = -1.3778 -1.8222 0.7778 2.6889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.9222 0.7778 1.0000,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.9222 0.7778 1.0000,
		}

		area SeatRearLeft
		{
			xywh = 1.3778 0.0111 0.7778 0.8222,
		}

		area SeatRearRight
		{
			xywh = -1.3778 0.0111 0.7778 0.8222,
		}

		area GasTank
		{
			xywh = 1.3889 -0.5556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 2.0667 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 2.0667 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.8556 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.8556 0.4222 0.4222,
		}

		template = CH76SeatsK30,
		template = CH76TrunkCompartmentUtility,
		template = CH76utilitySideStorage,
		template = CH76utilityTrunkDoor,
		template = CH76EngineDoor,
		template = CH76WindshieldsK30,
		template = CH76WindowsK30,
		template = CH76DoorsK30,
		template = CH76ArmorUtility,
		template = CH76BumpersUtility,
		template = CH76Tires,
		template = CH76RoofLightsOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model 76chevyLightbarO
			{
				file = 76chevyKseriesLightbar,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyCab30
			{
				file = 76chevyK30Cab,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyboxBod
			{
				file = 76chevyKseriesUtilBox,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCom
			{
				file = 76chevyKseriesInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyIntCC
			{
				file = 76chevyKseriesCCInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model 76chevyBedboxint
			{
				file = 76chevyKseriesUtilInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 76chevyBat
			{
				file = 76chevyKseriesTISbattery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 76chevyMuff2
			{
				file = 76chevyK10Muff,
				offset = 0.0000 0.0000 -1.1123,
				rotate = 0.0000 0.0000 0.0000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
		useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.5333 -0.2851,
			extents = 1.9556 0.7556 6.2222,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.2000 0.3333,
			extents = 1.6000 0.5778 1.6000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0617 1.1556,
			extents = 1.6000 0.7333 0.4444,
			rotate = -34.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.7082,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.86chevyM1010ambulance",provider="86chevyCUCV",definition=[==[	vehicle 86chevyM1010ambulance
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 86chevyCUCVBase,
			scale = 0.9000,
			offset = 0.0000 0.6556 -0.0111,
		}

        skin
		{
			texture = Vehicles/Vehicles_86chevyM1010_Shell_redBlack,
		}

		textureRust = Vehicles/Vehicles_86chevyM1010_Rust,
		textureMask = Vehicles/Vehicles_86chevyM1010_Mask,
		textureLights = Vehicles/Vehicles_86chevyCUCV_Lights2,
		textureDamage1Shell = Vehicles/Vehicles_86chevyM1010_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_86chevyM1010_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_86chevyCUCV_Blood2,
		textureDamage2Overlay = Vehicles/Vehicles_86chevyCUCV_Blood2,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0;0,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.9556 1.3556 5.2000,
		mass = 900,
		physicsChassisShape = 1.9556 1.3556 5.2000,
		centerOfMassOffset = 0.0000 0.9444 -0.1111,
		shadowExtents = 1.9654 5.7151,
		shadowOffset = 0.0000 -0.1033,
		engineForce = 4250,
		maxSpeed = 78f,
		engineLoudness = 85,
		engineQuality = 77,
		brakingForce = 64,
		stoppingMovementForce = 3.2f,
		rollInfluence = 0.97f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.80,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 15,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.9f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 5,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.5667 1.7444,
			radius = 0.39f,
			width = 0.23f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.5667 1.7444,
			radius = 0.39f,
			width = 0.23f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.5667 -1.3667,
			radius = 0.39f,
			width = 0.23f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.5667 -1.3667,
			radius = 0.39f,
			width = 0.23f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4667 0.0333 0.4111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.0778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

            switchSeat Stretcher
			{
				anim = Climb_WindowB,
				rate = 0.23,
				sound =,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4667 0.0333 0.4111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

            switchSeat Stretcher
			{
				anim = Climb_WindowB,
				rate = 0.23,
				sound =,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,
			door = TrunkDoor,

			position inside
			{
				offset = 0.5222 0.4000 -1.3111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 0.0000 -0.9556 -3.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = TruckBed,
			}

			switchSeat Stretcher
			{
				anim = Climb_WindowB,
				rate = 0.23,
				sound =,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,
			door = TrunkDoor,

			position inside
			{
				offset = 0.5222 0.4000 -2.0333,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 0.0000 -0.9556 -3.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = TruckBed,
			}

			switchSeat Stretcher
			{
				anim = Climb_WindowB,
				rate = 0.23,
				sound =,
			}
		}

		passenger Stretcher
		{
			showPassenger = true,
			hasRoof = true,
			door = TrunkDoor,

			position inside
			{
				offset = -0.6111 0.3667 -1.4667,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 0.0000 -0.9444 -3.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = TruckBed,
			}

            switchSeat FrontLeft
			{
				anim = Climb_WindowB,
				rate = 0.23,
				sound =,
			}

			switchSeat FrontRight
			{
				anim = Climb_WindowB,
				rate = 0.23,
				sound =,
			}

			switchSeat RearLeft
			{
				anim = Climb_WindowB,
				rate = 0.23,
				sound =,
			}

			switchSeat RearRight
			{
				anim = Climb_WindowB,
				rate = 0.23,
				sound =,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.8778 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1000 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.3889 3.2000 3.4889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3667 0.5333 0.7778 1.0889,
		}

		area SeatFrontRight
		{
			xywh = -1.3667 0.5333 0.7778 1.0889,
		}

		area SeatRearRight
		{
			xywh = -1.3667 -0.8111 0.7778 0.8222,
		}

		area SeatRearLeft
		{
			xywh = 1.3667 -0.8111 0.7778 0.8222,
		}

		area GasTank
		{
			xywh = 1.5444 -0.5889 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.7556 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.7556 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.3778 0.4222 0.4222,
		}

		template = centralTireInflation,
		template = CUCV86SeatsFront,
		template = CUCV86Stretcher,
		template = M1010TrunkCompartment,
		template = M1010TrunkDoor,
		template = CUCV86EngineDoor,
		template = CUCV86WindshieldFront,
		template = M1010WindshieldRear,
		template = CUCV86Windows,
		template = CUCV86Doors,
		template = CUCV86ArmorFront,
		template = M1010ArmorRear,
		template = CUCV86BumpersFront,
		template = M1010BumpersRear,
		template = CUCV86SideSteps,
		template = CUCV86SunVisor,
		template = CUCV86Tires,
		template = CUCV86SpareTire,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model cucv86grille
			{
				file = 86chevyCUCVGrille,
			}

			model cucv86Ambass
			{
				file = 86chevyM1010Base,
			}

			model cucv86intCom
			{
				file = 86chevyCUCVInterior,
			}

			model cucv86intAmb
			{
				file = 86chevyM1010Interior,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model cucv86Bat
			{
				file = 86chevyCUCVTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model cucv86Muff
			{
				file = 86chevyM1008Muff,
				offset = 0.0000 0.0000 0.5550,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model cucv86radio10
			{
				file = 86chevyM1010Radio,
				offset = 0.0000 0.0000 0.0000,
			}
		}

		template = Headlight,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.7222,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.6333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.67commandoRanger",provider="67commando",definition=[==[	vehicle 67commandoRanger
	{
		mechanicType = 2,
		offRoadEfficiency = 4,
		engineRepairLevel = 4,
		playerDamageProtection = 1.2,
		engineRPMType = van,

		model
		{
			file = 67commandoBase,
			scale = 1.3300,
			offset = 0.0000 0.3835 0.0000,
		}

		spawnOffsetY = 0,

		skin
		{
			texture = Vehicles/Vehicles_67commando_Shell_Ranger,
		}

		textureRust = Vehicles/Vehicles_67commando_Rust,
		textureMask = Vehicles/Vehicles_67commando_Mask,
		textureLights = Vehicles/Vehicles_67commando_Lights,
		textureDamage1Shell = Vehicles/Vehicles_67commando_Shell_Damaged01,
		textureDamage2Shell = Vehicles/Vehicles_67commando_Shell_Damaged02,
		textureDamage1Overlay = Vehicles/Vehicles_67commando_Overlays_Damaged01,
		textureDamage2Overlay = Vehicles/Vehicles_67commando_Overlays_Damaged02,

		sound
		{
			engine = VehicleEngineSUV,
			engineStart = VehicleEngineSUV,
			engineTurnOff = VehicleEngineSUV,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailSUV,
		}

		extents = 1.6992 1.2180 3.9248,
		mass = 1150,
		physicsChassisShape = 1.6992 1.2180 3.9248,
		centerOfMassOffset = 0.0000 0.3083 0.1579,
		shadowExtents = 1.6992 3.9399,
		shadowOffset = 0.0000 0.1203,
		engineForce = 5500,
		maxSpeed = 58f,
		engineLoudness = 130,
		engineQuality = 85,
		gearRatioCount = 4,
		gearRatioR = 4,
		gearRatio1 = 4,
		gearRatio2 = 3,
		gearRatio3 = 2.5,
		gearRatio4 = 1.0,
		brakingForce = 60,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.50f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 30,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 12,
		suspensionRestLength = 0.5,
		wheelFriction = 1.8f,
		frontEndHealth = 3500,
		rearEndHealth = 3000,
		seats = 6,

		wheel FrontLeft
		{
			front = true,
			offset = 0.6617 -0.4887 1.1429,
			radius = 0.38f,
			width = 0.40f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.6617 -0.4887 1.1429,
			radius = 0.38f,
			width = 0.40f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.6617 -0.5263 -0.8571,
			radius = 0.38f,
			width = 0.40f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.6617 -0.5263 -0.8571,
			radius = 0.38f,
			width = 0.40f,
		}

		template = PassengerSeat6,

		passenger FrontLeft
		{
			position inside
			{
				offset = 0.2556 -0.0977 0.8346,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.0602 -0.8872 -0.5188,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			position inside
			{
				offset = -0.2857 -0.0977 0.8120,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.0602 -0.8872 -0.5564,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger MiddleLeft
		{
			door = DoorFrontLeft,
			showPassenger = true,
			hasRoof = true,
			area = SeatFrontLeft,

			position inside
			{
				offset = 0.4211 -0.0977 0.2105,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.0526 -0.8872 -0.5113,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger MiddleRight
		{
			door = DoorFrontRight,
			showPassenger = true,
			hasRoof = true,
			area = SeatFrontRight,

			position inside
			{
				offset = -0.4286 -0.0977 0.2030,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.0451 -0.8872 -0.5263,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			door = DoorRear,
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4511 -0.1053 -0.2857,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -0.3835 -0.8872 -2.3008,
				rotate = 0.0000 0.0000 0.0000,
				area = TruckBed,
			}
		}

		passenger RearRight
		{
			door = DoorRear,
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.0526 -0.1128 -0.2932,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -0.3459 -0.8872 -2.2782,
				rotate = 0.0000 0.0000 0.0000,
				area = TruckBed,
			}
		}

		area Engine
		{
			xywh = 1.2406 -1.3233 0.7820 0.7970,
		}

		area Toolbox
		{
			xywh = -0.1053 2.5188 0.7519 0.7519,
		}

		area TruckBed
		{
			xywh = -0.4586 -2.2857 0.7519 0.7519,
		}

		area SeatFrontLeft
		{
			xywh = 1.3308 -0.1805 0.7519 0.6015,
		}

		area SeatFrontRight
		{
			xywh = -1.3308 -0.1805 0.7519 0.6015,
		}

		area SeatRearRight
		{
			xywh = -1.1504 -1.3985 0.6015 0.6015,
		}

		area GasTank
		{
			xywh = -1.0602 -1.3459 0.4211 0.4211,
		}

		area TireFrontLeft
		{
			xywh = 1.0602 1.1353 0.4211 0.4211,
		}

		area TireFrontRight
		{
			xywh = -1.0602 1.1353 0.4211 0.4211,
		}

		area TireRearLeft
		{
			xywh = 1.0602 -0.8571 0.4211 0.4211,
		}

		area TireRearRight
		{
			xywh = -1.0602 -0.8571 0.4211 0.4211,
		}

		template = runFlatTires,
		template = centralTireInflation,
		template = TrunkV100,
		template = V100Seats,

		part GloveBox
		{
			model V100Interior
			{
				file = 67commandoInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model V100hatch
			{
				file = 67commandoHatches,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			container
			{
				capacity = 10,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			container
			{
				conditionAffectsCapacity = false,
				capacity = 150,
			}

			install
			{
				skills = Mechanics:4,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:4,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,
		template = Engine,
		template = Muffler,

		part Muffler
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = V100EngineDoor/part/EngineDoor,
		template = V100ToolboxLid/part/V100ToolboxLid,
		template = V100Toolbox/part/V100Toolbox,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = WindowV100,
		template = DoorV100,
		template = runFlatsLargeFront,
		template = runFlatsLargeRear,
		template = TireV100,
		template = V100LightGuards,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:4,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:4,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:4,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:4,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model V100Radio
			{
				file = 67commandoRadio,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
				scale = 1.0,
			}
		}

		template = Headlight,

		physics box
		{
			offset = 0.0000 0.3835 -1.4887,
			extents = 1.6692 0.5038 0.6692,
			rotate = 52.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.2481 0.7669 -1.7970,
			extents = 0.5263 0.4737 0.4737,
			rotate = 52.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.2481 -0.3609 -1.7594,
			extents = 0.5865 0.0752 0.5789,
			rotate = 0.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3383 -1.9624,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3383 2.2782,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.87fordB700Ksprison",provider="87fordB700",definition=[==[	vehicle 87fordB700Ksprison
	{
		mechanicType = 2,
		offRoadEfficiency = 1.1,
		engineRepairLevel = 4,
		playerDamageProtection = 1.2,
		engineRPMType = van,

		model
		{
			file = 87fordB700Base,
			scale = 0.9000,
			offset = 0.0000 0.8889 0.8222,
		}

		spawnOffsetY = 0,

		skin
		{
			texture = Vehicles/Vehicles_87fordB700prisonK_Shell,
		}

		textureRust = Vehicles/Vehicles_87fordB700_Rust,
		textureMask = Vehicles/Vehicles_87fordB700prison_Mask,
		textureLights = Vehicles/Vehicles_87fordB700_Lights2,
		textureDamage1Shell = Vehicles/Vehicles_87fordB700_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_87fordB700_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_87fordB700_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_87fordB700_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0;0,
			rightCol = 0;0;1,
		}

		sound
		{
			engine = VehicleEngineSUV,
			engineStart = VehicleEngineSUV,
			engineTurnOff = VehicleEngineSUV,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailSUV,
		}

		extents = 2.4889 2.1778 9.4444,
		mass = 950,
		physicsChassisShape = 2.4889 2.1778 9.4444,
		centerOfMassOffset = 0.0000 1.2444 0.0000,
		shadowExtents = 2.5112 10.6223,
		shadowOffset = 0.0000 0.0111,
		engineForce = 5050,
		maxSpeed = 55f,
		engineLoudness = 130,
		engineQuality = 85,
		gearRatioCount = 4,
		gearRatioR = 4,
		gearRatio1 = 4,
		gearRatio2 = 3,
		gearRatio3 = 2.5,
		gearRatio4 = 1.0,
		brakingForce = 50,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.90f,
		steeringIncrement = 0.03,
		steeringClamp = 0.25,
		suspensionStiffness = 60,
		suspensionCompression = 4.83,
		suspensionDamping = 3.88,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.15f,
		wheelFriction = 1.9f,
		frontEndHealth = 3500,
		rearEndHealth = 3000,
		seats = 15,
		isSmallVehicle = false,

		wheel FrontLeft
		{
			front = true,
			offset = 1.0222 -0.8333 3.1778,
			radius = 0.47f,
			width = 0.30f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -1.0222 -0.8333 3.1778,
			radius = 0.47f,
			width = 0.30f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8889 -0.8333 -2.6778,
			radius = 0.47f,
			width = 0.60f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8889 -0.8333 -2.6778,
			radius = 0.47f,
			width = 0.60f,
		}

		template = B700Passengers,

		area Engine
		{
			xywh = -1.6444 3.8333 0.8000 1.0000,
		}

		area Roofrack
		{
			xywh = -1.8000 1.0778 1.1111 1.0222,
		}

		area TruckBed
		{
			xywh = 0.6778 -4.8333 2.3333 1.4444,
		}

		area StorageLeft
		{
			xywh = 1.6444 2.6333 0.8000 0.9333,
		}

		area Sign
		{
			xywh = 1.6444 1.7222 0.8000 0.9333,
		}

		area StorageRight
		{
			xywh = -1.6444 1.7000 0.8000 0.9333,
		}

		area SeatFrontLeft
		{
			xywh = 1.6444 2.6778 0.8000 0.8889,
		}

		area SeatFrontRight
		{
			xywh = -1.6444 2.6889 0.8000 1.0444,
		}

		area SeatMiddleRight
		{
			xywh = -0.6674 0.3222 0.8000 0.9333,
		}

		area SeatRearRight
		{
			xywh = -0.6784 -2.7778 0.8000 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 0.7337 -1.2778 0.8000 0.9333,
		}

		area GasTank
		{
			xywh = -1.5889 -3.7111 0.4222 0.9333,
		}

		area TireFrontLeft
		{
			xywh = 1.9778 3.9556 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.9778 3.9556 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 2.1111 -1.9000 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -2.1111 -1.9000 0.4222 0.4222,
		}

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model b700INT
			{
				file = 87fordB700Interior,
			}

			model b700ENG
			{
				file = 87fordB700Engine,
			}

			model b700ROOF2
			{
				file = 87fordB700Roof2,
			}

			container
			{
				capacity = 10,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

        template = centralTireInflation,
		template = B700EngineDoor,
		template = B700StorageLids,
		template = B700TrunkCompartment,
		template = B700SideStorage,
		template = B700SeatDriver,
		template = B700SeatsPassengers,
		template = B700Bumpers,
		
		template = B700Doors,
		template = B700Mudflaps,
		template = B700ArmorPrison,
		template = B700Roofrack,
		template = B700SpareTires,
		template = B700NomadGear,
		template = B700GasTank,
		template = airBrake,
		template = Battery,

		part Battery
		{
			area = StorageLeft,

			model batlin
			{
				file = 87fordB700Battery,
				scale = 1.0,
			}

			table install
			{
				door = StorageLidLeft,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			area = TireRearRight,

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = B700EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = B700Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight/part/HeadlightLeft,
		template = Headlight/part/HeadlightRight,
		template = Headlight/part/HeadlightRearLeft,
		template = Headlight/part/HeadlightRearRight,

        template = B700Windows,
		template = B700Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 1.3215 -0.7222,
			extents = 2.5111 2.3111 8.0000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.6334 3.9778,
			extents = 1.4222 1.2000 1.6222,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.5000 3.9703,
			extents = 2.4000 0.9333 1.4667,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.0333 2.3307,
			extents = 2.5111 0.2667 1.9556,
			rotate = 0.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.7222 -5.7111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.7222 3.9444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.87fordF700Lswat",provider="87fordB700",definition=[==[	vehicle 87fordF700Lswat
	{
		mechanicType = 2,
		offRoadEfficiency = 1.1,
		engineRepairLevel = 4,
		playerDamageProtection = 1.2,
		engineRPMType = van,

		model
		{
			file = 87fordF700swatBase,
			scale = 0.9000,
			offset = 0.0000 1.0222 -1.3444,
		}

		spawnOffsetY = 0,


		skin
		{
			texture = Vehicles/Vehicles_87fordF700swat_Shell_blackSwat,
		}
	
		textureRust = Vehicles/Vehicles_87fordF700swat_Rust,
		textureMask = Vehicles/Vehicles_87fordF700swat_Mask,
		textureLights = Vehicles/Vehicles_87fordF700swat_Lights,
		textureDamage1Shell = Vehicles/Vehicles_87fordF700swat_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_87fordF700swat_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_87fordF700swat_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_87fordF700swat_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineSUV,
			engineStart = VehicleEngineSUV,
			engineTurnOff = VehicleEngineSUV,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailSUV,
		}

		extents = 2.4889 2.0444 5.9778,
		mass = 950,
		physicsChassisShape = 2.4889 2.0444 5.9778,
		centerOfMassOffset = 0.0000 1.1889 -0.2111,
		shadowExtents = 2.6001 6.4890,
		shadowOffset = 0.0000 -0.1334,
		engineForce = 5050,
		maxSpeed = 55f,
		engineLoudness = 130,
		engineQuality = 85,
		gearRatioCount = 4,
		gearRatioR = 4,
		gearRatio1 = 4,
		gearRatio2 = 3,
		gearRatio3 = 2.5,
		gearRatio4 = 1.0,
		brakingForce = 50,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.97f,
		steeringIncrement = 0.03,
		steeringClamp = 0.25,
		suspensionStiffness = 55,
		suspensionCompression = 4.83,
		suspensionDamping = 3.88,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.15f,
		wheelFriction = 1.9f,
		frontEndHealth = 3500,
		rearEndHealth = 3000,
		seats = 8,
		isSmallVehicle = false,

		wheel FrontLeft
		{
			front = true,
			offset = 1.0222 -0.8333 3.1778,
			radius = 0.47f,
			width = 0.30f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -1.0222 -0.8333 3.1778,
			radius = 0.47f,
			width = 0.30f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8889 -0.8333 -0.6444,
			radius = 0.47f,
			width = 0.60f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8889 -0.8333 -0.6444,
			radius = 0.47f,
			width = 0.60f,
		}

		template = F700PassengersSWAT,

		area Engine
		{
			xywh = -1.6444 1.7111 0.8000 1.0000,
		}

		area Roofrack
		{
			xywh = -1.8000 -1.5333 1.1111 1.0222,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6444 1.4222 0.8889,
		}

		area SeatFrontLeft
		{
			xywh = 1.6444 0.6444 0.8000 0.8889,
		}

		area SeatFrontRight
		{
			xywh = -1.6444 0.6444 0.8000 0.8889,
		}

		area SeatMiddleLeft
		{
			xywh = 1.6444 0.0333 0.8000 0.3333,
		}

		area SeatMiddleRight
		{
			xywh = -1.6444 0.0333 0.8000 0.3333,
		}

		area SeatRearRight
		{
			xywh = -1.6444 -0.5778 0.8000 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.6444 -0.5778 0.8000 0.8889,
		}

		area GasTank
		{
			xywh = 1.8333 0.4778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.9778 1.8333 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.9778 1.8333 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 2.1111 -1.9889 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -2.1111 -1.9889 0.4222 0.4222,
		}

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f700swatINT
			{
				file = 87fordF700swatInterior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model b700ENG
			{
				file = 87fordB700Engine,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model f700sidesteps
			{
				file = 87fordF700swatSidesteps,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model f700sfendl
			{
				file = 87fordF700swatFenderL,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			model f700sfendr
			{
				file = 87fordF700swatFenderR,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			container
			{
				capacity = 10,
				test = B700.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = centralTireInflation,
		template = F700EngineDoor,
		template = F700SwatTrunkCompartment,
		template = F700TrunkDoor,
		template = F700SeatsFront,
		template = F700SeatsRear,
		template = F700Bumpers,
		template = F700Doors,
		template = F700Mudflaps,
		template = B700GasTank,
		template = airBrake,
		template = Battery,
		template = Engine,
		template = Muffler,

		part Muffler
		{
			area = TireRearRight,

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = B700Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight/part/HeadlightLeft,
		template = Headlight/part/HeadlightRight,
		template = Headlight/part/HeadlightRearLeft,
		template = Headlight/part/HeadlightRearRight,
		template = F700Windows,
		template = F700Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 1.1889 -1.0564,
			extents = 2.3111 2.0667 4.1333,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7545 1.8222,
			extents = 1.4222 1.2000 1.6222,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0002 0.6222 1.8000,
			extents = 2.4000 0.9333 1.4667,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7778 1.0987,
			extents = 2.3111 1.2444 0.1778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.7010 0.9333,
			extents = 2.3111 0.9556 0.4667,
			rotate = -17.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.7111 -1.9444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.7111 3.9444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.89fordBroncoBulletin",provider="89fordBronco",definition=[==[
	vehicle 89fordBroncoBulletin
	{
		mechanicType = 2,
		offRoadEfficiency = 1.4,
		engineRepairLevel = 4,
		playerDamageProtection = 1.2,

		model
		{
			file = 89fordBroncoBase,
			scale = 0.9000,
			offset = 0.0000 0.5667 0.0000,
		}

		spawnOffsetY = 0,

		skin
		{
			texture = Vehicles/Vehicles_89fordBronco_Shell_Bulletin,
		}

		textureRust = Vehicles/Vehicles_89fordBronco_Rust,
		textureMask = Vehicles/Vehicles_89fordBronco_Mask,
		textureLights = Vehicles/Vehicles_89fordBronco_Lights,
		textureDamage1Shell = Vehicles/Vehicles_89fordBronco_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_89fordBronco_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_89fordBronco_Blood,
		textureDamage2Overlay = Vehicles/Vehicles_89fordBronco_Blood,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineCarNormal,
			engineStart = VehicleEngineCarNormal,
			engineTurnOff = VehicleEngineCarNormal,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailCarNormal,
		}

		extents = 1.9778 1.3556 4.6667,
		mass = 900,
		physicsChassisShape = 1.9778 1.3556 4.6667,
		centerOfMassOffset = 0.0000 0.8333 0.0444,
		shadowExtents = 2.0799 4.9571,
		shadowOffset = 0.0000 0.0434,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 75,
		engineQuality = 88,
		brakingForce = 85,
		stoppingMovementForce = 3.2f,
		rollInfluence = 0.95f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.40,
		wheelFriction = 1.9f,
		frontEndHealth = 600,
		rearEndHealth = 550,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8222 -0.6000 1.5444,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8222 -0.6000 1.5444,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8222 -0.6222 -1.0667,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8222 -0.6222 -1.0667,
			radius = 0.40f,
			width = 0.27f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 0.0444 0.1000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9667 -0.1889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 0.0444 0.1000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9667 -0.1778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,
			door = DoorFrontLeft,
			area = SeatFrontLeft,

			position inside
			{
				offset = 0.3000 0.0444 -0.8222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3111 -0.9444 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,
			door = DoorFrontRight,
			area = SeatFrontRight,

			position inside
			{
				offset = -0.3000 0.0444 -0.8222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9444 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.7667 1.5556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.6778 1.6889 0.7778,
		}

		area TruckBed2
		{
			xywh = 1.4000 -2.6778 1.1111 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.4222 2.9111 2.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.2889 0.7778 1.0444,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.2889 0.7778 1.0444,
		}

		area GasTank
		{
			xywh = 1.4111 -1.6889 0.8444 0.8444,
		}

		area TireFrontLeft
		{
			xywh = 1.4444 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4444 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4444 -1.0444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4444 -1.0444 0.4222 0.4222,
		}

		template = BR89Armor,
		template = BR89Tires,

            part Tire*
		    {
                model BR89Tire0
			    {
				file = 80sOffroadWheelB,
			    }
            }

		template = BR89Seats,
		template = BR89Doors,
		template = BR89FrontBumper,
		template = BR89RearBumper,
		template = BR89EngineDoor,
		template = BR89TrunkDoors,
		template = BR89Windshield,
		template = BR89Windows,
		template = BR89BedCover,
		template = BR89RollbarPD,
		template = BR89Barrier,
		template = BR89RoofrackPD,
		template = BR89SpareTires,
		template = BR89TrunkCompartment,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model BR89int
			{
				file = 89fordBroncoInterior,
			}

			model BR89lights
			{
				file = 89fordBroncoPDLightbar,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model BR89tisbat
			{
				file = 89fordBroncoTISBattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,

		attachment trailer
		{
			offset = 0.0000 -0.4667 -2.3000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4444 2.4889,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.89fordBroncoMeade",provider="89fordBronco",definition=[==[
	vehicle 89fordBroncoMeade
	{
		mechanicType = 2,
		offRoadEfficiency = 1.4,
		engineRepairLevel = 4,
		playerDamageProtection = 1.2,

		model
		{
			file = 89fordBroncoBase,
			scale = 0.9000,
			offset = 0.0000 0.5667 0.0000,
		}

		spawnOffsetY = 0,

		skin
		{
			texture = Vehicles/Vehicles_89fordBronco_Shell_Meade,
		}

		
		textureRust = Vehicles/Vehicles_89fordBronco_Rust,
		textureMask = Vehicles/Vehicles_89fordBronco_Mask,
		textureLights = Vehicles/Vehicles_89fordBronco_Lights,
		textureDamage1Shell = Vehicles/Vehicles_89fordBronco_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_89fordBronco_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_89fordBronco_Blood,
		textureDamage2Overlay = Vehicles/Vehicles_89fordBronco_Blood,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineCarNormal,
			engineStart = VehicleEngineCarNormal,
			engineTurnOff = VehicleEngineCarNormal,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailCarNormal,
		}

		extents = 1.9778 1.3556 4.6667,
		mass = 900,
		physicsChassisShape = 1.9778 1.3556 4.6667,
		centerOfMassOffset = 0.0000 0.8333 0.0444,
		shadowExtents = 2.0799 4.9571,
		shadowOffset = 0.0000 0.0434,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 75,
		engineQuality = 88,
		brakingForce = 85,
		stoppingMovementForce = 3.2f,
		rollInfluence = 0.95f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.40,
		wheelFriction = 1.9f,
		frontEndHealth = 600,
		rearEndHealth = 550,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8222 -0.6000 1.5444,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8222 -0.6000 1.5444,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8222 -0.6222 -1.0667,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8222 -0.6222 -1.0667,
			radius = 0.40f,
			width = 0.27f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 0.0444 0.1000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9667 -0.1889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 0.0444 0.1000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9667 -0.1778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,
			door = DoorFrontLeft,
			area = SeatFrontLeft,

			position inside
			{
				offset = 0.3000 0.0444 -0.8222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3111 -0.9444 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,
			door = DoorFrontRight,
			area = SeatFrontRight,

			position inside
			{
				offset = -0.3000 0.0444 -0.8222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9444 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.7667 1.5556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.6778 1.6889 0.7778,
		}

		area TruckBed2
		{
			xywh = 1.4000 -2.6778 1.1111 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.4222 2.9111 2.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.2889 0.7778 1.0444,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.2889 0.7778 1.0444,
		}

		area GasTank
		{
			xywh = 1.4111 -1.6889 0.8444 0.8444,
		}

		area TireFrontLeft
		{
			xywh = 1.4444 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4444 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4444 -1.0444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4444 -1.0444 0.4222 0.4222,
		}

		template = BR89Armor,
		template = BR89Tires,

            part Tire*
		    {
                model BR89Tire0
			    {
				file = 80sOffroadWheelB,
			    }
            }

		template = BR89Seats,
		template = BR89Doors,
		template = BR89FrontBumper,
		template = BR89RearBumper,
		template = BR89EngineDoor,
		template = BR89TrunkDoors,
		template = BR89Windshield,
		template = BR89Windows,
		template = BR89BedCover,
		template = BR89RollbarPD,
		template = BR89Barrier,
		template = BR89RoofrackPD,
		template = BR89SpareTires,
		template = BR89TrunkCompartment,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model BR89int
			{
				file = 89fordBroncoInterior,
			}

			model BR89lights
			{
				file = 89fordBroncoPDLightbar,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model BR89tisbat
			{
				file = 89fordBroncoTISBattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,

		attachment trailer
		{
			offset = 0.0000 -0.4667 -2.3000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4444 2.4889,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.89fordBroncoMuldraugh",provider="89fordBronco",definition=[==[
	vehicle 89fordBroncoMuldraugh
	{
		mechanicType = 2,
		offRoadEfficiency = 1.4,
		engineRepairLevel = 4,
		playerDamageProtection = 1.2,

		model
		{
			file = 89fordBroncoBase,
			scale = 0.9000,
			offset = 0.0000 0.5667 0.0000,
		}

		spawnOffsetY = 0,

		skin
		{
			texture = Vehicles/Vehicles_89fordBronco_Shell_Muldraugh,
		}


		textureRust = Vehicles/Vehicles_89fordBronco_Rust,
		textureMask = Vehicles/Vehicles_89fordBronco_Mask,
		textureLights = Vehicles/Vehicles_89fordBronco_Lights,
		textureDamage1Shell = Vehicles/Vehicles_89fordBronco_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_89fordBronco_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_89fordBronco_Blood,
		textureDamage2Overlay = Vehicles/Vehicles_89fordBronco_Blood,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineCarNormal,
			engineStart = VehicleEngineCarNormal,
			engineTurnOff = VehicleEngineCarNormal,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailCarNormal,
		}

		extents = 1.9778 1.3556 4.6667,
		mass = 900,
		physicsChassisShape = 1.9778 1.3556 4.6667,
		centerOfMassOffset = 0.0000 0.8333 0.0444,
		shadowExtents = 2.0799 4.9571,
		shadowOffset = 0.0000 0.0434,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 75,
		engineQuality = 88,
		brakingForce = 85,
		stoppingMovementForce = 3.2f,
		rollInfluence = 0.95f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.40,
		wheelFriction = 1.9f,
		frontEndHealth = 600,
		rearEndHealth = 550,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8222 -0.6000 1.5444,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8222 -0.6000 1.5444,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8222 -0.6222 -1.0667,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8222 -0.6222 -1.0667,
			radius = 0.40f,
			width = 0.27f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 0.0444 0.1000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9667 -0.1889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 0.0444 0.1000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9667 -0.1778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,
			door = DoorFrontLeft,
			area = SeatFrontLeft,

			position inside
			{
				offset = 0.3000 0.0444 -0.8222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3111 -0.9444 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,
			door = DoorFrontRight,
			area = SeatFrontRight,

			position inside
			{
				offset = -0.3000 0.0444 -0.8222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9444 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.7667 1.5556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.6778 1.6889 0.7778,
		}

		area TruckBed2
		{
			xywh = 1.4000 -2.6778 1.1111 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.4222 2.9111 2.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.2889 0.7778 1.0444,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.2889 0.7778 1.0444,
		}

		area GasTank
		{
			xywh = 1.4111 -1.6889 0.8444 0.8444,
		}

		area TireFrontLeft
		{
			xywh = 1.4444 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4444 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4444 -1.0444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4444 -1.0444 0.4222 0.4222,
		}

		template = BR89Armor,
		template = BR89Tires,

            part Tire*
		    {
                model BR89Tire0
			    {
				file = 80sOffroadWheelB,
			    }
            }

		template = BR89Seats,
		template = BR89Doors,
		template = BR89FrontBumper,
		template = BR89RearBumper,
		template = BR89EngineDoor,
		template = BR89TrunkDoors,
		template = BR89Windshield,
		template = BR89Windows,
		template = BR89BedCover,
		template = BR89RollbarPD,
		template = BR89Barrier,
		template = BR89RoofrackPD,
		template = BR89SpareTires,
		template = BR89TrunkCompartment,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model BR89int
			{
				file = 89fordBroncoInterior,
			}

			model BR89lights
			{
				file = 89fordBroncoPDLightbar,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model BR89tisbat
			{
				file = 89fordBroncoTISBattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,

		attachment trailer
		{
			offset = 0.0000 -0.4667 -2.3000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4444 2.4889,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.89fordBroncoWestPoint",provider="89fordBronco",definition=[==[
	vehicle 89fordBroncoWestPoint
	{
		mechanicType = 2,
		offRoadEfficiency = 1.4,
		engineRepairLevel = 4,
		playerDamageProtection = 1.2,

		model
		{
			file = 89fordBroncoBase,
			scale = 0.9000,
			offset = 0.0000 0.5667 0.0000,
		}

		spawnOffsetY = 0,

		skin
		{
			texture = Vehicles/Vehicles_89fordBronco_Shell_WestPoint,
		}

		textureRust = Vehicles/Vehicles_89fordBronco_Rust,
		textureMask = Vehicles/Vehicles_89fordBronco_Mask,
		textureLights = Vehicles/Vehicles_89fordBronco_Lights,
		textureDamage1Shell = Vehicles/Vehicles_89fordBronco_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_89fordBronco_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_89fordBronco_Blood,
		textureDamage2Overlay = Vehicles/Vehicles_89fordBronco_Blood,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineCarNormal,
			engineStart = VehicleEngineCarNormal,
			engineTurnOff = VehicleEngineCarNormal,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailCarNormal,
		}

		extents = 1.9778 1.3556 4.6667,
		mass = 900,
		physicsChassisShape = 1.9778 1.3556 4.6667,
		centerOfMassOffset = 0.0000 0.8333 0.0444,
		shadowExtents = 2.0799 4.9571,
		shadowOffset = 0.0000 0.0434,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 75,
		engineQuality = 88,
		brakingForce = 85,
		stoppingMovementForce = 3.2f,
		rollInfluence = 0.95f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.40,
		wheelFriction = 1.9f,
		frontEndHealth = 600,
		rearEndHealth = 550,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8222 -0.6000 1.5444,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8222 -0.6000 1.5444,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8222 -0.6222 -1.0667,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8222 -0.6222 -1.0667,
			radius = 0.40f,
			width = 0.27f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 0.0444 0.1000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9667 -0.1889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 0.0444 0.1000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3111 -0.9667 -0.1778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,
			door = DoorFrontLeft,
			area = SeatFrontLeft,

			position inside
			{
				offset = 0.3000 0.0444 -0.8222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3111 -0.9444 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,
			door = DoorFrontRight,
			area = SeatFrontRight,

			position inside
			{
				offset = -0.3000 0.0444 -0.8222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9444 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 2.7667 1.5556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.6778 1.6889 0.7778,
		}

		area TruckBed2
		{
			xywh = 1.4000 -2.6778 1.1111 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -1.4222 2.9111 2.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3778 0.2889 0.7778 1.0444,
		}

		area SeatFrontRight
		{
			xywh = -1.3778 0.2889 0.7778 1.0444,
		}

		area GasTank
		{
			xywh = 1.4111 -1.6889 0.8444 0.8444,
		}

		area TireFrontLeft
		{
			xywh = 1.4444 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4444 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4444 -1.0444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4444 -1.0444 0.4222 0.4222,
		}

		template = BR89Armor,
		template = BR89Tires,

            part Tire*
		    {
                model BR89Tire0
			    {
				file = 80sOffroadWheelB,
			    }
            }

		template = BR89Seats,
		template = BR89Doors,
		template = BR89FrontBumper,
		template = BR89RearBumper,
		template = BR89EngineDoor,
		template = BR89TrunkDoors,
		template = BR89Windshield,
		template = BR89Windows,
		template = BR89BedCover,
		template = BR89RollbarPD,
		template = BR89Barrier,
		template = BR89RoofrackPD,
		template = BR89SpareTires,
		template = BR89TrunkCompartment,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model BR89int
			{
				file = 89fordBroncoInterior,
			}

			model BR89lights
			{
				file = 89fordBroncoPDLightbar,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model BR89tisbat
			{
				file = 89fordBroncoTISBattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,

		attachment trailer
		{
			offset = 0.0000 -0.4667 -2.3000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4444 2.4889,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.91fordLTDpdBulletin",provider="91fordLTD",definition=[==[	vehicle 91fordLTDpdBulletin
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 91fordLTDBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

	skin
		{
			texture = Vehicles/Vehicles_91fordLTDpd_Shell_Bulletin,
		}

		textureRust = Vehicles/Vehicles_91fordLTD_Rust,
		textureMask = Vehicles/Vehicles_91fordLTD_Mask,
		textureLights = Vehicles/Vehicles_91fordLTD_Lights,
		textureDamage1Shell = Vehicles/Vehicles_91fordLTD_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_91fordLTD_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureShadow = Vehicles/Vehicles_91fordLTD_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8444 1.2444 5.2889,
		mass = 750,
		physicsChassisShape = 1.8444 1.2444 5.2889,
		centerOfMassOffset = 0.0000 0.6222 -0.0111,
		shadowExtents = 1.9096 5.5260,
		shadowOffset = 0.0000 -0.0313,
		engineForce = 4265,
		maxSpeed = 85f,
		engineLoudness = 84,
		engineQuality = 80,
		brakingForce = 80,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.99f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 32,
		suspensionCompression = 4.83,
		suspensionDamping = 3.88,
		maxSuspensionTravelCm = 18,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 195,
		rearEndHealth = 150,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0222 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3111 0.3333 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3111 0.3333 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3111 -0.6222 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.3111 -0.6222 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -1.7667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3444 0.4222 0.4222,
		}

		template = LTD91TrunkCompartment,
		
		template = LTD91Seats,
		template = LTD91BumpersPD,
		template = LTD91Doors,
		template = LTD91EngineDoor,
		template = LTD91TrunkDoor,
		template = LTD91Armor,
		template = LTD91SpareTires,
		template = LTD91Barrier,
		template = LTD91Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic91
			{
				file = 91fordLTDInterior,
				scale = 1.0,
			}

			model ksplightbar
			{
				file = 91fordLTDkspLightbar,
			}

			model bodsedan91
			{
				file = 91fordLTDSedanBase,
				scale = 1.0,
			}

			model intvic91sedan
			{
				file = 91fordLTDInteriorSedan,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlinVIC91
			{
				file = 91fordLTDTISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic91
			{
				file = 91fordLTDMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = LTD91Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic91
			{
				file = 91fordLTDRadio,
				scale = 1.0,
			}
		}

		template = Headlight,
        template = LTD91Windows,
		template = LTD91Windshields,
        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3555 0.0000,
			extents = 1.8000 0.6667 5.3111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9407 -0.4222,
			extents = 1.5778 0.5333 1.4444,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.8000 -1.3370,
			extents = 1.5778 0.8222 0.3556,
			rotate = 49.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7222 0.5370,
			extents = 1.5778 0.9556 0.5111,
			rotate = -54.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.7000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.7444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.91fordLTDpdLCPD",provider="91fordLTD",definition=[==[	vehicle 91fordLTDpdLCPD
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 91fordLTDBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_91fordLTDpd_Shell_LCPD,
		}

		textureRust = Vehicles/Vehicles_91fordLTD_Rust,
		textureMask = Vehicles/Vehicles_91fordLTD_Mask,
		textureLights = Vehicles/Vehicles_91fordLTD_Lights,
		textureDamage1Shell = Vehicles/Vehicles_91fordLTD_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_91fordLTD_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureShadow = Vehicles/Vehicles_91fordLTD_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8444 1.2444 5.2889,
		mass = 750,
		physicsChassisShape = 1.8444 1.2444 5.2889,
		centerOfMassOffset = 0.0000 0.6222 -0.0111,
		shadowExtents = 1.9096 5.5260,
		shadowOffset = 0.0000 -0.0313,
		engineForce = 4265,
		maxSpeed = 85f,
		engineLoudness = 84,
		engineQuality = 80,
		brakingForce = 80,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.99f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 32,
		suspensionCompression = 4.83,
		suspensionDamping = 3.88,
		maxSuspensionTravelCm = 18,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 195,
		rearEndHealth = 150,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0222 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3111 0.3333 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3111 0.3333 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3111 -0.6222 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.3111 -0.6222 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -1.7667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3444 0.4222 0.4222,
		}

		template = LTD91TrunkCompartment,
		
		template = LTD91Seats,
		template = LTD91BumpersPD,
		template = LTD91Doors,
		template = LTD91EngineDoor,
		template = LTD91TrunkDoor,
		template = LTD91Armor,
		template = LTD91SpareTires,
		template = LTD91Barrier,
		template = LTD91Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic91
			{
				file = 91fordLTDInterior,
				scale = 1.0,
			}

			model ksplightbar
			{
				file = 91fordLTDkspLightbar,
			}

			model bodsedan91
			{
				file = 91fordLTDSedanBase,
				scale = 1.0,
			}

			model intvic91sedan
			{
				file = 91fordLTDInteriorSedan,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlinVIC91
			{
				file = 91fordLTDTISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic91
			{
				file = 91fordLTDMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = LTD91Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic91
			{
				file = 91fordLTDRadio,
				scale = 1.0,
			}
		}

		template = Headlight,
        template = LTD91Windows,
		template = LTD91Windshields,
        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3555 0.0000,
			extents = 1.8000 0.6667 5.3111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9407 -0.4222,
			extents = 1.5778 0.5333 1.4444,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.8000 -1.3370,
			extents = 1.5778 0.8222 0.3556,
			rotate = 49.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7222 0.5370,
			extents = 1.5778 0.9556 0.5111,
			rotate = -54.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.7000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.7444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.91fordLTDpdLouisville",provider="91fordLTD",definition=[==[	vehicle 91fordLTDpdLouisville
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 91fordLTDBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

           skin
		{
			texture = Vehicles/Vehicles_91fordLTDpd_Shell_Louisville,
		}


		textureRust = Vehicles/Vehicles_91fordLTD_Rust,
		textureMask = Vehicles/Vehicles_91fordLTD_Mask,
		textureLights = Vehicles/Vehicles_91fordLTD_Lights,
		textureDamage1Shell = Vehicles/Vehicles_91fordLTD_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_91fordLTD_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureShadow = Vehicles/Vehicles_91fordLTD_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8444 1.2444 5.2889,
		mass = 750,
		physicsChassisShape = 1.8444 1.2444 5.2889,
		centerOfMassOffset = 0.0000 0.6222 -0.0111,
		shadowExtents = 1.9096 5.5260,
		shadowOffset = 0.0000 -0.0313,
		engineForce = 4265,
		maxSpeed = 85f,
		engineLoudness = 84,
		engineQuality = 80,
		brakingForce = 80,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.99f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 32,
		suspensionCompression = 4.83,
		suspensionDamping = 3.88,
		maxSuspensionTravelCm = 18,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 195,
		rearEndHealth = 150,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0222 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3111 0.3333 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3111 0.3333 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3111 -0.6222 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.3111 -0.6222 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -1.7667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3444 0.4222 0.4222,
		}

		template = LTD91TrunkCompartment,
		
		template = LTD91Seats,
		template = LTD91BumpersPD,
		template = LTD91Doors,
		template = LTD91EngineDoor,
		template = LTD91TrunkDoor,
		template = LTD91Armor,
		template = LTD91SpareTires,
		template = LTD91Barrier,
		template = LTD91Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic91
			{
				file = 91fordLTDInterior,
				scale = 1.0,
			}

			model ksplightbar
			{
				file = 91fordLTDkspLightbar,
			}

			model bodsedan91
			{
				file = 91fordLTDSedanBase,
				scale = 1.0,
			}

			model intvic91sedan
			{
				file = 91fordLTDInteriorSedan,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlinVIC91
			{
				file = 91fordLTDTISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic91
			{
				file = 91fordLTDMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = LTD91Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic91
			{
				file = 91fordLTDRadio,
				scale = 1.0,
			}
		}

		template = Headlight,
        template = LTD91Windows,
		template = LTD91Windshields,
        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3555 0.0000,
			extents = 1.8000 0.6667 5.3111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9407 -0.4222,
			extents = 1.5778 0.5333 1.4444,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.8000 -1.3370,
			extents = 1.5778 0.8222 0.3556,
			rotate = 49.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7222 0.5370,
			extents = 1.5778 0.9556 0.5111,
			rotate = -54.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.7000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.7444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.91fordLTDpdMeade",provider="91fordLTD",definition=[==[	vehicle 91fordLTDpdMeade
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 91fordLTDBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_91fordLTDpd_Shell_Meade,
		}

		textureRust = Vehicles/Vehicles_91fordLTD_Rust,
		textureMask = Vehicles/Vehicles_91fordLTD_Mask,
		textureLights = Vehicles/Vehicles_91fordLTD_Lights,
		textureDamage1Shell = Vehicles/Vehicles_91fordLTD_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_91fordLTD_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureShadow = Vehicles/Vehicles_91fordLTD_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8444 1.2444 5.2889,
		mass = 750,
		physicsChassisShape = 1.8444 1.2444 5.2889,
		centerOfMassOffset = 0.0000 0.6222 -0.0111,
		shadowExtents = 1.9096 5.5260,
		shadowOffset = 0.0000 -0.0313,
		engineForce = 4265,
		maxSpeed = 85f,
		engineLoudness = 84,
		engineQuality = 80,
		brakingForce = 80,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.99f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 32,
		suspensionCompression = 4.83,
		suspensionDamping = 3.88,
		maxSuspensionTravelCm = 18,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 195,
		rearEndHealth = 150,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0222 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3111 0.3333 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3111 0.3333 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3111 -0.6222 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.3111 -0.6222 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -1.7667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3444 0.4222 0.4222,
		}

		template = LTD91TrunkCompartment,
		
		template = LTD91Seats,
		template = LTD91BumpersPD,
		template = LTD91Doors,
		template = LTD91EngineDoor,
		template = LTD91TrunkDoor,
		template = LTD91Armor,
		template = LTD91SpareTires,
		template = LTD91Barrier,
		template = LTD91Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic91
			{
				file = 91fordLTDInterior,
				scale = 1.0,
			}

			model ksplightbar
			{
				file = 91fordLTDkspLightbar,
			}

			model bodsedan91
			{
				file = 91fordLTDSedanBase,
				scale = 1.0,
			}

			model intvic91sedan
			{
				file = 91fordLTDInteriorSedan,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlinVIC91
			{
				file = 91fordLTDTISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic91
			{
				file = 91fordLTDMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = LTD91Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic91
			{
				file = 91fordLTDRadio,
				scale = 1.0,
			}
		}

		template = Headlight,
        template = LTD91Windows,
		template = LTD91Windshields,
        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3555 0.0000,
			extents = 1.8000 0.6667 5.3111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9407 -0.4222,
			extents = 1.5778 0.5333 1.4444,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.8000 -1.3370,
			extents = 1.5778 0.8222 0.3556,
			rotate = 49.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7222 0.5370,
			extents = 1.5778 0.9556 0.5111,
			rotate = -54.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.7000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.7444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.91fordLTDpdMuldraugh",provider="91fordLTD",definition=[==[	vehicle 91fordLTDpdMuldraugh
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 91fordLTDBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

	
		skin
		{
			texture = Vehicles/Vehicles_91fordLTDpd_Shell_Muldraugh,
		}

		textureRust = Vehicles/Vehicles_91fordLTD_Rust,
		textureMask = Vehicles/Vehicles_91fordLTD_Mask,
		textureLights = Vehicles/Vehicles_91fordLTD_Lights,
		textureDamage1Shell = Vehicles/Vehicles_91fordLTD_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_91fordLTD_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureShadow = Vehicles/Vehicles_91fordLTD_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8444 1.2444 5.2889,
		mass = 750,
		physicsChassisShape = 1.8444 1.2444 5.2889,
		centerOfMassOffset = 0.0000 0.6222 -0.0111,
		shadowExtents = 1.9096 5.5260,
		shadowOffset = 0.0000 -0.0313,
		engineForce = 4265,
		maxSpeed = 85f,
		engineLoudness = 84,
		engineQuality = 80,
		brakingForce = 80,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.99f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 32,
		suspensionCompression = 4.83,
		suspensionDamping = 3.88,
		maxSuspensionTravelCm = 18,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 195,
		rearEndHealth = 150,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0222 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3111 0.3333 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3111 0.3333 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3111 -0.6222 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.3111 -0.6222 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -1.7667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3444 0.4222 0.4222,
		}

		template = LTD91TrunkCompartment,
		
		template = LTD91Seats,
		template = LTD91BumpersPD,
		template = LTD91Doors,
		template = LTD91EngineDoor,
		template = LTD91TrunkDoor,
		template = LTD91Armor,
		template = LTD91SpareTires,
		template = LTD91Barrier,
		template = LTD91Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic91
			{
				file = 91fordLTDInterior,
				scale = 1.0,
			}

			model ksplightbar
			{
				file = 91fordLTDkspLightbar,
			}

			model bodsedan91
			{
				file = 91fordLTDSedanBase,
				scale = 1.0,
			}

			model intvic91sedan
			{
				file = 91fordLTDInteriorSedan,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlinVIC91
			{
				file = 91fordLTDTISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic91
			{
				file = 91fordLTDMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = LTD91Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic91
			{
				file = 91fordLTDRadio,
				scale = 1.0,
			}
		}

		template = Headlight,
        template = LTD91Windows,
		template = LTD91Windshields,
        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3555 0.0000,
			extents = 1.8000 0.6667 5.3111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9407 -0.4222,
			extents = 1.5778 0.5333 1.4444,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.8000 -1.3370,
			extents = 1.5778 0.8222 0.3556,
			rotate = 49.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7222 0.5370,
			extents = 1.5778 0.9556 0.5111,
			rotate = -54.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.7000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.7444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.91fordLTDpdWestPoint",provider="91fordLTD",definition=[==[	vehicle 91fordLTDpdWestPoint
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 91fordLTDBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_91fordLTDpd_Shell_WestPoint,
		}


		textureRust = Vehicles/Vehicles_91fordLTD_Rust,
		textureMask = Vehicles/Vehicles_91fordLTD_Mask,
		textureLights = Vehicles/Vehicles_91fordLTD_Lights,
		textureDamage1Shell = Vehicles/Vehicles_91fordLTD_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_91fordLTD_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_91fordLTD_Blood1,
		textureShadow = Vehicles/Vehicles_91fordLTD_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8444 1.2444 5.2889,
		mass = 750,
		physicsChassisShape = 1.8444 1.2444 5.2889,
		centerOfMassOffset = 0.0000 0.6222 -0.0111,
		shadowExtents = 1.9096 5.5260,
		shadowOffset = 0.0000 -0.0313,
		engineForce = 4265,
		maxSpeed = 85f,
		engineLoudness = 84,
		engineQuality = 80,
		brakingForce = 80,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.99f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 32,
		suspensionCompression = 4.83,
		suspensionDamping = 3.88,
		maxSuspensionTravelCm = 18,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 195,
		rearEndHealth = 150,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7667 -0.6222 1.5444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7667 -0.6222 -1.3444,
			radius = 0.34f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4667 -0.3000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.3000 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0222 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.0444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3111 0.3333 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3111 0.3333 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3111 -0.6222 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.3111 -0.6222 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -1.7667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5444 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5444 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3444 0.4222 0.4222,
		}

		template = LTD91TrunkCompartment,
		
		template = LTD91Seats,
		template = LTD91BumpersPD,
		template = LTD91Doors,
		template = LTD91EngineDoor,
		template = LTD91TrunkDoor,
		template = LTD91Armor,
		template = LTD91SpareTires,
		template = LTD91Barrier,
		template = LTD91Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic91
			{
				file = 91fordLTDInterior,
				scale = 1.0,
			}

			model ksplightbar
			{
				file = 91fordLTDkspLightbar,
			}

			model bodsedan91
			{
				file = 91fordLTDSedanBase,
				scale = 1.0,
			}

			model intvic91sedan
			{
				file = 91fordLTDInteriorSedan,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlinVIC91
			{
				file = 91fordLTDTISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic91
			{
				file = 91fordLTDMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = LTD91Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic91
			{
				file = 91fordLTDRadio,
				scale = 1.0,
			}
		}

		template = Headlight,
        template = LTD91Windows,
		template = LTD91Windshields,
        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3555 0.0000,
			extents = 1.8000 0.6667 5.3111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9407 -0.4222,
			extents = 1.5778 0.5333 1.4444,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.8000 -1.3370,
			extents = 1.5778 0.8222 0.3556,
			rotate = 49.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7222 0.5370,
			extents = 1.5778 0.9556 0.5111,
			rotate = -54.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.7000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.7444,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92amgeneralM998SWAT",provider="92amgeneralM998",definition=[==[	vehicle 92amgeneralM998SWAT
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 92amgeneralM998Base,
			scale = 0.9000,
			offset = 0.0000 0.7111 0.0000,
		}

	
		skin
		{
			texture = Vehicles/Vehicles_92amgeneralM998_Shell_SWAT,
		}

		textureRust = Vehicles/92amgeneralM998_rust,
		textureMask = Vehicles/92amgeneralM998_mask,
		textureLights = Vehicles/92amgeneralM998_lights,
		textureDamage1Shell = Vehicles/92amgeneralM998_damage,
		textureDamage2Shell = Vehicles/92amgeneralM998_damage2,
		textureDamage1Overlay = Vehicles/92amgeneralM998_blood,
		textureDamage2Overlay = Vehicles/92amgeneralM998_blood,

		sound
		{
			engine = VehicleEngineSUV,
			engineStart = VehicleEngineSUV,
			engineTurnOff = VehicleEngineSUV,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailSUV,
		}

		extents = 2.2222 1.4000 4.6222,
		mass = 850,
		physicsChassisShape = 2.2222 1.4000 4.6222,
		centerOfMassOffset = 0.0000 0.8889 0.0778,
		shadowExtents = 2.2540 4.9926,
		shadowOffset = -0.0032 0.1301,
		engineForce = 4451,
		gearRatioCount = 4,
		gearRatioR = 14.4,
		gearRatio1 = 13.3,
		gearRatio2 = 9.6,
		gearRatio3 = 5.93,
		gearRatio4 = 3.94,
		maxSpeed = 85f,
		engineLoudness = 100,
		engineQuality = 80,
		brakingForce = 55,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.97f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 39,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.4f,
		frontEndHealth = 1500,
		rearEndHealth = 1350,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.9111 -0.6333 1.8333,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.9111 -0.6333 1.8333,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.9111 -0.6778 -1.3778,
			radius = 0.40f,
			width = 0.27f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.9111 -0.6778 -1.3778,
			radius = 0.40f,
			width = 0.27f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.6889 -0.0667 0.2333,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.4222 -0.9444 -0.0667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.6889 -0.0667 0.2333,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.4667 -0.9444 -0.0556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.6889 -0.0667 -0.6000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.4111 -0.8667 -0.6778,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.6889 -0.0667 -0.6000,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.4222 -0.8667 -0.6222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 1.5000 1.7889 0.7778 1.0000,
		}

		area TruckBed
		{
			xywh = 0.0000 -2.5667 1.3778 0.6667,
		}

		area Roofrack
		{
			xywh = 0.0000 -0.9333 3.2222 3.7111,
		}

		area SpareTire
		{
			xywh = -0.3222 -3.0000 0.4222 0.4222,
		}

		area Mudflaps
		{
			xywh = 0.4778 -2.6889 0.4222 0.4222,
		}

		area SeatFrontLeft
		{
			xywh = 1.5000 0.3889 0.7778 0.7778,
		}

		area SeatFrontRight
		{
			xywh = -1.5000 0.3889 0.7778 0.7778,
		}

		area SeatRearRight
		{
			xywh = -1.5000 -0.3778 0.7778 0.7333,
		}

		area SeatRearLeft
		{
			xywh = 1.5000 -0.3778 0.7778 0.7333,
		}

		area GasTank
		{
			xywh = -1.3222 -1.0222 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6111 1.7778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6111 1.7778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6111 -1.4444 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6111 -1.4444 0.4222 0.4222,
		}

		template = runFlatTires,
		template = centralTireInflation,
		template = M998TrunkCompartment,
		template = M998RoofrackCompartment,
		template = M998SpareTire,
		template = M998Mudflaps,
		template = M998TrunkDoor,
		template = M998TrunkBarriers,
		template = M998BackCovers,
		template = M998Seats,
		template = M998Mufflers,
		template = M998EngineDoor,
		template = M998Windshield,
		template = M998Windows,
		template = M998Doors,
		template = M998Armor,
		template = M998Bumpers,
		template = M998Tires,
		template = DAMNGunrack,

		part GloveBox
		{
			model InteriorM998
			{
				file = 92amgeneralM998interior,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
				scale = 1.0,
			}

			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			container
			{
				conditionAffectsCapacity = false,
				capacity = 95,
			}

			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model M998BatteryTIS
			{
				file = 92amgeneralM998battery,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
				scale = 1.0,
			}
		}

		template = Engine,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model Default
			{
				file = 92amgeneralM998radio,
				offset = 0.0000 0.0000 0.0000,
				rotate = 0.0000 0.0000 0.0000,
				scale = 1.0,
			}
		}

		template = Headlight,

		attachment trailer
		{
			offset = 0.0000 -0.3000 -2.3222,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3000 2.5333,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPI2Bulletin",provider="92fordCVPI",definition=[==[
	vehicle 92fordCVPI2Bulletin
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_92fordCVPI_Shell_Bulletin,
		}

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model vic92modern
			{
				file = 92fordCVPIlightbarModern,
				scale = 1.0,
			}

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPI2Louisville",provider="92fordCVPI",definition=[==[
	vehicle 92fordCVPI2Louisville
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

	  skin
		{
			texture = Vehicles/Vehicles_92fordCVPI_Shell_Louisville,
		}

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model vic92modern
			{
				file = 92fordCVPIlightbarModern,
				scale = 1.0,
			}

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPI2Meade",provider="92fordCVPI",definition=[==[
	vehicle 92fordCVPI2Meade
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
	       {
			texture = Vehicles/Vehicles_92fordCVPI_Shell_Meade,
		}
		

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model vic92modern
			{
				file = 92fordCVPIlightbarModern,
				scale = 1.0,
			}

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPI2Muldraugh",provider="92fordCVPI",definition=[==[
	vehicle 92fordCVPI2Muldraugh
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
	        {
			texture = Vehicles/Vehicles_92fordCVPI_Shell_Muldraugh,
		}

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model vic92modern
			{
				file = 92fordCVPIlightbarModern,
				scale = 1.0,
			}

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPI2WestPoint",provider="92fordCVPI",definition=[==[
	vehicle 92fordCVPI2WestPoint
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
	     {
			texture = Vehicles/Vehicles_92fordCVPI_Shell_WestPoint,
		}
		

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model vic92modern
			{
				file = 92fordCVPIlightbarModern,
				scale = 1.0,
			}

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPIBulletin",provider="92fordCVPI",definition=[==[	vehicle 92fordCVPIBulletin
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_92fordCVPI_Shell_Bulletin,
		}
		

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			model vic92old
			{
				file = 92fordCVPIlightbarOld,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPILouisville",provider="92fordCVPI",definition=[==[	vehicle 92fordCVPILouisville
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_92fordCVPI_Shell_Louisville,
		}
		
	

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			model vic92old
			{
				file = 92fordCVPIlightbarOld,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPIMeade",provider="92fordCVPI",definition=[==[	vehicle 92fordCVPIMeade
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_92fordCVPI_Shell_Meade,
		}
		
		
		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			model vic92old
			{
				file = 92fordCVPIlightbarOld,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPIMuldraugh",provider="92fordCVPI",definition=[==[	vehicle 92fordCVPIMuldraugh
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_92fordCVPI_Shell_Muldraugh,
		}
		
		

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			model vic92old
			{
				file = 92fordCVPIlightbarOld,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.92fordCVPIWestPoint",provider="92fordCVPI",definition=[==[	vehicle 92fordCVPIWestPoint
	{
		mechanicType = 1,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.1,

		model
		{
			file = 92fordCVPIBase,
			scale = 0.9000,
			offset = 0.0000 0.6333 0.0000,
		}

		skin
		{
			texture = Vehicles/Vehicles_92fordCVPI_Shell_WestPoint,
		}
		

		textureRust = Vehicles/Vehicles_92fordCVPI_Rust,
		textureMask = Vehicles/Vehicles_92fordCVPI_Mask,
		textureLights = Vehicles/Vehicles_92fordCVPI_Lights,
		textureDamage1Shell = Vehicles/Vehicles_92fordCVPI_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_92fordCVPI_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_92fordCVPI_Blood1,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineDefault,
			engineStart = VehicleEngineDefault,
			engineTurnOff = VehicleEngineDefault,
			horn = VehicleHornStandard,
			ignitionFail = VehicleIgnitionFailDefault,
		}

		extents = 1.8667 1.2444 5.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.2444 5.4222,
		centerOfMassOffset = 0.0000 0.6222 -0.0444,
		shadowExtents = 1.9208 5.6149,
		shadowOffset = 0.0000 -0.0143,
		engineForce = 4565,
		maxSpeed = 90f,
		engineLoudness = 80,
		engineQuality = 82,
		brakingForce = 90,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.98f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 45,
		suspensionCompression = 3.83,
		suspensionDamping = 2.88,
		maxSuspensionTravelCm = 10,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.6f,
		frontEndHealth = 205,
		rearEndHealth = 160,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7778 -0.6222 1.6000,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7778 -0.6222 -1.3667,
			radius = 0.35f,
			width = 0.22f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3222 -0.9667 -0.2667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 0.1222,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3333 -0.9667 -0.2556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.3333 -0.9556 -1.1667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4889 -0.2889 -0.8889,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.3222 -0.9556 -1.1444,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.0556 1.6667 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1444 1.6889 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.4000 0.3889 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.4000 0.3889 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.4000 -0.5667 0.7778 0.7556,
		}

		area SeatRearLeft
		{
			xywh = 1.4000 -0.5667 0.7778 0.7556,
		}

		area GasTank
		{
			xywh = 1.4111 -2.3333 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.4111 1.5778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.4111 1.5778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.4111 -1.3778 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.4111 -1.3778 0.4222 0.4222,
		}

		template = CVPI92TrunkCompartment,
		template = CVPI92Seats,
		template = CVPI92Bumpers,
		template = CVPI92Doors,
		template = CVPI92EngineDoor,
		template = CVPI92TrunkDoor,
		template = CVPI92Armor,
		template = CVPI92SpareTires,
		template = CVPI92Barrier,
        template = CVPI92Searchlight,
		template = DAMNGunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model intvic92
			{
				file = 92fordCVPIInterior,
				scale = 1.0,
			}

			model vic92old
			{
				file = 92fordCVPIlightbarOld,
				scale = 1.0,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model batlin
			{
				file = 92fordCVPITISBattery,
				scale = 1.0,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model muffvic92
			{
				file = 92fordCVPIMuffler,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = CVPI92Tires,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,

		part Radio
		{
			model radiovic92
			{
				file = 92fordCVPIRadio,
				scale = 1.0,
			}
		}

		template = Headlight,

        template = CVPI92Windows,
		template = CVPI92Windshields,

        useChassisPhysicsCollision = false,

		physics box
		{
			offset = 0.0000 0.3556 -0.0452,
			extents = 1.8667 0.7111 5.3556,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.9778 -0.5030,
			extents = 1.5333 0.5333 1.3778,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7407 0.5333,
			extents = 1.5333 0.5333 1.1111,
			rotate = 30.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 0.7889 -1.4079,
			extents = 1.5333 0.8889 0.4667,
			rotate = 53.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.4889 -2.9111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.4889 2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93chevySilveradoCClongLouisville",provider="93chevySuburban",definition=[==[
	vehicle 93chevySilveradoCClongLouisville
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93chevySuburbanBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.5000,
		}

		skin
		{
		    texture = Vehicles/Vehicles_93chevySilveradoCC_Shell_Louisville,
		}

		textureRust = Vehicles/Vehicles_93chevySuburban_Rust,
		textureMask = Vehicles/Vehicles_93chevySilveradoCC_Mask,
		textureLights = Vehicles/Vehicles_93chevySuburbanPD_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93chevySuburban_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93chevySuburban_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureShadow = Vehicles/Vehicles_93chevySuburban_Shadow,

        lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.8667 1.4222 6.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.4222 6.4222,
		centerOfMassOffset = 0.0000 0.7667 -0.0222,
		shadowExtents = 2.0542 6.4483,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7889 -0.6000 -2.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7889 -0.6000 -2.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9556 -0.9889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9556 -0.9667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.5778 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6222 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -2.0778 3.2000 3.4889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3222 1.0444 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3222 1.0444 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3222 0.0000 0.7778 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 1.3222 0.0000 0.7778 0.9333,
		}

		area GasTank
		{
			xywh = 1.3889 -0.9667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 2.2667 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 2.2667 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.8667 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.8667 0.4222 0.4222,
		}

		template = SUB93Seats4,
		template = SIL93TrunkCompartment,

        part SIL93Trunk3
		{
			container
			{
				capacity = 115,
			}
		}

		template = SUB93TrunkDoorCC,
		template = SUB93EngineDoor,
		
		template = SUB93Doors,
		template = SUB93ArmorFront,
		template = SUB93ArmorRear,
		template = SUB93BumpersCCFD,
		template = SUB93TruckBedAddonsCC,
		template = SUB93Tires,
		template = SUB93BugGuard,
        template = SIL93SideStepsLOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model sub93Int
			{
				file = 93chevySuburbanInterior,
			}

			model sub93IntMiddle
			{
				file = 93chevySuburbanInteriorMiddle,
			}

			model sil93IntRearCC
			{
				file = 93chevySilveradoCCInterior,
			}

			model sil93bodyRearCC
			{
				file = 93chevySilveradoCC,
			}

			model sil93bedLong
			{
				file = 93chevySilveradoBedLong,
			}

			model sil93bedLongInterior
			{
				file = 93chevySilveradoBedLongInterior,
			}

            model sub93lightbar
			{
				file = 93chevySuburbanLightbar,
			}

			model sil93insidel
			{
				file = 93chevySilveradoInsideLights,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model sub93Bat
			{
				file = 93chevySuburbanTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model sub93Muff
			{
				file = 93chevySuburbanMuff,
                offset = 0.0000 0.0000 -0.8000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,

        useChassisPhysicsCollision = false,
        template = SUB93WindshieldFront,
		template = SUB93WindshieldRearCC,
		template = SUB93WindowsSideFront,
		template = SUB93WindowsSideRear,
		physics box
		{
			offset = 0.0000 0.4556 -0.1170,
			extents = 1.8444 0.8889 6.2889,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.4222 0.4444 2.9813,
			extents = 0.2889 0.6222 0.9556,
			rotate = 0.0000 -79.0000 0.0000,
		}

		physics box
		{
			offset = -0.4333 0.4444 2.9739,
			extents = 0.9556 0.6222 0.3111,
			rotate = 0.0000 -11.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.1667 0.3926,
			extents = 1.6444 0.5333 1.8000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0111 1.4871,
			extents = 1.6444 0.8444 0.4000,
			rotate = -50.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.7556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.8556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93chevySilveradoCClongMuldraugh",provider="93chevySuburban",definition=[==[
	vehicle 93chevySilveradoCClongMuldraugh
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93chevySuburbanBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.5000,
		}

		skin
		{
		    texture = Vehicles/Vehicles_93chevySilveradoCC_Shell_Muldraugh,
		}

		textureRust = Vehicles/Vehicles_93chevySuburban_Rust,
		textureMask = Vehicles/Vehicles_93chevySilveradoCC_Mask,
		textureLights = Vehicles/Vehicles_93chevySuburbanpd_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93chevySuburban_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93chevySuburban_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureShadow = Vehicles/Vehicles_93chevySuburban_Shadow,

        lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.8667 1.4222 6.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.4222 6.4222,
		centerOfMassOffset = 0.0000 0.7667 -0.0222,
		shadowExtents = 2.0542 6.4483,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7889 -0.6000 -2.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7889 -0.6000 -2.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9556 -0.9889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9556 -0.9667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.5778 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6222 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -2.0778 3.2000 3.4889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3222 1.0444 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3222 1.0444 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3222 0.0000 0.7778 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 1.3222 0.0000 0.7778 0.9333,
		}

		area GasTank
		{
			xywh = 1.3889 -0.9667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 2.2667 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 2.2667 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.8667 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.8667 0.4222 0.4222,
		}

		template = SUB93Seats4,
		template = SIL93TrunkCompartment,

        part SIL93Trunk3
		{
			container
			{
				capacity = 115,
			}
		}

		template = SUB93TrunkDoorCC,
		template = SUB93EngineDoor,
		
		template = SUB93Doors,
		template = SUB93ArmorFront,
		template = SUB93ArmorRear,
		template = SUB93BumpersCCFD,
		template = SUB93TruckBedAddonsCC,
		template = SUB93Tires,
		template = SUB93BugGuard,
        template = SIL93SideStepsLOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model sub93Int
			{
				file = 93chevySuburbanInterior,
			}

			model sub93IntMiddle
			{
				file = 93chevySuburbanInteriorMiddle,
			}

			model sil93IntRearCC
			{
				file = 93chevySilveradoCCInterior,
			}

			model sil93bodyRearCC
			{
				file = 93chevySilveradoCC,
			}

			model sil93bedLong
			{
				file = 93chevySilveradoBedLong,
			}

			model sil93bedLongInterior
			{
				file = 93chevySilveradoBedLongInterior,
			}

            model sub93lightbar
			{
				file = 93chevySuburbanLightbar,
			}

			model sil93insidel
			{
				file = 93chevySilveradoInsideLights,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model sub93Bat
			{
				file = 93chevySuburbanTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model sub93Muff
			{
				file = 93chevySuburbanMuff,
                offset = 0.0000 0.0000 -0.8000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,

        useChassisPhysicsCollision = false,
        template = SUB93WindshieldFront,
		template = SUB93WindshieldRearCC,
		template = SUB93WindowsSideFront,
		template = SUB93WindowsSideRear,
		physics box
		{
			offset = 0.0000 0.4556 -0.1170,
			extents = 1.8444 0.8889 6.2889,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.4222 0.4444 2.9813,
			extents = 0.2889 0.6222 0.9556,
			rotate = 0.0000 -79.0000 0.0000,
		}

		physics box
		{
			offset = -0.4333 0.4444 2.9739,
			extents = 0.9556 0.6222 0.3111,
			rotate = 0.0000 -11.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.1667 0.3926,
			extents = 1.6444 0.5333 1.8000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0111 1.4871,
			extents = 1.6444 0.8444 0.4000,
			rotate = -50.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.7556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.8556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93chevySilveradoCClongSecurity",provider="93chevySuburban",definition=[==[
	vehicle 93chevySilveradoCClongSecurity
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93chevySuburbanBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.5000,
		}

		skin
		{
		   texture = Vehicles/Vehicles_93chevySilveradoCC_Shell_Security,
		}

		textureRust = Vehicles/Vehicles_93chevySuburban_Rust,
		textureMask = Vehicles/Vehicles_93chevySilveradoCC_Mask,
		textureLights = Vehicles/Vehicles_93chevySilveradoOrange_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93chevySuburban_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93chevySuburban_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureShadow = Vehicles/Vehicles_93chevySuburban_Shadow,

        lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 1;0.6;0,
			rightCol = 1;0.6;0,
                 }
		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.8667 1.4222 6.4222,
		mass = 800,
		physicsChassisShape = 1.8667 1.4222 6.4222,
		centerOfMassOffset = 0.0000 0.7667 -0.0222,
		shadowExtents = 2.0542 6.4483,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7889 -0.6000 -2.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7889 -0.6000 -2.3778,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9556 -0.9889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9556 -0.9667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
		}

		area Engine
		{
			xywh = 0.0000 3.5778 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6222 1.7556 0.7778,
		}

		area Roofrack
		{
			xywh = 0.0000 -2.0778 3.2000 3.4889,
		}

		area SeatFrontLeft
		{
			xywh = 1.3222 1.0444 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3222 1.0444 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3222 0.0000 0.7778 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 1.3222 0.0000 0.7778 0.9333,
		}

		area GasTank
		{
			xywh = 1.3889 -0.9667 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 2.2667 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 2.2667 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.8667 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.8667 0.4222 0.4222,
		}

		template = SUB93Seats4,
		template = SIL93TrunkCompartment,

        part SIL93Trunk3
		{
			container
			{
				capacity = 115,
			}
		}

		template = SUB93TrunkDoorCC,
		template = SUB93EngineDoor,
		
		template = SUB93Doors,
		template = SUB93ArmorFront,
		template = SUB93ArmorRear,
		template = SUB93BumpersCCFD,
		template = SUB93TruckBedAddonsCC,
		template = SUB93Tires,
		template = SUB93BugGuard,
        template = SIL93SideStepsLOFF,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model sub93Int
			{
				file = 93chevySuburbanInterior,
			}

			model sub93IntMiddle
			{
				file = 93chevySuburbanInteriorMiddle,
			}

			model sil93IntRearCC
			{
				file = 93chevySilveradoCCInterior,
			}

			model sil93bodyRearCC
			{
				file = 93chevySilveradoCC,
			}

			model sil93bedLong
			{
				file = 93chevySilveradoBedLong,
			}

			model sil93bedLongInterior
			{
				file = 93chevySilveradoBedLongInterior,
			}

            model sub93lightbar
			{
				file = 93chevySuburbanLightbar,
			}

			model sil93insidel
			{
				file = 93chevySilveradoInsideLights,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model sub93Bat
			{
				file = 93chevySuburbanTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model sub93Muff
			{
				file = 93chevySuburbanMuff,
                offset = 0.0000 0.0000 -0.8000,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio,
		template = Headlight,

        useChassisPhysicsCollision = false,
        template = SUB93WindshieldFront,
		template = SUB93WindshieldRearCC,
		template = SUB93WindowsSideFront,
		template = SUB93WindowsSideRear,
		physics box
		{
			offset = 0.0000 0.4556 -0.1170,
			extents = 1.8444 0.8889 6.2889,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.4222 0.4444 2.9813,
			extents = 0.2889 0.6222 0.9556,
			rotate = 0.0000 -79.0000 0.0000,
		}

		physics box
		{
			offset = -0.4333 0.4444 2.9739,
			extents = 0.9556 0.6222 0.3111,
			rotate = 0.0000 -11.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.1667 0.3926,
			extents = 1.6444 0.5333 1.8000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0111 1.4871,
			extents = 1.6444 0.8444 0.4000,
			rotate = -50.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.7556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.8556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93chevySuburbanpdBulletin",provider="93chevySuburban",definition=[==[	vehicle 93chevySuburbanpdBulletin
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93chevySuburbanBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.0556,
		}

		skin
		{
		    texture = Vehicles/Vehicles_93chevySuburbanpd_Shell_Bulletin,
		}


		textureRust = Vehicles/Vehicles_93chevySuburban_Rust,
		textureMask = Vehicles/Vehicles_93chevySuburbanpd_Mask,
		textureLights = Vehicles/Vehicles_93chevySuburbanpd_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93chevySuburban_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93chevySuburban_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureShadow = Vehicles/Vehicles_93chevySuburban_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.8667 1.4222 5.6000,
		mass = 880,
		physicsChassisShape = 1.8667 1.4222 5.6000,
		centerOfMassOffset = 0.0000 0.7667 0.0000,
		shadowExtents = 2.0542 5.5150,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9556 -0.9889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9556 -0.9667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.1889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1889 1.7556 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3222 0.6556 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3222 0.6556 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3222 -0.3889 0.7778 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 1.3222 -0.3889 0.7778 0.9333,
		}

		area GasTank
		{
			xywh = 1.3889 -2.4556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.8778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.8778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.4667 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.4667 0.4222 0.4222,
		}

		template = SUB93Seats4,
		template = SUB93TrunkCompartmentLargePD,
		template = SUB93TrunkDoor,
		template = SUB93EngineDoor,
		
		template = SUB93Doors,
		template = SUB93ArmorAlt,
		template = SUB93BumpersPD,
		template = SUB93SideStepsOff,
		template = SUB93Tires,
		template = SUB93SpareTires,
		template = SUB93BugGuardOff,
		template = SUB93Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model sub93Int
			{
				file = 93chevySuburbanInterior,
			}

			model sub93IntMiddle
			{
				file = 93chevySuburbanInteriorMiddle,
			}

			model sub93IntRear
			{
				file = 93chevySuburbanInteriorRear,
			}

			model sub93bodyRear
			{
				file = 93chevySuburbanRear,
			}

			model sub93lightbar
			{
				file = 93chevySuburbanLightbar,
			}

			model sub93barrier
			{
				file = 93chevySuburbanCabBarrier,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model sub93Bat
			{
				file = 93chevySuburbanTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model sub93Muff
			{
				file = 93chevySuburbanMuff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,

        useChassisPhysicsCollision = false,
        template = SUB93WindshieldFront,
		template = SUB93WindshieldRearPD,
		template = SUB93Windows,
		physics box
		{
			offset = 0.0000 0.4556 -0.1493,
			extents = 1.8444 0.8889 5.4000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.4222 0.4444 2.5376,
			extents = 0.2889 0.6222 0.9556,
			rotate = 0.0000 -79.0000 0.0000,
		}

		physics box
		{
			offset = -0.4333 0.4444 2.5238,
			extents = 0.9556 0.6222 0.3111,
			rotate = 0.0000 -11.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.1667 -0.8963,
			extents = 1.6444 0.5333 3.5111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0111 1.0547,
			extents = 1.6444 0.8444 0.4000,
			rotate = -50.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.8556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93chevySuburbanpdLouisville",provider="93chevySuburban",definition=[==[	vehicle 93chevySuburbanpdLouisville
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93chevySuburbanBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.0556,
		}

		skin
		{
		    texture = Vehicles/Vehicles_93chevySuburbanpd_Shell_Louis,
		}


		textureRust = Vehicles/Vehicles_93chevySuburban_Rust,
		textureMask = Vehicles/Vehicles_93chevySuburbanpd_Mask,
		textureLights = Vehicles/Vehicles_93chevySuburbanpd_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93chevySuburban_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93chevySuburban_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureShadow = Vehicles/Vehicles_93chevySuburban_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.8667 1.4222 5.6000,
		mass = 880,
		physicsChassisShape = 1.8667 1.4222 5.6000,
		centerOfMassOffset = 0.0000 0.7667 0.0000,
		shadowExtents = 2.0542 5.5150,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9556 -0.9889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9556 -0.9667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.1889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1889 1.7556 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3222 0.6556 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3222 0.6556 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3222 -0.3889 0.7778 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 1.3222 -0.3889 0.7778 0.9333,
		}

		area GasTank
		{
			xywh = 1.3889 -2.4556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.8778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.8778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.4667 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.4667 0.4222 0.4222,
		}

		template = SUB93Seats4,
		template = SUB93TrunkCompartmentLargePD,
		template = SUB93TrunkDoor,
		template = SUB93EngineDoor,
		
		template = SUB93Doors,
		template = SUB93ArmorAlt,
		template = SUB93BumpersPD,
		template = SUB93SideStepsOff,
		template = SUB93Tires,
		template = SUB93SpareTires,
		template = SUB93BugGuardOff,
		template = SUB93Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model sub93Int
			{
				file = 93chevySuburbanInterior,
			}

			model sub93IntMiddle
			{
				file = 93chevySuburbanInteriorMiddle,
			}

			model sub93IntRear
			{
				file = 93chevySuburbanInteriorRear,
			}

			model sub93bodyRear
			{
				file = 93chevySuburbanRear,
			}

			model sub93lightbar
			{
				file = 93chevySuburbanLightbar,
			}

			model sub93barrier
			{
				file = 93chevySuburbanCabBarrier,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model sub93Bat
			{
				file = 93chevySuburbanTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model sub93Muff
			{
				file = 93chevySuburbanMuff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,

        useChassisPhysicsCollision = false,
        template = SUB93WindshieldFront,
		template = SUB93WindshieldRearPD,
		template = SUB93Windows,
		physics box
		{
			offset = 0.0000 0.4556 -0.1493,
			extents = 1.8444 0.8889 5.4000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.4222 0.4444 2.5376,
			extents = 0.2889 0.6222 0.9556,
			rotate = 0.0000 -79.0000 0.0000,
		}

		physics box
		{
			offset = -0.4333 0.4444 2.5238,
			extents = 0.9556 0.6222 0.3111,
			rotate = 0.0000 -11.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.1667 -0.8963,
			extents = 1.6444 0.5333 3.5111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0111 1.0547,
			extents = 1.6444 0.8444 0.4000,
			rotate = -50.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.8556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93chevySuburbanpdMeade",provider="93chevySuburban",definition=[==[	vehicle 93chevySuburbanpdMeade
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93chevySuburbanBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.0556,
		}

		skin
		{
			texture = Vehicles/Vehicles_93chevySuburbanpd_Shell_Meade,
		}

		

		textureRust = Vehicles/Vehicles_93chevySuburban_Rust,
		textureMask = Vehicles/Vehicles_93chevySuburbanpd_Mask,
		textureLights = Vehicles/Vehicles_93chevySuburbanpd_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93chevySuburban_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93chevySuburban_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureShadow = Vehicles/Vehicles_93chevySuburban_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.8667 1.4222 5.6000,
		mass = 880,
		physicsChassisShape = 1.8667 1.4222 5.6000,
		centerOfMassOffset = 0.0000 0.7667 0.0000,
		shadowExtents = 2.0542 5.5150,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9556 -0.9889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9556 -0.9667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.1889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1889 1.7556 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3222 0.6556 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3222 0.6556 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3222 -0.3889 0.7778 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 1.3222 -0.3889 0.7778 0.9333,
		}

		area GasTank
		{
			xywh = 1.3889 -2.4556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.8778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.8778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.4667 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.4667 0.4222 0.4222,
		}

		template = SUB93Seats4,
		template = SUB93TrunkCompartmentLargePD,
		template = SUB93TrunkDoor,
		template = SUB93EngineDoor,
		
		template = SUB93Doors,
		template = SUB93ArmorAlt,
		template = SUB93BumpersPD,
		template = SUB93SideStepsOff,
		template = SUB93Tires,
		template = SUB93SpareTires,
		template = SUB93BugGuardOff,
		template = SUB93Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model sub93Int
			{
				file = 93chevySuburbanInterior,
			}

			model sub93IntMiddle
			{
				file = 93chevySuburbanInteriorMiddle,
			}

			model sub93IntRear
			{
				file = 93chevySuburbanInteriorRear,
			}

			model sub93bodyRear
			{
				file = 93chevySuburbanRear,
			}

			model sub93lightbar
			{
				file = 93chevySuburbanLightbar,
			}

			model sub93barrier
			{
				file = 93chevySuburbanCabBarrier,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model sub93Bat
			{
				file = 93chevySuburbanTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model sub93Muff
			{
				file = 93chevySuburbanMuff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,

        useChassisPhysicsCollision = false,
        template = SUB93WindshieldFront,
		template = SUB93WindshieldRearPD,
		template = SUB93Windows,
		physics box
		{
			offset = 0.0000 0.4556 -0.1493,
			extents = 1.8444 0.8889 5.4000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.4222 0.4444 2.5376,
			extents = 0.2889 0.6222 0.9556,
			rotate = 0.0000 -79.0000 0.0000,
		}

		physics box
		{
			offset = -0.4333 0.4444 2.5238,
			extents = 0.9556 0.6222 0.3111,
			rotate = 0.0000 -11.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.1667 -0.8963,
			extents = 1.6444 0.5333 3.5111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0111 1.0547,
			extents = 1.6444 0.8444 0.4000,
			rotate = -50.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.8556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93chevySuburbanpdMuldraugh",provider="93chevySuburban",definition=[==[	vehicle 93chevySuburbanpdMuldraugh
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93chevySuburbanBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.0556,
		}

		skin
		{
			texture = Vehicles/Vehicles_93chevySuburbanpd_Shell_Muldraugh,
		}

		

		textureRust = Vehicles/Vehicles_93chevySuburban_Rust,
		textureMask = Vehicles/Vehicles_93chevySuburbanpd_Mask,
		textureLights = Vehicles/Vehicles_93chevySuburbanpd_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93chevySuburban_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93chevySuburban_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureShadow = Vehicles/Vehicles_93chevySuburban_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.8667 1.4222 5.6000,
		mass = 880,
		physicsChassisShape = 1.8667 1.4222 5.6000,
		centerOfMassOffset = 0.0000 0.7667 0.0000,
		shadowExtents = 2.0542 5.5150,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9556 -0.9889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9556 -0.9667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.1889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1889 1.7556 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3222 0.6556 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3222 0.6556 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3222 -0.3889 0.7778 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 1.3222 -0.3889 0.7778 0.9333,
		}

		area GasTank
		{
			xywh = 1.3889 -2.4556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.8778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.8778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.4667 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.4667 0.4222 0.4222,
		}

		template = SUB93Seats4,
		template = SUB93TrunkCompartmentLargePD,
		template = SUB93TrunkDoor,
		template = SUB93EngineDoor,
		
		template = SUB93Doors,
		template = SUB93ArmorAlt,
		template = SUB93BumpersPD,
		template = SUB93SideStepsOff,
		template = SUB93Tires,
		template = SUB93SpareTires,
		template = SUB93BugGuardOff,
		template = SUB93Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model sub93Int
			{
				file = 93chevySuburbanInterior,
			}

			model sub93IntMiddle
			{
				file = 93chevySuburbanInteriorMiddle,
			}

			model sub93IntRear
			{
				file = 93chevySuburbanInteriorRear,
			}

			model sub93bodyRear
			{
				file = 93chevySuburbanRear,
			}

			model sub93lightbar
			{
				file = 93chevySuburbanLightbar,
			}

			model sub93barrier
			{
				file = 93chevySuburbanCabBarrier,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model sub93Bat
			{
				file = 93chevySuburbanTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model sub93Muff
			{
				file = 93chevySuburbanMuff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,

        useChassisPhysicsCollision = false,
        template = SUB93WindshieldFront,
		template = SUB93WindshieldRearPD,
		template = SUB93Windows,
		physics box
		{
			offset = 0.0000 0.4556 -0.1493,
			extents = 1.8444 0.8889 5.4000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.4222 0.4444 2.5376,
			extents = 0.2889 0.6222 0.9556,
			rotate = 0.0000 -79.0000 0.0000,
		}

		physics box
		{
			offset = -0.4333 0.4444 2.5238,
			extents = 0.9556 0.6222 0.3111,
			rotate = 0.0000 -11.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.1667 -0.8963,
			extents = 1.6444 0.5333 3.5111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0111 1.0547,
			extents = 1.6444 0.8444 0.4000,
			rotate = -50.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.8556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93chevySuburbanpdWestPoint",provider="93chevySuburban",definition=[==[	vehicle 93chevySuburbanpdWestPoint
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93chevySuburbanBase,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.0556,
		}

		skin
		{
			texture = Vehicles/Vehicles_93chevySuburbanpd_Shell_WestPoint,
		}


		textureRust = Vehicles/Vehicles_93chevySuburban_Rust,
		textureMask = Vehicles/Vehicles_93chevySuburbanpd_Mask,
		textureLights = Vehicles/Vehicles_93chevySuburbanpd_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93chevySuburban_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93chevySuburban_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93chevySuburban_Blood1,
		textureShadow = Vehicles/Vehicles_93chevySuburban_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 1;0;0,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 1.8667 1.4222 5.6000,
		mass = 880,
		physicsChassisShape = 1.8667 1.4222 5.6000,
		centerOfMassOffset = 0.0000 0.7667 0.0000,
		shadowExtents = 2.0542 5.5150,
		shadowOffset = 0.0000 -0.0366,
		engineForce = 4250,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.7889 -0.6000 1.8000,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.7889 -0.6000 -1.5444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9556 0.1222,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4222 -0.0111 0.3444,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9556 0.1556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}

			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9556 -0.9889,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.4000 -0.0111 -0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9556 -0.9667,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}

			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.1889 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.1889 1.7556 0.7778,
		}

		area SeatFrontLeft
		{
			xywh = 1.3222 0.6556 0.7778 1.1556,
		}

		area SeatFrontRight
		{
			xywh = -1.3222 0.6556 0.7778 1.1556,
		}

		area SeatRearRight
		{
			xywh = -1.3222 -0.3889 0.7778 0.9333,
		}

		area SeatRearLeft
		{
			xywh = 1.3222 -0.3889 0.7778 0.9333,
		}

		area GasTank
		{
			xywh = 1.3889 -2.4556 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.5444 1.8778 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.5444 1.8778 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.5444 -1.4667 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.5444 -1.4667 0.4222 0.4222,
		}

		template = SUB93Seats4,
		template = SUB93TrunkCompartmentLargePD,
		template = SUB93TrunkDoor,
		template = SUB93EngineDoor,
		
		template = SUB93Doors,
		template = SUB93ArmorAlt,
		template = SUB93BumpersPD,
		template = SUB93SideStepsOff,
		template = SUB93Tires,
		template = SUB93SpareTires,
		template = SUB93BugGuardOff,
		template = SUB93Gunrack,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model sub93Int
			{
				file = 93chevySuburbanInterior,
			}

			model sub93IntMiddle
			{
				file = 93chevySuburbanInteriorMiddle,
			}

			model sub93IntRear
			{
				file = 93chevySuburbanInteriorRear,
			}

			model sub93bodyRear
			{
				file = 93chevySuburbanRear,
			}

			model sub93lightbar
			{
				file = 93chevySuburbanLightbar,
			}

			model sub93barrier
			{
				file = 93chevySuburbanCabBarrier,
			}

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model sub93Bat
			{
				file = 93chevySuburbanTISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model sub93Muff
			{
				file = 93chevySuburbanMuff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,

        useChassisPhysicsCollision = false,
        template = SUB93WindshieldFront,
		template = SUB93WindshieldRearPD,
		template = SUB93Windows,
		physics box
		{
			offset = 0.0000 0.4556 -0.1493,
			extents = 1.8444 0.8889 5.4000,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.4222 0.4444 2.5376,
			extents = 0.2889 0.6222 0.9556,
			rotate = 0.0000 -79.0000 0.0000,
		}

		physics box
		{
			offset = -0.4333 0.4444 2.5238,
			extents = 0.9556 0.6222 0.3111,
			rotate = 0.0000 -11.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.1667 -0.8963,
			extents = 1.6444 0.5333 3.5111,
			rotate = 0.0000 0.0000 0.0000,
		}

		physics box
		{
			offset = 0.0000 1.0111 1.0547,
			extents = 1.6444 0.8444 0.4000,
			rotate = -50.0000 0.0000 0.0000,
		}

		attachment trailer
		{
			offset = 0.0000 -0.3222 -2.9000,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 2.8556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350pdBulletin",provider="93fordF350",definition=[==[	vehicle 93fordF350pdBulletin
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1333,
		}
             skin
		{
			texture = Vehicles/Vehicles_93fordF350Bulletin_Shell_utilitypng,
		}


		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350pd_Mask,
		textureLights = Vehicles/Vehicles_93fordF350so_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 0;0;1,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.4444,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.4444,
		centerOfMassOffset = 0.0000 0.8444 0.0000,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6111 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.8667 3.5556 0.9111,
		}

        area Roofrack
		{
			xywh = 0.0000 -1.8889 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F3502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model f350lights
			{
				file = 93fordF350Lights,
			}

			model f350barrier
			{
				file = 93fordF350CabBarrier,
			}

            model fx50_int
            {
                file = 93fordFx50Interior,
            }

            model f350_bed
            {
                file = 93fordF350BaseBed,
            }

            model f350longint
            {
                file = 93fordFx50LongbedInterior,
            }

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		
		template = F3502Doors,
		template = F3502Armor,
		template = F3502Bullbars,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502Roofrack,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = F3502TruckBedAddonsON,
		template = F3502TruckBedAddons,
        template = F3502TruckBedCover,
		template = F3502Gunrack,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
        template = F3502Windshields,
		template = F3502Windows,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350pdLouisville",provider="93fordF350",definition=[==[	vehicle 93fordF350pdLouisville
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1333,
		}

		skin
		{
			texture = Vehicles/Vehicles_93fordF350Louisville_Shell_utilitypng,
		}

		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350pd_Mask,
		textureLights = Vehicles/Vehicles_93fordF350so_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 0;0;1,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.4444,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.4444,
		centerOfMassOffset = 0.0000 0.8444 0.0000,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6111 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.8667 3.5556 0.9111,
		}

        area Roofrack
		{
			xywh = 0.0000 -1.8889 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F3502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model f350lights
			{
				file = 93fordF350Lights,
			}

			model f350barrier
			{
				file = 93fordF350CabBarrier,
			}

            model fx50_int
            {
                file = 93fordFx50Interior,
            }

            model f350_bed
            {
                file = 93fordF350BaseBed,
            }

            model f350longint
            {
                file = 93fordFx50LongbedInterior,
            }

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		
		template = F3502Doors,
		template = F3502Armor,
		template = F3502Bullbars,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502Roofrack,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = F3502TruckBedAddonsON,
		template = F3502TruckBedAddons,
        template = F3502TruckBedCover,
		template = F3502Gunrack,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
        template = F3502Windshields,
		template = F3502Windows,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350pdMeade",provider="93fordF350",definition=[==[	vehicle 93fordF350pdMeade
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1333,
		}

	  skin
		{
			texture = Vehicles/Vehicles_93fordF350Meade_Shell_utilitypng,
		}

		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350pd_Mask,
		textureLights = Vehicles/Vehicles_93fordF350pd_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 0;0;1,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.4444,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.4444,
		centerOfMassOffset = 0.0000 0.8444 0.0000,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6111 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.8667 3.5556 0.9111,
		}

        area Roofrack
		{
			xywh = 0.0000 -1.8889 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F3502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model f350lights
			{
				file = 93fordF350Lights,
			}

			model f350barrier
			{
				file = 93fordF350CabBarrier,
			}

            model fx50_int
            {
                file = 93fordFx50Interior,
            }

            model f350_bed
            {
                file = 93fordF350BaseBed,
            }

            model f350longint
            {
                file = 93fordFx50LongbedInterior,
            }

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		
		template = F3502Doors,
		template = F3502Armor,
		template = F3502Bullbars,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502Roofrack,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = F3502TruckBedAddonsON,
		template = F3502TruckBedAddons,
        template = F3502TruckBedCover,
		template = F3502Gunrack,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
        template = F3502Windshields,
		template = F3502Windows,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350pdMuldraugh",provider="93fordF350",definition=[==[	vehicle 93fordF350pdMuldraugh
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1333,
		}

	  skin
		{
			texture = Vehicles/Vehicles_93fordF350Muldraugh_Shell_utilitypng,
		}

		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350so_Mask,
		textureLights = Vehicles/Vehicles_93fordF350pd_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 0;0;1,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.4444,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.4444,
		centerOfMassOffset = 0.0000 0.8444 0.0000,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6111 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.8667 3.5556 0.9111,
		}

        area Roofrack
		{
			xywh = 0.0000 -1.8889 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F3502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model f350lights
			{
				file = 93fordF350Lights,
			}

			model f350barrier
			{
				file = 93fordF350CabBarrier,
			}

            model fx50_int
            {
                file = 93fordFx50Interior,
            }

            model f350_bed
            {
                file = 93fordF350BaseBed,
            }

            model f350longint
            {
                file = 93fordFx50LongbedInterior,
            }

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		
		template = F3502Doors,
		template = F3502Armor,
		template = F3502Bullbars,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502Roofrack,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = F3502TruckBedAddonsON,
		template = F3502TruckBedAddons,
        template = F3502TruckBedCover,
		template = F3502Gunrack,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
        template = F3502Windshields,
		template = F3502Windows,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
{script="Base.93fordF350pdWestPoint",provider="93fordF350",definition=[==[	vehicle 93fordF350pdWestPoint
	{
		mechanicType = 2,
		offRoadEfficiency = 1.5,
		engineRepairLevel = 4,
		playerDamageProtection = 1.3,

		model
		{
			file = 93fordF350Base,
			scale = 0.9000,
			offset = 0.0000 0.5333 0.1333,
		}

		skin
		{
			texture = Vehicles/Vehicles_93fordF350WestPoint_Shell_utilitypng,
		}


		textureRust = Vehicles/Vehicles_93fordF350_Rust,
		textureMask = Vehicles/Vehicles_93fordF350pd_Mask,
		textureLights = Vehicles/Vehicles_93fordF350so_Lights,
		textureDamage1Shell = Vehicles/Vehicles_93fordF350_Damage1,
		textureDamage2Shell = Vehicles/Vehicles_93fordF350_Damage2,
		textureDamage1Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureDamage2Overlay = Vehicles/Vehicles_93fordF350_Blood1,
		textureShadow = Vehicles/Vehicles_93fordF350_Shadow,

		lightbar
		{
			soundSiren = VehicleSiren,
			leftCol = 0;0;1,
			rightCol = 0;0;1,
		}

		sound
		{
			engine = VehicleEngineOffRoad,
			engineStart = VehicleEngineOffRoad,
			engineTurnOff = VehicleEngineOffRoad,
			horn = VehicleHornJeep,
			ignitionFail = VehicleIgnitionFailOffRoad,
		}

		extents = 2.0000 1.3778 6.4444,
		mass = 880,
		physicsChassisShape = 2.0000 1.3778 6.4444,
		centerOfMassOffset = 0.0000 0.8444 0.0000,
		shadowExtents = 2.1542 6.4150,
		shadowOffset = -0.0000 0.0190,
		engineForce = 4200,
		maxSpeed = 85f,
		engineLoudness = 85,
		engineQuality = 76,
		brakingForce = 65,
		stoppingMovementForce = 4.0f,
		rollInfluence = 0.96f,
		steeringIncrement = 0.04,
		steeringClamp = 0.3,
		suspensionStiffness = 37,
		suspensionCompression = 3.84,
		suspensionDamping = 2.84,
		maxSuspensionTravelCm = 14,
		suspensionRestLength = 0.20f,
		wheelFriction = 1.7f,
		frontEndHealth = 650,
		rearEndHealth = 450,
		seats = 4,

		wheel FrontLeft
		{
			front = true,
			offset = 0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel FrontRight
		{
			front = true,
			offset = -0.8333 -0.6000 2.1667,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearLeft
		{
			front = false,
			offset = 0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		wheel RearRight
		{
			front = false,
			offset = -0.8333 -0.6000 -2.0444,
			radius = 0.38f,
			width = 0.25f,
		}

		template = PassengerSeat4,

		passenger FrontLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2444 -0.9111 0.3000,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontLeft,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger FrontRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 0.6111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2556 -0.9111 0.3333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatFrontRight,
			}
			switchSeat RearLeft
			{
			}

			switchSeat RearRight
			{
			}
		}

		passenger RearLeft
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = 0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = 1.2778 -0.9000 -0.5556,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearLeft,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		passenger RearRight
		{
			showPassenger = true,
			hasRoof = true,

			position inside
			{
				offset = -0.5111 0.0333 -0.2111,
				rotate = 0.0000 0.0000 0.0000,
			}

			position outside
			{
				offset = -1.2778 -0.9000 -0.5333,
				rotate = 0.0000 0.0000 0.0000,
				area = SeatRearRight,
			}
			switchSeat FrontLeft
			{
			}

			switchSeat FrontRight
			{
			}
		}

		area Engine
		{
			xywh = 0.0000 3.6111 1.7556 0.7778,
		}

		area TruckBed
		{
			xywh = 0.0000 -3.6111 1.7556 0.7778,
		}

		area Toolbox
		{
			xywh = 0.0000 -0.8667 3.5556 0.9111,
		}

        area Roofrack
		{
			xywh = 0.0000 -1.8889 3.5556 4.2222,
		}

		area SeatFrontLeft
		{
			xywh = 1.3889 1.0444 0.7778 1.1333,
		}

		area SeatFrontRight
		{
			xywh = -1.3889 1.0444 0.7778 1.1333,
		}

		area SeatRearRight
		{
			xywh = -1.3889 0.0333 0.7778 0.8889,
		}

		area SeatRearLeft
		{
			xywh = 1.3889 0.0333 0.7778 0.8889,
		}

		area GasTank
		{
			xywh = 1.6667 -1.0778 0.4222 0.4222,
		}

		area TireFrontLeft
		{
			xywh = 1.6667 2.3000 0.4222 0.4222,
		}

		area TireFrontRight
		{
			xywh = -1.6667 2.3000 0.4222 0.4222,
		}

		area TireRearLeft
		{
			xywh = 1.6667 -1.9111 0.4222 0.4222,
		}

		area TireRearRight
		{
			xywh = -1.6667 -1.9111 0.4222 0.4222,
		}

		template = F3502Seats,
		template = F3502TrunkCompartmentStock,

        part F3502Trunk
		{
			container
			{
				capacity = 115,
			}
		}

		template = F3502TrunkDoor,

		part GloveBox
		{
			area = SeatFrontRight,
			itemType = Base.GloveBox,
			mechanicRequireKey = true,

			model f350Int
			{
				file = 93fordF350Interior,
			}

			model f350lights
			{
				file = 93fordF350Lights,
			}

			model f350barrier
			{
				file = 93fordF350CabBarrier,
			}

            model fx50_int
            {
                file = 93fordFx50Interior,
            }

            model f350_bed
            {
                file = 93fordF350BaseBed,
            }

            model f350longint
            {
                file = 93fordFx50LongbedInterior,
            }

			container
			{
				capacity = 7,
				test = Vehicles.ContainerAccess.GloveBox,
			}

			lua
			{
				create = Vehicles.Create.Default,
			}
		}

		template = GasTank,

		part GasTank
		{
			install
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}

			uninstall
			{
				skills = Mechanics:7,
				recipes = Intermediate Mechanics,
			}
		}

		template = Battery,

		part Battery
		{
			model 3502Bat
			{
				file = 93fordF350TISbattery,
			}
		}

		template = Engine,
		template = Muffler,

		part Muffler
		{
			model 3502Muff
			{
				file = 93fordF350Muff,
			}

			table install
			{
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				recipes = Intermediate Mechanics,
			}
		}

		template = F3502EngineDoor,

		part Heater
		{
			category = engine,

			lua
			{
				update = Vehicles.Update.Heater,
			}
		}

		part PassengerCompartment
		{
			category = nodisplay,

			lua
			{
				update = Vehicles.Update.PassengerCompartment,
			}
		}

		
		template = F3502Doors,
		template = F3502Armor,
		template = F3502Bullbars,
		template = F3502SideSteps,
		template = F3502MudflapsStock,
		template = F3502Roofrack,
		template = F3502TiresStock,
		template = F3502SpareTires,
		template = F3502TruckBedAddonsON,
		template = F3502TruckBedAddons,
        template = F3502TruckBedCover,
		template = F3502Gunrack,
		template = Brake,

		part Brake*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Suspension,

		part Suspension*
		{
			table install
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}

			table uninstall
			{
				skills = Mechanics:6,
				recipes = Intermediate Mechanics,
			}
		}

		template = Radio_HAM,
		template = Headlight,
        template = F3502Windshields,
		template = F3502Windows,
        template = F3502Collision,

		attachment trailer
		{
			offset = 0.0000 -0.3222 -3.5111,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = -1.0000,
		}

		attachment trailerfront
		{
			offset = 0.0000 -0.3222 3.2556,
			rotate = 0.0000 0.0000 0.0000,
			zoffset = 1.0000,
		}
	}]==]},
}
