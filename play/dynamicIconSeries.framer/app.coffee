curvemove = 'cubic-bezier(0.4, 0, 0.2, 1)'
curvein = 'cubic-bezier(0, 0, 0.2, 1)'
curveout = 'cubic-bezier(0.4, 0, 1, 1)'
popin = 'spring(200,15,0)'
transition = 'ease'

bg = new BackgroundLayer
    backgroundColor: "#fff"

container = new Layer width:600, height:400, backgroundColor:'',
rotation:180,				
shadowColor:'rgba(0,0,0,0.2)'
	
container.x = 140
container.y = 240
	
circle = new Layer backgroundColor: "#85FF00",borderRadius:'50%',midX:container.width/2, superLayer:container

burgerClose = new Layer
	width:60, height: 60 
	backgroundColor: '#fff'
	x:80, y:180
	opacity: 0
	scale:.23
	borderRadius: 30
	superLayer: container
burgerCloseRectOne = new Layer
	width:20, height:2
	backgroundColor:"#fff"
	opacity: 0
	x:100, y:202
	borderRadius: 1
	superLayer: container
burgerCloseRectTwo = new Layer
	width:20, height:2
	backgroundColor:"#fff"
	opacity: 0
	x:100, y:210
	borderRadius: 1
	superLayer: container	
burgerCloseRectThree = new Layer
	width:20, height:2
	backgroundColor:"#fff"
	opacity: 0
	x:100, y:218
	borderRadius: 1
	superLayer: container	
	
burgerBack = new Layer
	width:60, height: 60 
	backgroundColor: '#fff'
	x:460, y:180
	opacity: 0
	scale:.2
	borderRadius: 30
	superLayer: container
closePlusOne = new Layer
	width:20, height:2
	x:285, y:210
	backgroundColor:"#fff"
	opacity: 0
	scale:1	
	borderRadius: 1
	superLayer: container
closePlusTwo = new Layer
	width:20, height:2
	x:285, y:210
	rotation: 90
	backgroundColor:"#fff"
	opacity: 0
	scale:1
	borderRadius: 1
	superLayer: container





	
playPause = new Layer
	width:60, height: 60 
	backgroundColor: '#fff'
	x:265, y:180
	opacity: 0
	scale:.2
	borderRadius: 30
	superLayer: container	
squareCheckOne = new Layer
	width: 18, height: 2
	x:480, y:217
	scale:.9
	opacity: 0
	backgroundColor: "#fff"
	borderRadius: 1
	superLayer: container
squareCheckTwo = new Layer
	width: 18, height: 2
	x:488, y:209
	scale:.9
	opacity: 0
	rotation: 90
	backgroundColor: "#fff"
	borderRadius: 1
	superLayer: container
squareCheckThree = new Layer
	width: 18, height: 2
	x:472, y:209
	scale:.9
	opacity: 0
	rotation: 90
	backgroundColor: "#fff"
	borderRadius: 1
	superLayer: container
squareCheckFour = new Layer
	width: 18, height: 2
	x:480, y:200
	scale:.9
	opacity: 0
	backgroundColor: "#fff"
	borderRadius: 1
	superLayer: container

init = () ->
	
	circle.animate
    properties:
        backgroundColor: "#F100B5"
    time: 2
   
	
	container.animate
		properties:
			rotation:0
			midX:Screen.width/2
			midY:Screen.height/2
			opacity:1
		curve:curvein
		time:0.4
	
	godown = circle.animate
			properties:
				y:container.height/2
				scale:0.1
			curve:curvein
			time:0.6
					
		godown.on "end",->
			expand()
				
expand = () ->
	
	ready = circle.animate
		properties:
			scale:0.8		
		curve:curvemove
		time:0.6
		
	ready.on "end",->
		circle.animate
			properties:
				scale:10
			curve:curvemove
			time:0.6

	ready.on "end",->
		goback()
	
goback = () ->
			 		 						
	container.animate
		delay:0.3
		properties:
			height:400
		curve:curvemove
		time:0.3
	
	gravity = container.animate
		delay:0.3
		properties:
			shadowY:0
			shadowBlur:0
		curve:curvemove
		time:0.3
		
	circle.animate
	    properties:
	        backgroundColor: "#11132D"
	    time: 7
		
	gravity.on "end",->
		elements()

elements = () ->
	
	appearOne = burgerClose.animate
		properties:
			opacity: .1
			x:80 
			scale: 1.5
		curve:popin
		time:0.3
	
	burgerCloseRectOne.animate
		properties: 
			opacity:1
			scale: 1.1
		curve:popin
		time:0.32
	burgerCloseRectTwo.animate
		properties: 
			opacity:1
			scale: 1.1
		curve:popin
		time:0.36
	burgerCloseRectThree.animate
		properties: 
			opacity:1
			scale: 1.1
		curve:popin
		time:0.40
	appearTwo = burgerBack.animate
		properties:
			opacity: .1
			x:460 
			scale: 1.5
		curve:popin
		delay: .15
		time:0.3		
	appearThree = playPause.animate
		properties:
			opacity: .1
			x:265 
			scale: 1.5
		curve:popin
		delay: .25
		time:0.3

	
	changeBurgerTwo = burgerCloseRectTwo.animate
		properties: 
			rotation:180
			x: 103, y:210, width: 19
			backgroundColor: "cyan"
		curve:transition
		delay: 1
		time:0.70
	changeBurgerOne = burgerCloseRectThree.animate
		properties: 
			rotation:135
			x:99, y:206
			width: 12
			backgroundColor: "tan"
		curve:transition
		delay: 1
		time:0.80
	changeBurgerThree = burgerCloseRectOne.animate
		properties: 
			rotation:45
			x:99, y:214
			width: 12
			backgroundColor: "red"
		curve:transition
		delay: 1
		time:0.70	
	
	closePlusOne.animate
		properties: 
			opacity: 1
			scale: 1.1
		curve:popin
		delay: .5
		time:.4
	closePlusTwo.animate
		properties: 
			opacity: 1
			scale: 1.1
		curve:popin
		delay: .5
		time:.4
		
	squareCheckOne.animate
		properties:
			opacity:1
			scale: 1
		curve:popin
		delay: .5
		time:0.5
	squareCheckTwo.animate
		properties: 
			opacity: 1
			scale: 1
		curve:popin
		delay: .5
		time:0.52
	squareCheckThree.animate
		properties: 
			opacity: 1
			scale: 1
		curve:popin
		delay: .5
		time:0.54
	squareCheckFour.animate
		properties: 
			opacity: 1
			scale: 1
		curve:popin
		delay: .5
		time:0.56

	closePlusOne.animate
		properties: 
			rotation: 135
			backgroundColor: "lime"
		curve:transition
		delay: 1.2
	closePlusTwo.animate
		properties: 
			rotation: 225
			backgroundColor: "yellow"
		curve:transition
		delay: 1.3
	
	squareCheckTwo.animate
		properties: 
			rotation: 125
			x:484, y:210
			backgroundColor: "#7FFFD4"
		curve:transition
		delay:1.8
	squareCheckOne.animate
		properties: 
			rotation: 45
			width:11, y:213, x:479
			backgroundColor: "tan"
		curve:transition
		delay:1.8
	squareCheckThree.animate
		properties:	
			width:0
			rotation: -290
			x:475, y:212
			backgroundColor: "tan"
		curve:transition
		delay:1.7	
	squareCheckFour.animate
		properties:	
			x:485, y:205
			width:0
			opacity: 0
			rotation: -90	
		curve:transition
		delay:1.7
		
	
squareCheckFour.on "end",->
		Utils.delay 5, -> end()

end = () ->	

	disappearOne = burgerClose.animate
		properties:
			opacity: 0
			x:80 
			scale: .5
		curve:popin
		time:0.3
	burgerCloseRectOne.animate
		properties: 
			opacity:0
			scale: 1
		curve:popin
		time:0.32

	disappearTwo = burgerBack.animate
		properties:
			opacity: 0
			x:460 
			scale: .5
		curve:popin
		delay: .15
		time:0.3
	burgerCloseRectTwo.animate
		properties: 
			opacity:0
			scale: 1
		curve:popin
		time:0.36
	
	closePlusOne.animate
		properties: 
			opacity: 0
		curve:popin
		time:0.5
	
	closePlusTwo.animate
		properties: 
			opacity: 0
		curve:popin
		time:0.5
		
	disappearThree = playPause.animate
		properties:
			opacity: 0
			x:265 
			scale: .5
		curve:popin
		delay: .25
		time:0.3	
	burgerCloseRectThree.animate
		properties: 
			opacity:0
			scale: 1
		curve:popin
		time:0.36


	squareCheckOne.animate
		properties:	
			opacity:0
		curve:popin
		time:0.4
	squareCheckTwo.animate
		properties:	
			opacity:0
		curve:popin
		time:0.4
	squareCheckThree.animate
		properties:	
			opacity:0
		curve:popin
		time:0.4
	squareCheckFour.animate
		properties:	
			opacity:0
		curve:popin
		time:0.4
		

	circle.animate
		properties:
			scale:0.3
		curve:curvemove
		time:0.7
		delay:.3
	
	fade = container.animate
			delay:0.7
			properties:
				y:240
				x:140
				rotation:180
				opacity:0
			curve:curveout
			time:0.3
			delay:.4
					
	fade.on 'end',->
		Utils.delay 1, -> init()
		
init()

