bg = new BackgroundLayer 
  backgroundColor: "black"
  
# Create ScrollComponent
scroll = new ScrollComponent
	width: 1440
	height: 1000
	scrollHorizontal: false
	backgroundColor: ""
	contentInset:
		top: 130
		bottom: 10
	borderRadius: 0
scroll.center()

content = new Layer
	width: 1440, height: 3000
	x: 0, y: 0
	backgroundColor: "#1C1C1C"
	superLayer: scroll.content
	borderRadius: 0
content.center()

navBar = new Layer
	width: 1440, height: 80
	backgroundColor: '“black'
	opacity: .2
navBar.bringToFront

logo = new Layer
	width: 93, height: 33, image: "images/logo.png"
	x: 120, y:24
	
menuIcon = new Layer
	width: 20, height: 20
	x: 260, y: 36
	backgroundColor: ''
rectOne = new Layer
	width: 16, height: 2
	x:0, y:0
	backgroundColor: "#fff"
	borderRadius: 1
	superLayer:menuIcon
rectTwo = new Layer
	width: 16, height: 2
	x:0, y:6
	backgroundColor: "#fff"
	borderRadius: 1
	superLayer:menuIcon		
rectThree = new Layer
	width: 16, height: 2
	x:0, y:12
	backgroundColor: "#fff"
	borderRadius: 1
	superLayer:menuIcon	
	
wtwText = new Layer
	width: 300
	x: 295, y:30
	backgroundColor: ''
wtwText.html = 'WHAT TO WATCH'	
wtwText.style = "font-size": "16px"
 
getShowtimeText = new Layer
	width: 300
	x: 1060, y:30
	backgroundColor: ''
getShowtimeText.html = 'GET SHOWTIME'	
getShowtimeText.style = "font-size": "16px","color":"#CB292E"
  	
calIcon = new Layer
	width: 26, height: 26
	image: "images/calendarIcon.png"
	x:1230, y:28
	
searchIcon = new Layer
	width: 26, height: 28
	image: "images/searchIcon.png"
	x:1300, y:28

seriesText = new Layer
	width: 300
	x: 280, y:30
	backgroundColor: ''
	opacity:0
seriesText.html = 'SERIES'	
seriesText.style = "font-size": "16px"	
	      
sectionDivider = new Layer
	width: 1, height: 2
	x: 380, y:30
	backgroundColor: '#fff'
	opacity: 0

seriesTypeText = new Layer
	width: 300
	x: 370, y:30
	backgroundColor: ''
	opacity:0
seriesTypeText.html = 'HOMELAND'	
seriesTypeText.style = "font-size": "16px"	

sectionDividerTwo = new Layer
	width: 1, height: 26
	x: 1206, y:30
	backgroundColor: '#fff'
	opacity: .4

sectionDividerThree = new Layer
	width: 1, height: 26
	x: 1280, y:30
	backgroundColor: '#fff'
	opacity: .4

# States        
wtwText.states.add
	goToSeries:
		opacity:0
	
content.on Events.Click, ->
	wtwText.states.next()
	
	seriesText.animate
		properties: 
			opacity: 1 
			x:295
		delay: .3
	sectionDivider.animate
		properties: 
			height: 26
			opacity: .4 
		delay: .4
	seriesTypeText.animate
		properties: 
			x:406
			opacity: 1
		curve: "ease"
		delay: .6

	



