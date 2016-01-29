

images = [
	"0.png", 
	"1.png",
	"2.png",
	"3.png",
	"4-1.png",
	"5.png",
	"6.png",
	"7.png",
	"8.png",
	"9.png",
	"10.png",
	"11.png",
]

master = [
	"4-1.png",
	"4-2.png",
	"4-3.png",
	"4-4.png"
]

for i in [0..images.length - 1]
	new Layer image: images[i], x: -200, y: -200
for i in [0..master.length - 1]
	new Layer image: master[i], x: -200, y: -200
	
new Layer size: Screen.size, image: "images/back.png"
header = new Layer width: 750, height: 128, image: "images/header.png"

scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height - 40
	y: 40
	clip: false
	scrollHorizontal: false
	contentInset: {bottom: -800}

cards = []
opened = false
closing = false

for i in [0..20]
	card = new Layer
		width: Screen.width
		height: 1100
		backgroundColor: "transparent"
		borderRadius: 20
		y: i * 110 + 104
		superLayer: scroll.content
		name: i
		
		#shadowY: -2, shadowBlur: 40, shadowColor: "rgba(0, 0, 0, .1)"
	
	if i in [1, 4, 7, 11, 15, 19]
		card.borderRadius = 0
			
	card.on Events.TouchEnd, ->
		return if scroll.isMoving
		num = parseInt @name
		
		if not opened 
			scroll.scrollVertical = false
			header.animate properties: {opacity: 0}, time: .6
			
			for i in [0..cards.length - 1]
				if i isnt num
					cards[i].animate
						properties:
							y: scroll.scrollY + Screen.height - 130 + i * 15
							scale: .93 + i * .01
						curve: "spring(450, 40, 0)"
						delay: .02 * i
				
			cards[num].animate
				properties:
					y: scroll.scrollY + 94
					#scale: .88
				curve: "spring(150, 20, 0)"
				delay: .1
			
			Utils.delay .01, -> 
				cards[num].draggable.enabled = true
				cards[num].draggable.vertical = true
				cards[num].draggable.horizontal = false
				cards[num].draggable.constraints =
					y: scroll.scrollY + 94, x: 0
					width: Screen.width, height: card.height
					
			if num is 4 then pagecardAnimation()
			opened = true
			closing = false
		
		if closing
			for i in [0..pages.length - 1]
				pages[i].animate
					properties:
						rotationY: 0
					time: .1
						
			for i in [0..cards.length - 1]
				cards[i].draggable.vertical = false
				cards[i].draggable.enabled = false
				
				if i is num
					cards[i].animate
						properties:
							y: i * 110 + 104
							scale: 1
						curve: "spring(450, 40, 0)"
						delay: 0.01
				
				if i isnt num
					theY = i * 110 + 104
					if theY < scroll.scrollY then theY = scroll.scrollY
					cards[i].animate
						properties:
							y: theY
							scale: 1
						curve: "spring(450, 40, 0)"
						delay: .01 * i

			if num is 4 then pagecardClosing()
			
			scroll.scrollVertical = true
			header.animate properties: {opacity: 1}, time: .6
			opened = false
		
	card.on "change:y", ->
		if opened and @draggable.direction is "down" and
		@y > scroll.scrollY + 128
			closing = true
		
	cards.push card



scroll.bringToFront()

scroll.content.on "change:y", ->
	if not opened
		for i in [0..cards.length - 1]
			if scroll.scrollY - i * 110 - 104 > 0
				cards[i].y = scroll.scrollY
			else if scroll.scrollY < 0 
				cards[i].y = i * 110 + 104 + 
				scroll.content.y * i / 10 - scroll.content.y * .97
			else
				cards[i].y = i * 110 + 104 


	
pagecard = new PageComponent
	size: card.size
	superLayer: cards[4]
	clip: false
	scrollVertical: false

pagecard.content.perspective = 4000
pages = []
ind = 20

color = new Color "tomato"

for i in [0..2]
	page = new Layer
		size: card.size
		x: i * (card.width + ind)
		backgroundColor: color.lighten(i * 5)
		superLayer: pagecard.content
		borderRadius: 10
		name: i + 1
	
	page.props =
		y: i * 16
		x: 0
	page.states.add
		flipped: {rotationY: 180}
		first: {rotationY: 0}
		
	page.states.animationOptions =
		curve: "spring(50, 9, 0)"
		
	page.on Events.TouchEnd, ->
		return if not pagecard.isMoving
			if opened	
				if @states.current is "flipped" then @states.switch "first"
				else @states.switch "flipped" 
	
	page.on "change:rotationY", ->
		if @rotationY > 90
			@image = "4-4.png"
		else
			@image = "4-#{parseInt @name}.png"
	
	pages.push page

cards[4].props = 
	backgroundColor: "transparent"
	borderRadius: 0
	clip: false


pagecardAnimation = ->
	for i in [0..pages.length - 1]
		if not opened then pages[i].y = i * 110
					
		pages[i].animate
			properties:
				x: (pages.length - i - 1) * (card.width + ind)
				y: 0
			time: .4
			delay: .7
			
pagecardClosing = ->
	pagecard.content.x = 0
	
	for i in [0..pages.length - 1]
		pages[i].x = 0
		pages[i].animate
			properties:
				y: 16 * i
			time: .4
			delay: .4 * i

status = new Layer width: 750, height: 40, image: "images/status.png"



for i in [0..20]
	if i isnt 4 then new Layer
		size: card.size
		image: images[i % images.length]
		superLayer: cards[i]
	else
		for j in [0..2]
			pages[j].image = master[j]