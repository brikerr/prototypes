scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false
	contentInset: {bottom: -800}



cards = []
opened = false
closing = false

for i in [0..20]
	card = new Layer
		width: Screen.width - 40
		height: Screen.height - 200
		backgroundColor: Utils.randomColor()
		borderRadius: 16
		y: i * 100 + 20
		x: 20
		superLayer: scroll.content
		name: i
			
	card.on Events.TouchEnd, ->
		return if scroll.isMoving
		
		if not opened 
			scroll.scrollVertical = false
			
			for i in [0..cards.length - 1]
				if i isnt @name
					cards[i].animate
						properties:
							y: scroll.scrollY + Screen.height - 100 + i * 20
							scale: .98 + i * .01
						curve: "spring(450, 40, 0)"
						delay: .01 * i
				
			@animate
				properties:
					y: scroll.scrollY + 20
					scale: 1
				curve: "spring(250, 30, 0)"
				delay: .1
			
			@draggable.enabled = true
			@draggable.vertical = true
			@draggable.horizontal = false
			@draggable.constraints =
				y: scroll.scrollY + 20, x: 0
				width: Screen.width, height: card.height
					
			if @name is 4 then pagecardAnimation()
			opened = true
			closing = false
		
		if closing
			for i in [0..cards.length - 1]
				cards[i].draggable.vertical = false
				cards[i].draggable.enabled = false
				num = parseInt @name
				
				if i is num
					cards[i].animate
						properties:
							y: i * 100 + 20
							scale: 1
						curve: "spring(450, 40, 0)"
						delay: 0.01
				
				if i isnt num
					cards[i].animate
						properties:
							y: i * 100 + 20
							scale: 1
						curve: "spring(450, 40, 0)"
						delay: .03 * i

			
			scroll.scrollVertical = true
			opened = false
		
	card.on "change:y", ->
		if opened and @draggable.direction is "down" and
		@y > scroll.scrollY + 200
			closing = true
		
	cards.push card



scroll.bringToFront()
	
pagecard = new PageComponent
	size: card.size
	superLayer: cards[4]
	clip: false

pagecard.content.perspective = 4000
	
pages = []
for i in [0..2]
	page = new Layer
		size: card.size
		x: i * (card.width + 20)
		backgroundColor: cards[4].backgroundColor.lighten(i * 5)
		borderRadius: 20
		superLayer: pagecard.content
	
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
				x: (pages.length - i - 1) * (card.width + 20)
				y: 0
			time: .4
			delay: .7
			
pagecardClosing = ->
	print 1
