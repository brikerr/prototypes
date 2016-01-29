iot = Framer.Importer.load("imported/framerIoT@1x")

if Utils.isDesktop()
	Framer.DeviceView.Devices["custom"] = "deviceType": "desktop", "screenWidth": 1080, "screenHeight": 1920,
	"deviceImage" : "https://dl.dropboxusercontent.com/u/81188152/Framer/shadow.png",
	"deviceImageWidth": 1280, "deviceImageHeight": 2120; Framer.Device.deviceType = "custom";
	Framer.Device.background.backgroundColor = "#2FA3F1"; Framer.Device.deviceScale = 0.4
	
# Define layers
drawer = iot.drawer
drawer.props =  maxX: 0, opacity: 0, shadowX: 10,shadowY: 20, shadowBlur: 50, shadowColor: "rgba(0,0,0,.3)"
drawer.draggable.props = vertical: false, constraints: {x: -300, width:1200}
drawer.draggable.overdrag = false
menuIcon = new Layer width: 50, clip: false, height: 40, backgroundColor: "", x: 60, y: 140, superLayer: iot.header
line1 = new Layer superLayer: menuIcon, height: 5, backgroundColor: "white", width: 50
line2 = line1.copy()
line2.props = superLayer:menuIcon, y: line1.y + 15
line3 = line1.copy()
line3.props = superLayer: menuIcon, y: line2.y + 15
listScroll = ScrollComponent.wrap(iot.list)
listScroll.props = scrollHorizontal: false, width: 1080, height: 2000, contentInset: top: 240, bottom: -240
menuBg = new Layer width: Screen.width, height: Screen.height, index: 0, backgroundColor: "#101923", opacity: 0, x: 0, y: 0, superLayer: iot.iot
verticalScroll = ScrollComponent.wrap(iot.content)
verticalScroll.props = width: Screen.width, scrollHorizontal: false, contentInset: bottom: 40
horizontalScroll = ScrollComponent.wrap(iot.smallScroll)
horizontalScroll.props = scrollVertical: false, clip: false, contentInset: right: - 460
fab = new Layer height: 130, width: 130, borderRadius: "50%", x: Screen.width - 200, y: Screen.height - 200, backgroundColor: "#F78A55", 
shadowY: 5, shadowColor: "rgba(0,0,0,.5)", shadowBlur: 100, superLayer: iot.iot, index: 1
fabIcon = new Layer superLayer: fab, 
html: '<i class="material-icons" style="font-size: 80px;">add</i>', height: fab.height, 
width: fab.width, backgroundColor: "", x: 25, y: 23
	
# Define variables
smallCards = [iot.cardA, iot.cardB, iot.cardC]
allCards = [iot.cardOne, iot.cardTwo, iot.cardThree, iot.cardFour, horizontalScroll.content]
fullscreen = false

# Define states
fabIcon.states.add hide: {opacity: 0}
drawer.states.add open: {x: 0, opacity: 1}, close: {x: -900, opacity: 0}
drawer.states.animationOptions = curve: "spring(250,35,0)"
menuBg.states.add show: {opacity: .9}, hide: {opacity: 0}
menuBg.states.animationOptions = time: .5
menuIcon.states.add rotate: {rotationZ: 180}
line1.states.add rotate: {width: 30, rotationZ: 45, y: 5, x: 22}
line3.states.add rotate: {width: 30, rotationZ: -45, y: 25, x: 23}

# Animate the cards on page load
for card, i in [iot.cardOne, iot.cardTwo, iot.cardThree, iot.cardFour, horizontalScroll]
	card.x = Screen.width
	card.animate delay: i * .15, curve: "spring(100,15,0)", properties: x: 40

# Function to ensure that layers behind are ignored when interacting with the header
iot.header.on Events.Click, (event) -> event.stopPropagation()

# Function to switch between hover and active state for a layer. Desktop only.
activeHoverState = (layer) ->
	layer.subLayers[1].opacity = 0
	layer.subLayers[0].on Events.MouseOver, -> @siblingLayers[0].animate time: .3, properties: opacity: 1
	layer.subLayers[0].on Events.MouseOut, -> @siblingLayers[0].animate time: .3, properties: opacity: 0
	layer.subLayers[0].on Events.Click, (event) -> waveEffect(event, @siblingLayers[0])

# Function to change state of layer when clicked
activeClickState = (layer) ->
	layer.subLayers[1].states.add show: {opacity: 1}
	layer.subLayers[0].states.add hide: {opacity: 0}
	layer.states.animationOptions = time: .3 for layer in [layer.subLayers[1], layer.subLayers[0]]
	
	layer.on Events.Click, -> 
		@states.next("hide", "default")
		@siblingLayers[0].states.next("show", "default")

# Generate the wave effect when the FAB is clicked
waveEffect = (ev, layer) ->
	if Utils.isDesktop()
		layer.clip = true
		ripple = new Layer borderRadius: "50%", scale: 0, opacity: 1, superLayer: layer, 
		backgroundColor: "white", brightness: 150, midX: ev.offsetX, midY: ev.offsetY, index: layer.index + 1
		rippleAnimation = ripple.animate time: 1, properties: scale: layer.width / 50, clip: true, opacity: 0
		rippleAnimation.on "end", -> ripple.destroy()

# Animate the list when the FAB is clicked
fab.on Events.Click, (event) ->
	fabIcon.states.switch "hide"
	@ignoreEvents = true
	waveEffect(event, @)
	layer.states.next() for layer in [line1, line3, menuIcon]
	event.stopPropagation()
	
	Utils.delay .5, =>
		@animate time: .4, curve: "bezier-curve", properties: midY:Screen.height / 2
		@animate time: .4, properties: midX: Screen.width / 2
		@animate time: .8, delay: .3, curve: "ease", properties: scale: 20
		
		card.animate time: .5, properties: scale: .95, opacity: .5 for card in allCards
		listScroll.animate delay: .5, time: .5, properties: y: 0
		
		for item, i in listScroll.content.subLayers
			item.props = y: Screen.height, scale: .2, rotationX: 180, x: 0
			item.animate curve: "spring(150,25,0)", delay: i * .1 + 1,
			properties: y: i * 335, rotationX: 360, scale: 1, opacity: 1
			
			item.on "end", -> sub.opacity = 1 for sub in @subLayers

# Interaction for the list items
for item, i in listScroll.content.subLayers[0..5]
	item.draggable.vertical = false
	item.draggable.constraints = x: 0, width: 1080
	item.clip = false
	
	greenBg = new Layer width: Screen.width, backgroundColor: "#7ED321", height: item.height, 
	superLayer: item, name: "bgName#{i+1}", maxX: item.x, opacity: 0
	
	redBg = new Layer width: Screen.width, backgroundColor: "#F14051", height: item.height, superLayer: item,
	name: "bgName#{i+1}", x: item.maxX, opacity: 0
	
greenicon = new Layer scale: 0, backgroundColor: "", 
html: '<i class="material-icons" style="font-size: 100px;">add</i>'

redicon = new Layer scale: 0, backgroundColor: "", 
html: '<i class="material-icons" style="font-size: 100px;">close</i>'
	
listScroll.on Events.Scroll, ->	
	if listScroll.direction is "left" or listScroll.direction is "right"
		listScroll.scrollVertical = false
		
		for item in listScroll.content.subLayers[0..5]
			item.on Events.Drag, ->
				if @x >= 100 and @x <= 200
					greenicon.props = y: @screenFrame.y + 120, x: 50, opacity: 1, 
					scale: Utils.round((@x / 100) - 1, 1)
				else if not @x < 100 and @x > 200
					greenicon.scale = 1
				else if @x < 100
					greenicon.scale = 0
				
				if @x <= -100 and @x >= -200
					redicon.props = y: @screenFrame.y + 120, maxX: 1030, opacity: 1, 
					scale: Utils.round((Math.abs(@x) / 100) - 1, 1)
				else if @x < -200
					redicon.scale = 1
				else if @x > -100
					redicon.scale = 0
						
			item.on Events.DragEnd, ->
				greenicon.animate time: .2, properties: scale: 0
				redicon.animate time: .2, properties: scale: 0
				
				if @x < -400 or @x > 400
					direction = if @x < -400 then -Screen.width else Screen.width
					
					cardAnimate = @animate time: .3, properties: x: direction
					cardAnimate.on "end", => @animate time: .2, properties: opacity: 0
						
					for item in listScroll.content.subLayers[0..5]
						greenicon.animate time: .3, properties: scale: 0
						
						if item.index > @index
							item.animate curve: "ease-out", delay: .3, time: .3, properties: y: item.y - item.height
									
				listScroll.scrollVertical = true
				listScroll.scrollToPoint {y: 0 }, true, {curve: "ease"}		
# Drawer interaction
activeHoverState(button) for button in iot.drawer.subLayers

# Animation for opening and closing the drawer 
drawer.on Events.DragEnd, (event) ->
	event.stopPropagation()
	
	if @x < -200
		@states.switch "close"
		thisone = menuBg.states.switch "hide"
		thisone.on Events.AnimationEnd, -> menuBg.index = 0
	else
		@states.switch "open"

# Ensure that the menu background prevents interacting with other layers underneath when active
menuBg.on Events.Click, (event) ->
	event.stopPropagation()
	drawer.states.switch "default"
	menuBgFade = menuBg.states.switch "hide"
	menuBgFade.on Events.AnimationEnd, -> menuBg.index = 0

# When the hamburger icon is selected, depending on its state, it can transform into a back button
menuIcon.on Events.Click, ->
	waveEffect(event, @)
	if @states.current is "default"
		menuBg.index = 3
		menuBg.states.switch "show", time: .3
		drawer.states.switch "open"
	else
		fabIcon.states.switch "default"
		listScroll.animate delay: .5, time: .5, properties: y: Screen.height, scrollY: 0
		layer.states.next() for layer in [line1, line3, menuIcon]
		fabStart = fab.animate time: 1, properties: scale: 1, x: Screen.width - 200, y: Screen.height - 200
		fabStart.on "end", -> fab.ignoreEvents = false
		card.animate delay: .8, time: .5, properties: scale: 1, opacity: 1 for card in allCards

# Display the dropdown list when the overflow icon is selected for each card
for card in allCards[0...4]
	card.props = clip: true, borderRadius: 10
	realTimeIcon = card.subLayers[3]
	realTimeIconActive = realTimeIcon.subLayers[1]
	realTimeIconActive.opacity = 0
	realTimeIconInactive = realTimeIcon.subLayers[0]
	overflowIcon = card.subLayers[2]
	overlayContent = card.subLayers[1]
	
	realTimeIcon.states.add hide: {y: -100}
	realTimeIcon.states.animationOptions = time: .3
	realTimeIconActive.states.add active: {opacity: 1}
	realTimeIconInactive.states.add active: {opacity: 0}
	
	activeClickState(card.subLayers[3])
	
	overlayBg = new Layer superLayer: card, borderRadius: 100, backgroundColor: "#101923", index: 1, 
	scale: 0, opacity: .98, x: overflowIcon.x
	
	overlayContent.props = opacity: 0, y: 0
	overlayContent.states.add show: {opacity: 1, y: 50}
	
	overlayBg.states.add open: {scale: 25, borderRadius: 0}
	overlayBg.states.animationOptions = time: .7
	
	overflowIcon.states.add hide: {y: -100}
	overflowIcon.states.animationOptions = time: .3
	
	overflowIcon.on Events.Click, ->
		@siblingLayers[1].states.animationOptions = delay: .2, time: .5
		layer.states.next() for layer in [@siblingLayers[2], @siblingLayers[1], @siblingLayers[3], @]
		
	for button in card.subLayers[1].subLayers
		activeHoverState(button)
		
		button.on Events.Click, ->
			if @superLayer.siblingLayers[1].states.current is "hide"
				@superLayer.states.animationOptions = delay: 0, time: .2
				for layer in [@superLayer.siblingLayers[2], @superLayer.siblingLayers[1], 
				@superLayer.siblingLayers[3], @superLayer]
					layer.states.next()
			
# Function to animate the charts infinitely using the play toggle button
chartAnimation = (playBtn, levelOne, levelTwo, levelThree) ->
	for chart, i in [levelOne, levelTwo, levelThree]
		animationA = new Animation
			layer: chart, curve: "linear", time: i + 1.5, repeat: "Infinity", properties: x: -1000
		
		if playBtn.superLayer.states.current is "open"
			animationA.start()
		else
			chart.animateStop()
			chart.animate time: .5, properties: x: 0
				
# Interaction for the first two cards
for card in [iot.cardOne, iot.cardTwo, iot.cardThree, iot.cardFour]
	card.states.add open: {scale: 1.1}
	card.states.animationOptions = curve: "spring(200,15,0)"
	
	card.subLayers[3].on Events.Click, ->
		@superLayer.states.next()
		if @superLayer.name is "cardOne" or @superLayer.name is "cardTwo"
			chartAnimation(@, @siblingLayers[0].subLayers[1], @siblingLayers[0].subLayers[2],
			@siblingLayers[0].subLayers[3])
	
# Interaction for the third card
cardThree = do ->
	cardThree = iot.cardThree
	labels = cardThree.subLayers[0].subLayers[1].subLayers
	popups = cardThree.subLayers[0].subLayers[3].subLayers
	pie = cardThree.subLayers[0].subLayers[2]
	activePie = pie.subLayers[2]
	defaultPie = pie.subLayers[1]
	activePie.props = opacity: 0, scale: .5

	for popup in popups
		popup.states.add show: {y: popup.y, opacity: 1}, hide: {y: popup.y + 100, opacity: 0}
		popup.props = y: popup.y + 100, opacity: 0
	
	defaultPie.states.add hide: {opacity: 0, scale: .5}
	activePie.states.add show: {opacity: 1, scale: 1}
	cardThree.subLayers[3].subLayers[1].opacity = 0
	
	cardThree.subLayers[3].on Events.Click, ->
		if @subLayers[0].states.current isnt "default"
			popup.states.switch "show", delay: i * .1, curve: "spring(250,15,0)" for popup, i in popups
			activePie.states.switch "show", curve: "spring(250,15,0)"
			defaultPie.states.switch "hide", time: .3
			
		else
			popup.states.switch "hide", time: .3 for popup, i in popups
			defaultPie.states.switch "default", curve: "spring(250,15,0)"
			activePie.states.switch "default", time: .3

# Interaction for the final card
cardFour = do ->
	hiddenScroll = ScrollComponent.wrap(iot.hidden)
	hiddenScroll.props = superLayer: iot.cardFour, x: 0, y: 0
	chartOne = iot.cardFour.subLayers[0].subLayers[3]
	chartTwo = iot.cardFour.subLayers[0].subLayers[2]
	chartThree = iot.cardFour.subLayers[0].subLayers[1]
	charts = [chartOne, chartTwo, chartThree]
	overflowIcon = iot.cardFour.subLayers[2]
	overlay = iot.cardFour.subLayers[1]
	overflowIcon.bringToFront()
	btn = iot.cardFour.subLayers[3]
	btn.bringToFront()
	overflowIcon.on Events.Click, -> overlay.placeBehind(@)
	overlay.on Events.Click, -> Utils.delay 1, =>  @.sendToBack()
	
	chart.name = i + 1 for chart, i in charts 	
	titles = iot.cardFour.subLayers[0].subLayers[0]
	titlesArray = [titles.subLayers[0], titles.subLayers[1], titles.subLayers[2]]
	title.opacity = 0 for title in titlesArray[0...2]
	
	btn.on Events.Click, ->
		if btn.subLayers[0].states.current isnt "default"
			verticalScroll.scrollVertical = false
			horizontalScroll.scroll = false
			card.ignoreEvents = true for card in smallCards
		else
			verticalScroll.scrollVertical = true
			horizontalScroll.scroll = false
			card.ignoreEvents = false for card in smallCards

	handler = Utils.throttle 1, (flag) ->
		iot.cardFour.subLayers[0].subLayers[4].bringToFront()
		iot.cardFour.subLayers[0].subLayers[0].sendToBack()
		chartOut = if flag then charts[0] else charts[2]
		chartOut.animate time: .3, properties: opacity: 0
		
		for chart, i in charts
			yPos = if flag then chart.y + 100 else chart.y - 100
			animateChart = chart.animate time: .5, properties: y: yPos
	
		title.animate time: .3, properties: opacity: 0 for title in titlesArray

		animateChart.on Events.AnimationEnd, ->
			endChart = if flag then charts.splice(chartOut, 1) else charts.splice(2, 1)
			if flag then charts.push endChart[0] else charts.unshift endChart[0]
			if flag then charts[2].index = endChart[0].index - 3 else charts[0].index = endChart[0].index + 3
			
			newChart = if flag then charts[2] else charts[0]
			newYPos = if flag then 100 else 300
			
			if newChart is charts[0] then newChart.y = 300
			newChart.animate time: .3, properties: opacity: 1, y: newYPos
			
			activeChart = titlesArray[charts[0].name - 1]
			activeChart.animate time: .3, properties: opacity: 1

	hiddenScroll.on Events.ScrollEnd, ->
		if hiddenScroll.direction is "up" then handler(true) else if hiddenScroll.direction is "down" then do handler
		
# Animation for the small cards
for layer, i in smallCards
	layer.props = scale: .5, originX: 0, originY: 0, clip: true, borderRadius: 10
	layer.subLayers[0].opacity = 0
	layer.subLayers[0].states.add show: {opacity: 1}
			
	layer.on Events.Click, ->
		@on Events.AnimationStart, -> @ignoreEvents = true
		@on Events.AnimationEnd, -> @ignoreEvents = false

		layerState = if @subLayers[0].states.current is "default" then "show" else "default"
		@subLayers[0].states.switch layerState, time: .3
		
		if not horizontalScroll.isMoving and not fullscreen
			waveEffect(event, @)
			
			for card in smallCards
				card.animate time: .5, properties: scale: 0 if @ isnt card
				
			iot.cardFour.animate curve: "spring(150,15,0)", properties: y: iot.cardFour.y + 330
			
			@goFull = new Animation 
				layer: @, curve: "spring(150,15,0)",
				properties: x: @x - @screenFrame.x + 40, y: @y, width: 1000, scale: 1
				
			@goFull.start()
			@goSmall = @goFull.reverse()
			@bringToFront()
			fullscreen = true
			horizontalScroll.scrollHorizontal = false
		else if fullscreen
			waveEffect(event, @)
			@goSmall.start()
			fullscreen = false
			horizontalScroll.scrollHorizontal = true
			iot.cardFour.animate curve: "spring(150,15,0)", properties: y: iot.cardFour.y - 330
			
			for card in smallCards
				card.animate curve: "spring(150,15,0)", properties: scale: .5 if @ isnt card