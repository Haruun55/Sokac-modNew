
ConfigL              = {}
ConfigL.DrawDistance = 40.0


ConfigL.Cloakroom = {
			CloakRoom = {
					Pos   = {x = 1377.8543701172, y = -757.53582763672, z = 67.190284729004},
					Size  = {x = 1.0, y = 1.0, z = 1.0},
					Color = {r = 243, g = 154, b = 0},
					Type  = 22,
					Id = 1
				}
}

ConfigL.Uniforms = {
	uniforma = { 
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 0,
			['torso_1'] = 89,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 36,   ['pants_2'] = 0,
			['shoes'] = 35,
			['helmet_1'] = 5,  ['helmet_2'] = 0,
			['glasses_1'] = 19,  ['glasses_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 0,
			['torso_1'] = 0,   ['torso_2'] = 11,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 68,
			['pants_1'] = 30,   ['pants_2'] = 2,
			['shoes'] = 26,
			['helmet_1'] = 19,  ['helmet_2'] = 0,
			['glasses_1'] = 15,  ['glasses_2'] = 0
		}
	}
}

ConfigK = {
    Prices = {
        -- ['item'] = {min, max} --
        ['steel'] = {5, 10},
        ['iron'] = {10, 15},
        ['copper'] = {15, 20},
        ['diamond'] = {20, 25},
        ['emerald'] = {30, 35}
    },
    ChanceToGetItem = 20, -- if math.random(0, 100) <= ChanceToGetItem then give item
    Items = {'steel','steel','steel','steel','iron', 'iron', 'iron', 'copper', 'copper', 'diamond', 'emerald'},
    Sell = vector3(-97.12, -1013.8, 26.3),
    Objects = {
        ['pickaxe'] = 'prop_tool_pickaxe',
    },
    MiningPositions = {
        {coords = vector3(-483.18, 1896.07, 118.77), heading = 14.02},
        {coords = vector3(-489.64, 1893.72, 119.38), heading = 186.41},
        {coords = vector3(-499.37, 1894.79, 119.78), heading = 11.28},
        {coords = vector3(-514.93, 1893.38, 120.96), heading = 141.54},
        {coords = vector3(-523.52, 1898.35, 121.57), heading = 340.37},
        {coords = vector3(-535.47, 1905.64, 122.12), heading = 321.48},
        {coords = vector3(-541.08, 1907.49, 122.36), heading = 61.14},
        {coords = vector3(-544.08, 1899.64, 121.99), heading = 224.09},
        {coords = vector3(-549.85, 1894.07, 121.99), heading = 218.55},
        {coords = vector3(-558.88, 1891.03, 122.1),  heading = 37.57},
        {coords = vector3(-563.2, 1885.71, 122.02),  heading = 198.05},
        {coords = vector3(-533.64, 1928.45, 123.67), heading = 289.39},
        {coords = vector3(-535.59, 1939.01, 124.64), heading = 276.06},
        {coords = vector3(-540.95, 1951.71, 125.28), heading = 100.1},
        {coords = vector3(-540.63, 1965.28, 125.8), heading = 289.4},
        {coords = vector3(-542.6, 1978.87, 126.03), heading = 286.25},
        {coords = vector3(-534.47, 1982.49, 126.02), heading = 341.46},
        {coords = vector3(-527.37, 1978.56, 125.96), heading = 172.43},
        {coords = vector3(-513.09, 1980.18, 125.31), heading = 352.67},
        {coords = vector3(-500.95, 1978.44, 125.0), heading = 216.24},
        {coords = vector3(-495.52, 1983.02, 124.21), heading = 11.63},
        {coords = vector3(-483.34, 1985.06, 123.25), heading = 205.5},
        {coords = vector3(-473.03, 1991.41, 122.71), heading = 19.8},
        {coords = vector3(-465.1, 1993.06, 122.66), heading = 243.93},
        {coords = vector3(-459.23, 2001.82, 122.55), heading = 50.45},
        {coords = vector3(-452.08, 2005.85, 122.62), heading = 237.67},
        {coords = vector3(-444.95, 2012.49, 122.69), heading = 231.78},
        {coords = vector3(-449.94, 2016.6, 122.51), heading = 73.39},
        {coords = vector3(-448.61, 2025.45, 122.64), heading = 295.4},
        {coords = vector3(-452.45, 2030.94, 122.29), heading = 85.04},
        {coords = vector3(-453.61, 2043.15, 121.86), heading = 300.73},
        {coords = vector3(-460.31, 2050.84, 121.39), heading = 118.2},
        {coords = vector3(-451.11, 2054.45, 121.27), heading = 208.93},
        {coords = vector3(-428.16, 2064.83, 119.61), heading = 11.95},
        {coords = vector3(-435.15, 2060.53, 120.37), heading = 177.19},
        {coords = vector3(-465.01, 2059.16, 120.3), heading = 115.08},
        {coords = vector3(-466.84, 2070.84, 119.66), heading = 285.8},
        {coords = vector3(-472.3, 2081.67, 119.2), heading = 91.71},
        {coords = vector3(-545.87, 1990.1, 126.03), heading = 314.93},
        {coords = vector3(-552.62, 1996.15, 126.17), heading = 108.68},
        {coords = vector3(-556.59, 2003.74, 126.15), heading = 111.15},                                                                                                                     
    },
}


Config = {
    JobCenter = vector3(931.89, -2267.38, 30.84),
    ReAdd = 1, -- seconds after a job is finished until its shown again
    Job = {
        ['jobRequired'] = false, -- if true: only players with the specified job can work, false everyone can work
        ['jobName'] = 'trucker',
    },
    Jobs = {
        -- {title = 'title', payment = reward, vehicles = {'truck', 'trailer'}, start = {vector3(x, y, z), heading}, trailer = {vector3(x, y, z), heading}, arrive = vector3(x, y, z)}
        {title = 'Vozite pakete namjestaja do IKEE', payment = 1500, vehicles = {'phantom', 'trailers'}, start = {vector3(954.77, -2188.86, 29.63), 84.99}, trailer = {vector3(946.29, -2111.86, 29.64), 86.76}, arrive = vector3(2671.0, 3530.35, 51.26)},
        {title = 'Vozite meso do super marketa', payment = 1000, vehicles = {'packer', 'trailers2'}, start = {vector3(868.77, -2341.7, 29.44), 174.68}, trailer = {vector3(946.29, -2111.86, 29.64), 86.76}, arrive = vector3(103.57, -1819.37, 25.56)}
    },
}

Prevod = {
    ['not_job'] = "You don't have the trucker job!",
    ['somebody_doing'] = 'Netko vec odradjuje ovu turu, pricekajte!',
    ['menu_title'] = 'Kamiondzija',
    ['e_browse_jobs'] = 'Pritisni ~INPUT_CONTEXT~ da pogledas dostupne ture',
    ['start_job'] = 'Kamiondzija',
    ['truck'] = 'Kamion',
    ['trailer'] = 'Prikolica',
    ['get_to_truck'] = 'Idite do ~y~kamiona~w~!',
    ['get_to_trailer'] = 'Vozite do ~y~prikolice~w~ i zakvacite ju!',
    ['destination'] = 'Destinacija',
    ['get_out'] = 'Izadjite iz ~y~kamiona~w~!',
    ['park'] = 'Parkirajte ~y~prikolicu~w~ kod destinacije.',
    ['park_truck'] = 'Parkirajte ~y~kamion~w~ kod destinacije.',
    ['drive_destination'] = 'Vozite do ~b~destinacije~w~.',
    ['reward'] = 'Posao zavrsen! Dobili ste ~g~$~w~%s',
    ['paid_damages'] = 'Vozite bolje i opreznije sljedeci put! Platili ste ~r~$~w~%s za ostetu!',
    ['drive_back'] = 'Vrati kamion ~y~od ~w~kuda si ga uzeo.', 
    ['detach'] = 'Otkacite prikolicu.'
}