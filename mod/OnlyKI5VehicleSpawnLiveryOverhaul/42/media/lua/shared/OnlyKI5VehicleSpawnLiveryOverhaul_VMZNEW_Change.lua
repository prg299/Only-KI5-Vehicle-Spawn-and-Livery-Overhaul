-- Integrated from Vehicle Military Zones (VMZNEW).
-- Original author: Пупсич; https://steamcommunity.com/sharedfiles/filedetails/?id=3436499337
-- Third-party contribution; excluded from the project MIT license.
local zoneUtils = require("OnlyKI5VehicleSpawnLiveryOverhaul_MilitaryZones")
local activeMods = getActivatedMods()

zoneUtils.change("Muldraugh, KY", {
	["963,11503,0"] = { name = "military_vehicle_light" },
	["969,11515,0"] = { name = "military_vehicle_light" },
	["12539,4208,0"] = { name = "military_vehicle", properties = { Direction = "S" } },
	["12542,4221,0"] = { name = "military_vehicle", properties = { Direction = "N" } },
	["12580,4332,0"] = { name = "military_vehicle_light", width = 3, height = 5, properties = { Direction = "N" } },
	["12495,4257,0"] = { name = "military_container_angled", width = 5, height = 3, properties = { Direction = "E" } },
	["13428,3782,0"] = { name = "military_vehicle", width = 3, height = 5, properties = { Direction = "N" } },
	["14528,3772,0"] = { name = "military_vehicle", width = 3, height = 5, properties = { Direction = "N" } },
})

if activeMods:contains("Louisville_Quarantine_Zone") then
	zoneUtils.change("Louisville_Quarantine_Zone", {
		["13610,4091,0"] = "remove",
		["13610,4097,0"] = { name = "military_vehicle_heavy", properties = { Direction = "S" } },
		["13633,4090,0"] = { name = "military_trailer_light", properties = { Direction = "N", FaceDirection = true } },
		["13636,4080,0"] = { name = "military_vehicle_light", properties = { Direction = "E" } },
		["13642,4080,0"] = { name = "military_vehicle_light", properties = { Direction = "W" } },
	})
end

if activeMods:contains("FoxtrotWarehouse") then
	zoneUtils.change("FoxtrotWarehouse", {
		["10679,13453,0"] = { name = "military_vehicle", x = 10680, y = 13455, width = 3, height = 5, properties = { Direction = "S" } },
		["10683,13453,0"] = { name = "military_vehicle", x = 10684, y = 13455, width = 3, height = 5, properties = { Direction = "S" } },
		["10688,13453,0"] = { name = "military_vehicle", x = 10689, y = 13455, width = 3, height = 5, properties = { Direction = "S" } },
		["10693,13453,0"] = { name = "military_vehicle", x = 10694, y = 13455, width = 3, height = 5, properties = { Direction = "S" } },
		["10699,13453,0"] = { name = "military_vehicle", x = 10699, y = 13455, width = 3, height = 5, properties = { Direction = "S" } },
	})
end

if activeMods:contains("RavenCreekB42") then
	zoneUtils.change("Raven Creek B42", {
		["4235,15441,0"] = { name = "military_vehicle_angled", width = 5, properties = { Direction = "W" } },
		["4247,15449,0"] = { name = "military_vehicle_angled", height = 5, properties = { Direction = "N" } },
		["5946,15360,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "N" } },
		["5078,17016,0"] = { name = "military_vehicle", width = 5, properties = { Direction = "E" } },
		["5078,17012,0"] = { name = "military_vehicle", width = 5, properties = { Direction = "E" } },
		["5074,17006,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5070,17006,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5056,17006,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5060,17006,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5065,17006,0"] = "remove",
		["5078,17026,0"] = { name = "military_vehicle", width = 5, properties = { Direction = "E" } },
		["5078,17022,0"] = { name = "military_vehicle", width = 5, properties = { Direction = "E" } },
		["5068,17026,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5064,17026,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5060,17026,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5056,17026,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5021,17024,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "N" } },
		["5032,17030,0"] = { name = "military_vehicle", height = 5, properties = { Direction = "S" } },
		["5127,17547,0"] = { name = "military_vehicle_heavy", height = 5, properties = { Direction = "N" } },
		["5122,17545,0"] = { name = "military_vehicle_light", height = 5, properties = { Direction = "N" } },
		["5117,17545,0"] = { name = "military_vehicle_light", height = 5, properties = { Direction = "N" } },
		["5112,17550,0"] = { name = "military_trailer_light", width = 5, properties = { Direction = "E", FaceDirection = true } },
		["5112,17554,0"] = { name = "military_trailer_light", width = 5, properties = { Direction = "E", FaceDirection = true } },
	})
end

if activeMods:contains("Secretz42") or activeMods:contains("SZ_Checkpoint5") then
	zoneUtils.change("SZ_Checkpoint5", {
		["10906,11206,0"] = { name = "military_vehicle_angled" },
		["10933,11220,0"] = { name = "military_vehicle_angled" },
		["10979,11213,0"] = { name = "military_vehicle_angled" },
		["11033,11214,0"] = { name = "military_vehicle_light_angled" },
		["11044,11214,0"] = { name = "military_vehicle_light_angled" },
		["11035,11191,0"] = { name = "military_vehicle_angled" },
		["11018,11172,0"] = { name = "military_vehicle_heavy" },
		["11018,11184,0"] = { name = "military_vehicle_heavy" },
	})
end

if activeMods:contains("Secretz42") or activeMods:contains("SZ_Checkpoint8") then
	zoneUtils.change("SZ_Checkpoint8", {
		["6686,11197,0"] = { name = "military_vehicle_light_angled" },
		["6673,11206,0"] = { name = "military_vehicle_angled" },
		["6687,11292,0"] = { name = "military_vehicle_angled" },
		["6700,11207,0"] = { name = "military_vehicle_light_angled" },
		["6717,11281,0"] = { name = "military_vehicle_angled" },
		["6724,11294,0"] = { name = "military_vehicle_angled" },
	})
end

if activeMods:contains("Secretz42") or activeMods:contains("SZ_Muldraugh_Traindepot_EVAC") then
	zoneUtils.change("SZ_Muldraugh_Traindepot_EVAC", {
		["11505,10057,0"] = { name = "military_container_angled" },
		["11525,10057,0"] = { name = "military_vehicle_angled" },
		["11528,10043,0"] = { name = "military_vehicle_angled" },
		["11520,10039,0"] = { name = "military_vehicle_light" },
		["11614,10255,0"] = { name = "military_vehicle_angled" },
	})
end

if activeMods:contains("Secretz42") or activeMods:contains("SZ_North_Checkpoint") then
	zoneUtils.change("SZ_North_Checkpoint", {
		["3767,7036,0"] = { name = "military_vehicle_light_angled" },
		["3768,7054,0"] = { name = "military_vehicle_angled" },
		["3765,7093,0"] = { name = "military_vehicle_light_angled" },
		["3757,7114,0"] = { name = "military_vehicle_light_angled" },
	})
end

if activeMods:contains("Secretz42") or activeMods:contains("SZ_Checkpoint1") then
	zoneUtils.change("SZ_Checkpoint1", {
		["12044,8335,0"] = { name = "military_vehicle_angled" },
		["12149,8335,0"] = { name = "military_vehicle_angled" },
		["12157,8335,0"] = { name = "military_vehicle_angled" },
	})
end

if activeMods:contains("Secretz42") or activeMods:contains("SZ_The_Mall") then
	zoneUtils.change("SZ_The_Mall", {
		["13853,5937,0"] = { name = "military_vehicle_angled" },
		["13879,5918,0"] = { name = "military_vehicle_angled" },
		["13879,5906,0"] = { name = "military_vehicle_angled" },
		["13895,5909,0"] = { name = "military_trailer_heavy_angled" },
		["13932,5931,0"] = { name = "military_trailer_angled" },
		["13853,5842,0"] = { name = "military_vehicle_angled" },
		["13859,5730,0"] = { name = "military_vehicle_angled" },
		["13979,5764,0"] = { name = "military_vehicle_angled" },
		["13989,5750,0"] = { name = "military_vehicle_angled" },
		["14004,5748,0"] = { name = "military_vehicle_angled" },
	})
end

if activeMods:contains("Secretz42") or activeMods:contains("SZ_Checkpoint6") then
	zoneUtils.change("SZ_Checkpoint6", {
		["5775,5772,0"] = { name = "military_vehicle" },
		["5801,5751,0"] = { name = "military_vehicle_angled" },
		["5836,5748,0"] = { name = "military_vehicle_angled" },
		["5766,5725,0"] = { name = "military_vehicle_angled" },
		["5767,5705,0"] = { name = "military_vehicle_angled" },
		["5717,5838,0"] = { name = "military_vehicle_light_angled", x = 5720 },
		["5779,5822,0"] = { name = "military_vehicle_light" },
		["5851,5817,0"] = { name = "military_vehicle_angled" },
		["5857,5817,0"] = { name = "military_vehicle" },
	})
end

if activeMods:contains("Secretz42") or activeMods:contains("SZ_Louisville_Military_Complex") then
	zoneUtils.change("SZ_Louisville_Military_Complex", {
		["14850,2210,0"] = "remove",
		["14851,2234,0"] = "remove",
		["13890,1922,0"] = { name = "military_vehicle_angled" },
		["14154,1908,0"] = { name = "military_vehicle_light_angled" },
		["13864,1941,0"] = { name = "military_vehicle_light_angled" },
		["13863,1890,0"] = { name = "military_vehicle_light" },
		["14073,1994,0"] = { name = "military_vehicle_angled" },
		["14019,1991,0"] = { name = "military_vehicle_heavy_angled" },
		["14005,1884,0"] = { name = "military_vehicle_light_angled" },
		["14231,1937,0"] = { name = "military_vehicle_light_angled" },
		["14260,1902,0"] = { name = "military_vehicle_light_angled" },
		["14266,1856,0"] = { name = "military_vehicle_heavy" },
		["14229,1923,0"] = { name = "military_vehicle_heavy_angled" },
		["14360,1948,0"] = { name = "military_vehicle_angled" },
		["14142,1953,0"] = { name = "military_vehicle_light_angled" },
		["14446,1903,0"] = { name = "military_vehicle" },
		["14429,1946,0"] = { name = "military_container" },
		["14403,1967,0"] = { name = "military_vehicle_angled" },
		["14402,1927,0"] = { name = "military_vehicle" },
		["14819,2233,0"] = { name = "military_vehicle_angled" },
		["14819,2222,0"] = { name = "military_vehicle" },
		["14829,2211,0"] = { name = "military_vehicle_light" },
	})
end

if activeMods:contains("SecretZ_Operations_B42") then
	zoneUtils.change("SecretZ_Operations_B42", {
		["3669,5947,0"] = { name = "military_vehicle_angled" },
		["3668,5957,0"] = { name = "military_vehicle" },
		["3670,5969,0"] = { name = "military_vehicle_angled" },
	})
end

if activeMods:contains("FalconRidgeB42") then
	zoneUtils.change("Falcon Ridge", {
		["11090,14316,0"] = "remove",
		["11086,14318,0"] = "remove",
		["11089,14323,0"] = "remove",
		["11089,14326,0"] = "remove",
		["11085,14325,0"] = { name = "military_burnt" },
		["11086,14315,0"] = { name = "military_vehicle_light_angled" },
		["11123,14323,0"] = { name = "military_vehicle" },
		["11373,14271,0"] = { name = "military_vehicle_light" },
		["11384,14397,0"] = { name = "military_vehicle_light" },
		["11139,14318,0"] = { name = "military_vehicle_angled" },
		["11298,14337,0"] = { name = "military_vehicle" },
		["11423,14318,0"] = { name = "military_vehicle" },
		["11424,14330,0"] = { name = "military_vehicle_angled" },
		["11462,14328,0"] = { name = "military_vehicle_heavy_angled", y = 14332 },
		["11534,14386,0"] = { name = "military_vehicle_heavy_angled" },
		["11595,14386,0"] = { name = "military_vehicle_heavy" },
		["11539,14277,0"] = { name = "military_vehicle_angled" },
		["11660,14390,0"] = { name = "military_vehicle_heavy_angled" },
		["11626,14350,0"] = { name = "military_vehicle_light" },
		["11709,14253,0"] = { name = "military_vehicle" },
		["11828,14397,0"] = { name = "military_vehicle_angled" },
		["11203,14534,0"] = { name = "military_container", height = 17 },
		["11286,14504,0"] = { name = "military_vehicle_heavy_angled" },
		["11281,14546,0"] = { name = "military_vehicle_heavy" },
		["11350,14401,0"] = { name = "military_vehicle_light" },
		["11230,14552,0"] = { name = "military_vehicle_heavy" },
		["11196,14501,0"] = { name = "military_container", height = 21 },
		["11384,14465,0"] = { name = "military_vehicle" },
		["11203,14444,0"] = { name = "military_vehicle_heavy_angled" },
		["11675,14401,0"] = { name = "military_vehicle_angled" },
		["11479,14465,0"] = { name = "military_vehicle_light" },
		["11550,14476,0"] = { name = "military_vehicle_heavy" },
		["11735,14467,0"] = { name = "military_vehicle" },
	})
end

if activeMods:contains("AnruisiTown") then
	zoneUtils.change("AnruisiTown", {
		["12528,11491,0"] = { name = "military_vehicle", width = 5, properties = { Direction = "W" } },
	})
end
	
if activeMods:contains("modid") then
	zoneUtils.change("SafeharborGarrison", {
		["12197,10904,0"] = { name = "military_vehicle", height = 5 },
		["12151,10929,0"] = { name = "military_vehicle_light" },
	})
end