return {
	['bandaza'] = {
		label = 'Zavoji',
		weight = 200,
		stack = true,
		close = true,
		client = {
			event = "esx_extraitems:bandage"
		}
	},

	['repairkit'] = {
		label = 'Repairkit',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			event = "esx_repairkit:onUse"
		}
	},
	['bulletproof'] = {
		label = 'Pancir',
		weight = 1,
		stack = false,
		close = false,
		client = {
			event = "esx_extraitems:bulletproof"
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 1600 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
			usetime = 2500,
		},
	},

	['cola'] = {
		label = 'eCola',
		weight = 350,
		client = {
			status = { water = 1700 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { water = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
		stack = false,
		close = true,
		client = {
			event = 'automafija:kreft'
		}
	},

	['v_lockpick'] = {
		label = 'Vozilo lockpick',
		weight = 400,
		stack = false,
		close = true,
		client = {
			event = 'automafija:obij'
		}
	},

	['snowboard'] = {
		label = 'Snowboard',
		weight = 3400,
		stack = false,
		close = true,
		client = {
			event = 'snowboad_open'
		}
	},

	['a_lockpick'] = {
		label = 'Napredni lockpick',
		weight = 500,
		stack = false,
		close = true,
	},

	['vape'] = {
		label = 'Vape',
		weight = 300,
		stack = false,
		close = true,
		client = {
			usetime = 2500,
			event = "vejp:begin"
		}
	},

	['metal'] = {
		label = 'Metal',
		weight = 100,
		stack = true,
		close = true,
	},
	['bakar'] = {
		label = 'Bakar',
		weight = 100,
		stack = true,
		close = true,
	},
	['barut'] = {
		label = 'Barut',
		weight = 100,
		stack = true,
		close = true,
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			usetime = 0,
			event = 'gcPhone:forceOpenPhone'
		}
	},

	['ugovor'] = {
		label = 'Kupoprodajni ugovor',
		weight = 190,
		stack = false,
		close = true,
		consume = 0,
		client = {
			usetime = 0,
			event = 'ugovor:aui'
		}
	},

	['money'] = {
		label = 'Pare',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, water = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { water = 1400 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true
		}
	},

	
	['tehn'] = {
		label = 'Tehnicki Pregled potvrda',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['workbench'] = {
		label = 'Stol za kreftovanje',
		weight = 20000,
		stack = false,
		close = true,
		client = {
			event = "workbench:spawn",
		}
	},

	['termin'] = {
		label = 'Termin',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['cutted_wood'] = {
		label = 'Rezano drvo',
		weight = 1,
		stack = true,
		close = false,
		consume = 0
	},

	['maderacaoba'] = {
		label = 'Mahagoni daske',
		weight = 1,
		stack = true,
		close = false,
		consume = 0
	},
	
	['list_koke'] = {
		label = 'List Kokaina',
		weight = 19,
		stack = true,
		close = false,
		consume = 0
	},
	['blok_koke'] = {
		label = 'Blok Kokaina',
		weight = 19,
		stack = true,
		close = false,
		consume = 0
	},
	['glukoza'] = {
		label = 'Glukoza',
		weight = 15,
		stack = true,
		close = false,
		consume = 0
	},
	['list_trave'] = {
		label = 'list trave',
		weight = 15,
		stack = true,
		close = false,
		consume = 0
	},
	['list_trave2'] = {
		label = 'list trave2',
		weight = 15,
		stack = true,
		close = false,
		consume = 0
	},
	['rizle'] = {
		label = 'Rizle',
		weight = 50,
		stack = true,
		close = false,
		consume = 0
	},
	['joint'] = {
		label = 'Joint',
		weight = 50,
		stack = true,
		close = false,
		consume = 0
	},
	['kesica'] = {
		label = 'Kesica',
		weight = 1,
		stack = true,
		close = false,
		consume = 0
	},
	['kokain_cisti'] = {
		label = 'Cisti kokain',
		weight = 1,
		stack = true,
		close = false,
		client = {
			usetime = 0,
			event = 'elkoka:Rollanje'
		}
	},

	['kesica'] = {
		label = 'Kesica',
		weight = 1,
		stack = true,
		close = false,
		consume = 0
	},

	['paket_kokaina'] = {
		label = 'Zapakovani kokain',
		weight = 1,
		stack = true,
		close = false,
		client = {
			usetime = 0,
			event = 'kokain:koristi'
		}
	},

	['garett'] = {
		label = 'Garett Turbina',
		weight = 1,
		stack = true,
		close = true,
		description = 'Turbina za sva motorna vozila'
	},
	['dmv'] = {
		label = 'Vozacka',
		weight = 1,
		stack = true,
		close = true,
		description = 'Vozacka dozvola' 
	},
	['susp2'] = {
		label = 'Sportska Suspenzija',
		weight = 1,
		stack = true,
		close = true,
		description = 'Sportska suspenzija za auto'
	},
	['susp'] = {
		label = 'Suspenzija za SUV',
		weight = 1,
		stack = true,
		close = true,
		description = 'Spustena suspenzija za SUV vozila'
	},
	['susp1'] = {
		label = 'Spustena suspenzija za auta',
		weight = 1,
		stack = true,
		close = true,
		description = 'Kratke opruge za auta'
	},
	['susp2'] = {
		label = 'Comfort suspenzija',
		weight = 1,
		stack = true,
		close = true,
		description = 'Malo povećajte visinu suspenzije da biste putnicima pružili više udobnosti i sigurnosti'
	},
	['susp4'] = {
		label = 'Offroad Suspenzija',
		weight = 1,
		stack = true,
		close = true,
		description = 'Drastično povećati visinu suspenzije za vozila koja žele offroad avanturu'
	},
	['bandage'] = {
		label = 'Zavoj',
		weight = 50,
		description = 'Zavoj za manje povrede'
	},

	['medikit'] = {
		label = 'Medikit',
		weight = 50,
		description = 'Prva pomoc'
	},
	['awd'] = {
		label = 'Vuca 4x4',
		weight = 1,
		stack = true,
		close = true,
		description = 'Sportska suspenzija za auto'
	},

	['race_brakes'] = {
		label = 'Keramicne Kocnice',
		weight = 1,
		stack = true,
		close = true,
		description = 'Kocenje 20%+'
	},

	['slick'] = {
		label = 'Drift gume',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['semislick'] = {
		label = 'Sportske gume',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},


	['nitrous'] = {
		label = 'Nitro za auto',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	
	['scanner'] = {
		label = 'Inspekcija za auto',
		weight = 1,
		stack = true,
		close = true,
		description = 'Scanner'
	},

	['rod'] = {
		label = 'Motorni dio',
		weight = 1,
		stack = true,
		close = true,
		description = 'Scanner'
	},

	['oil'] = {
		label = 'Motorno Ulje',
		weight = 1,
		stack = true,
		close = true,
		description = 'Scanner'
	},

	['piston'] = {
		label = 'Piston',
		weight = 1,
		stack = true,
		close = true,
		description = 'Scanner'
	},

	['sacid'] = {
		label = 'sacid',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['ammonia'] = {
		label = 'Amonijak',
		weight = 1,
		stack = true,
		close = true,
		description = 'Koristi se za pranje prozora majmune :P'
	},

	['baterija'] = {
		label = 'Lithium baterija',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['benzin'] = {
		label = 'Benzin',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['meth'] = {
		label = 'meth',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},


	['packagedmeth'] = {
		label = 'packagedmeth',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['sorted_money'] = {
		label = 'Sortirani novac',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},




	['sjeme'] = {
		label = 'Sjemenka trave',
		weight = 1,
		stack = true,
		close = true,
		description = 'Sjemenka trave',
		client = {
			usetime = 0,
			event = 'ele:trava:client:plantNewSeed'
		}
	},
	['ket'] = {
		label = 'Ket',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['hedovi'] = {
		label = 'Hedovi',
		weight = 1,
		stack = true,
		close = true,
		description = 'Marihuana hedovi'
	},

	['djubrivo'] = {
		label = 'Djubrivo',
		weight = 1,
		stack = true,
		close = true,
		description = 'Djubrivo za biljke'
	},

	['voda'] = {
		label = 'Voda',
		weight = 1,
		stack = true,
		close = true,
		description = 'Sterilizovana voda za biljke'
	},
	['saksija'] = {
		label = 'Saksija',
		weight = 1,
		stack = true,
		close = true,
		description = 'Saksija za uzgajanje biljaka'
	},


	['rolex'] = {
		label = 'Rolex',
		weight = 1,
		stack = true,
		close = true,
		description = 'Nakit'
	},
	['nakit'] = {
		label = 'Nakit',
		weight = 1,
		stack = true,
		close = true,
		description = 'Nakit'
	},

	---trava
	['trava'] = {
		label = 'Cannabis',
		weight = 100,
		stack = true,
		close = true,
		description = 'Cannabis',
		client = {
			event = 'elgudra:Rollanje'
		}
	},

	['pakovana_trava'] = {
		label = 'Pakovana Trava',
		weight = 200,
		stack = true,
		close = true,
		description = 'Pakovana trava',
		client = {
			event = 'elgudra:Dzoja'
		}
	},

	['ocb'] = {
		label = 'OCB',
		weight = 100,
		stack = true,
		close = true,
		description = 'OCB pakovanje sa 10 rizla',
		client = {
			event = 'ocb:rizla'
		}
	},

	['ocb_rizla'] = {
		label = 'Rizla',
		weight = 10,
		stack = true,
		close = true,
		description = 'Rizla',
	},

	['joint'] = {
		label = 'Joint',
		weight = 100,
		stack = true,
		close = true,
		description = 'Joint',
		client = {
			event = 'gudrain:koristi'
		}
	},


	['ring'] = {
		label = 'Prsten',
		weight = 1,
		stack = true,
		close = true,
		description = 'Prsten'
	},

	['necklace'] = {
		label = 'Lancic',
		weight = 1,
		stack = true,
		close = true,
		description = 'Lancic'
	},

	['gasmask'] = {
		label = 'Gas maska',
		weight = 1,
		stack = true,
		close = true,
		description = 'Gas maska'
	},

	['cutter'] = {
		label = 'Rezac',
		weight = 1,
		stack = true,
		close = true,
		description = 'Rezac stakla'
	},

	['cutter'] = {
		label = 'Rezac',
		weight = 1,
		stack = true,
		close = true,
		description = 'Rezac stakla'
	},
	['bag'] = {
		label = 'Torba',
		weight = 1,
		stack = true,
		close = true,
		description = 'Torba'
	},
	['zipties'] = {
		label = 'Zipties',
		weight = 1,
		stack = true,
		close = true,
		description = 'Zipties ti sluzi sa vezivanje osobe'
	},

	['radio'] = {
		label = 'Radio',
		weight = 100,
		stack = true,
		close = true,
		description = 'Radio za pricanje sa osobama',
		client = {
			usetime = 0,
			event = "otvori_radio"
		}
	},

	['v10'] = {
		label = 'V10 Motor',
		weight = 1,
		stack = true,
		close = true,
		description = 'V10 motor'
	},

	['campfire'] = {
		label = 'Logorska vatra',
		weight = 1,
		stack = true,
		close = true,
		description = 'Vatra'
	},

	['ranac'] = {
		label = 'ranac',
		weight = 800,
		stack = false,
		close = true,
		description = 'Ranac sa osnovnim stvarima za tvoj pocetak !',
		client = {
			usetime = 0,
			event = 'itemi:ranac'
		}
	},
	['happy'] = {
		label = 'Happy meal',
		weight = 200,
		stack = false,
		close = true,
		description = 'Happy Meal !',
		client = {
			usetime = 0,
			event = 'itemi:happy'
		}
	},
	['fries'] = {
		label = 'pomfrit',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 1200 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_food_bs_chips', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},
	['nuggets'] = {
		label = 'Nuggets',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 1200 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_food_cb_nugets', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},

	['bonnet'] = {
		label = 'HOOD',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['plastika'] = {
		label = 'Plastika',
		weight = 400,
		stack = true,
		close = true,
		description = ''
	},

	['najlon'] = {
		label = 'Najlon',
		weight = 300,
		stack = true,
		close = true,
		description = ''
	},

	['thermite'] = {
		label = 'Termalni naboj',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['laptop_h'] = {
		label = 'Hakerski Laptop',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['hakerusb'] = {
		label = 'Hakerski USB',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['drill'] = {
		label = 'Drill',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},


	['brake'] = {
		label = 'BRAKE',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['door'] = {
		label = 'DOOR',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['lap'] = {
		label = 'Laptop za auto',
		weight = 1,
		stack = true,
		close = true,
		description = 'Laptop za inspekciju vozila',
		client = {
			event = 'advanced_vehicles:showStatusUI'
		}
	},


	

	['engine'] = {
		label = 'ENGINE',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['auto1'] = {
		label = 'Nueva poklon',
		weight = 10000,
		stack = false,
		close = true,
		description = 'Iz ovog poklona mozes dobiti auto',
		client = {
			event = 'daj:poklon'
		}
	},

	['exhaust'] = {
		label = 'EXHAUST',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint'] = {
		label = 'PAINT',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_black'] = {
		label = 'PAINT BLACK',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_blue'] = {
		label = 'PAINT BLUE',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_brown'] = {
		label = 'PAINT BROWN',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_green'] = {
		label = 'PAINT GREEN',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_grey'] = {
		label = 'PAINT GREY',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_orange'] = {
		label = 'PAINT ORANGE',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_pink'] = {
		label = 'PAINT PINK',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_purple'] = {
		label = 'PAINT PURPLE',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_red'] = {
		label = 'PAINT RED',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_white'] = {
		label = 'PAINT WHITE',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['paint_yellow'] = {
		label = 'PAINT YELLOW',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['seat'] = {
		label = 'SEAT',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['transmition'] = {
		label = 'TRANSMISSION',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['trunk'] = {
		label = 'TRUNK',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['vehicle_blueprints'] = {
		label = 'Vehicle_blueprints',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['vehicle_shell'] = {
		label = 'Vehicle_shell',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['wheel'] = {
		label = 'WHEEL',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},


	['fuel10'] = {
		label = 'Kanister 10L',
		weight = 1,
		stack = true,
		close = true,
		description = 'Kanister sa 10l benzina'
	},

	['fuel30'] = {
		label = 'Kanister 30L',
		weight = 1,
		stack = true,
		close = true,
		description = 'Kanister sa 30l benzina'
	},

	['fuel50'] = {
		label = 'Kanister 50L',
		weight = 1,
		stack = true,
		close = true,
		description = 'Kanister sa 50l benzina'
	},

	---hranaa

	['sendvic'] = {
		label = 'Sendvic',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 1500 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_sandwich_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},

	['hotdog'] = {
		label = 'Hot Dog',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 1200 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_cs_hotdog_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},


	['cheeseburger'] = {
		label = 'Cheeseburger',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 1500 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},


	['pizza'] = {
		label = 'Pizza',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 1200 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},


	['fanta'] = {
		label = 'Fanta',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { water = 2000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_orang_can_01', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
		}
	},

	['sprite'] = {
		label = 'Sprite',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { water = 2000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'v_res_tt_can03', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
		}
	},


--[[ 	['redbull'] = {
		label = 'Red Bull',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = {},
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'v_res_tt_can01', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
		}
	},
 ]]
	['piva'] = {
		label = 'Piva',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { water = 1500 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_amb_beer_bottle', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
		}
	},


	['bijelovino'] = {
		label = 'Bijelo Vino',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { water = 1500 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_drink_whtwine', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
		}
	},

	['crnovino'] = {
		label = 'Crno Vino',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { water = 1500 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_drink_redwine', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
		}
	},


	['milka'] = {
		label = 'Milka',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 900 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_choc_meto', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},

	['snickers'] = {
		label = 'Snickers',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 900 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_choc_meto', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},

	['twix'] = {
		label = 'Twix',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 900 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_choc_ego', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},

	['bounty'] = {
		label = 'bounty',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 900 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_choc_meto', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,

		}
	},


	['krofna'] = {
		label = 'Krofna',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 5000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'v_res_tt_doughnut01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},

	['cigare'] = {
		label = 'Cigare',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 500 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'ng_proc_cigarette01a', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},

	['hljeb'] = {
		label = 'Hljeb',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 1200 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'v_res_fa_bread03', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
		}
	},

	['kafa'] = {
		label = 'Kafa',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { stress = -2 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_fib_coffee', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
		}
	},
	['redbull'] = {
		label = 'Red Bull',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { stress = -2  },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'v_res_tt_can01', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
		}
	},


	['viski'] = {
		label = 'Viski',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { water = 1500 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_drink_whisky', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,

		}
	},

	['tequila'] = {
		label = 'Tequila',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { water = 1500 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_tequila', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,

		}
	},

	['sampanjac'] = {
		label = 'Sampanjac',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { water = 1500 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_drink_champ', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,

		}
	},
}