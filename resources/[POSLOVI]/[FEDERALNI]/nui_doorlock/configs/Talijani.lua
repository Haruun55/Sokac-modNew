

-- garaza
table.insert(Config.DoorList, {
	lockpick = false,
	objHeading = 36.91187286377,
	locked = true,
	objHash = -1140189596,
	objCoords = vector3(354.3578, 18.63982, 85.55156),
	fixText = false,
	authorizedJobs = { ['talijani']=0 },
	audioRemote = false,
	slides = true,
	maxDistance = 6.0,
	garage = true,			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- glulaz
table.insert(Config.DoorList, {
	lockpick = false,
	doors = {
		{objHash = 607720026, objHeading = 59.99998474121, objCoords = vector3(391.3176, 1.966624, 92.41474)},
		{objHash = 607720026, objHeading = 240.0, objCoords = vector3(390.1236, -0.1210894, 92.41474)}
 },
	authorizedJobs = { ['talijani']=0 },
	audioRemote = false,
	slides = false,
	maxDistance = 2.5,
	locked = true,			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})