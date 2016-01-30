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

seriesTestSquare = new Layer
	width: 100, height: 100
	x: 100, y:100
	backgroundColor: 'yellow'
	opacity: .5
	superLayer: scroll.content
seriesSectionTestSquare = new Layer
	width: 100, height: 100
	x: 300, y:100
	backgroundColor: 'blue'
	opacity: .5
	superLayer: scroll.content


navBar = new Layer
	width: 1440, height: 80
	backgroundColor: '“black'
	opacity: .2
navBar.bringToFront

logo = new Layer
	width: 93, height: 33, image: "images/logo.png"
	x: 120, y:24
	
# menuIcon = new Layer
# 	width: 20, height: 20
# 	x: 260, y: 36
# 	backgroundColor: ''
# rectOne = new Layer
# 	width: 16, height: 2
# 	x:0, y:0
# 	backgroundColor: "#fff"
# 	borderRadius: 1
# 	superLayer:menuIcon
# rectTwo = new Layer
# 	width: 16, height: 2
# 	x:0, y:6
# 	backgroundColor: "#fff"
# 	borderRadius: 1
# 	superLayer:menuIcon		
# rectThree = new Layer
# 	width: 16, height: 2
# 	x:0, y:12
# 	backgroundColor: "#fff"
# 	borderRadius: 1
# 	superLayer:menuIcon	
	
wtwText = new Layer
	width: 200, height: 50
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

seriesSectionText = new Layer
	width: 300
	x: 280, y:30
	backgroundColor: ''
	opacity:0
seriesSectionText.html = 'SERIES'	
seriesSectionText.style = "font-size": "16px"	

moviesSectionText = new Layer
	width: 300
	x: 370, y:30
	backgroundColor: ''
	opacity:0
moviesSectionText.html = 'MOVIES'	
moviesSectionText.style = "font-size": "16px"	

sportsSectionText = new Layer
	width: 300
	x: 465, y:30
	backgroundColor: ''
	opacity:0
sportsSectionText.html = 'SPORTS'	
sportsSectionText.style = "font-size": "16px"	

comedySectionText = new Layer
	width: 300
	x: 560, y:30
	backgroundColor: ''
	opacity:0
comedySectionText.html = 'COMEDY'	
comedySectionText.style = "font-size": "16px"	

docsSectionText = new Layer
	width: 300
	x: 660, y:30
	backgroundColor: ''
	opacity:0
docsSectionText.html = 'DOCS'	
docsSectionText.style = "font-size": "16px"	


# Create the button	
button = new Layer
	x: 260, y: 36
	width:30
	height:30
	borderRadius:'0px'
	backgroundColor:''

# Set variables
lineWidth =16
lineHeight = 2
buttonActive = false


# Create hamburger lines
middleLine = new Layer
	width: lineWidth, height: lineHeight, x:2, y:button.height/4 - lineHeight/4, backgroundColor:'#fff', borderRadius:'1px'

topLine = new Layer
	width: lineWidth, height: lineHeight, x:2, y:middleLine.y - 6, backgroundColor:'#fff', borderRadius:'1px'
	
bottomLine = new Layer
	width: lineWidth, height: lineHeight, x:2, y:middleLine.y + 6, backgroundColor:'#fff', borderRadius:'1px'	
	
# Add lines as subLayers of button
button.addSubLayer(topLine)
button.addSubLayer(middleLine)
button.addSubLayer(bottomLine)






# States        
wtwText.states.add
	mainNav: {visible:false}
	seriesView: {visible:false}
	seriesSection: {visible:false}

	
sectionDivider.states.add
	seriesView: {opacity:.4, height: 26}
	
seriesText.states.add
	seriesView: {opacity: 1, x: 295}	

seriesTypeText.states.add
	seriesView: {opacity: 1, x: 406}
		



seriesSectionText.states.add
	mainNav: {opacity: 1, x:300}
	seriesSection: {opacity: 1, x:300} 

	
moviesSectionText.states.add
	mainNav: {opacity: 1, x:390}

sportsSectionText.states.add
	mainNav: {opacity: 1, x:485}

comedySectionText.states.add
	mainNav: {opacity: 1, x:580}

docsSectionText.states.add
	mainNav: {opacity: 1, x:680}


# Animation 
wtwText.states.animationOptions =
    curve: "linear"

seriesText.states.animationOptions =
    curve: "ease", delay:.3

sectionDivider.states.animationOptions =
    curve: "ease", delay:.4

seriesTypeText.states.animationOptions =
    curve: "ease", delay: .5

seriesSectionText.states.animationOptions =
    curve: "ease", delay: .1

moviesSectionText.states.animationOptions =
    curve: "ease", delay: .15

sportsSectionText.states.animationOptions =
    curve: "ease", delay: .2
    
comedySectionText.states.animationOptions =
    curve: "ease", delay: .25

docsSectionText.states.animationOptions =
    curve: "ease", delay: .3


# Open menu function	
open = ->
	buttonActive = true
	button.scale = 0.75
	
	button.animate
		properties:scale:1
		curve: "spring(500, 40, 0)"
		
	middleLine.animate
		properties:opacity:0
		curve:"ease"
		time:0.1
	
	topLine.animate
		properties:y:button.height/4 - lineHeight/4, rotationZ:135
		curve: "spring(500, 40, 0)"
	
	bottomLine.animate
		properties:y:button.height/4 - lineHeight/4, rotationZ:-135
		curve: "spring(500, 40, 0)"
		
# Close menu function		
close = ->
	buttonActive = false
	button.scale = 0.75
	
	button.animate
		properties:scale:1
		curve: "spring(500, 40, 0)"
		
	middleLine.animate
		properties:opacity:1
		curve:"ease"
		time:0.1
	
	topLine.animate
		properties: y:middleLine.y - 6, rotationZ:0
		curve: "spring(500, 40, 0)"
	
	bottomLine.animate
		properties:y:middleLine.y + 6, rotationZ:0
		curve: "spring(500, 40, 0)"



    

# Events 	
seriesTestSquare.on Events.Click, ->
	wtwText.states.next('seriesView', 'default')
	sectionDivider.states.next('seriesView', 'default')
	seriesText.states.next('seriesView', 'default')
	seriesTypeText.states.next('seriesView', 'default')
	
wtwText.on Events.Click, ->
	wtwText.states.next('mainNav', 'default')
	seriesSectionText.states.next('mainNav', 'default')
	moviesSectionText.states.next('mainNav', 'default')
	sportsSectionText.states.next('mainNav', 'default')
	comedySectionText.states.next('mainNav', 'default')
	docsSectionText.states.next('mainNav', 'default')

# wtwText.on Events.MouseOver, ->
# 	wtwText.states.next('mainNav')
# 	seriesSectionText.states.next('mainNav')
# 	moviesSectionText.states.next('mainNav')
# 	sportsSectionText.states.next('mainNav')
# 	comedySectionText.states.next('mainNav')
# 	docsSectionText.states.next('mainNav')
# 
# wtwText.on Events.MouseOut, ->
# 	wtwText.states.next('default')
# 	seriesSectionText.states.next('default')
# 	moviesSectionText.states.next('default')
# 	sportsSectionText.states.next('default')
# 	comedySectionText.states.next('default')
# 	docsSectionText.states.next('default')	

seriesSectionTestSquare.on Events.Click, ->
	wtwText.states.next('seriesSection')
	seriesSectionText.states.next('seriesSection')
	moviesSectionText.states.next('default')
	sportsSectionText.states.next('default')
	comedySectionText.states.next('default')
	docsSectionText.states.next('default')





	
# Conditional for switching between open/close 
button.on Events.Click, ->
	if buttonActive then close() else open()

button.on Events.Click, ->
	wtwText.states.next('mainNav', 'default')
	seriesSectionText.states.next('mainNav', 'default')
	moviesSectionText.states.next('mainNav', 'default')
	sportsSectionText.states.next('mainNav', 'default')
	comedySectionText.states.next('mainNav', 'default')
	docsSectionText.states.next('mainNav', 'default')

wtwText.on Events.Click, ->
	if buttonActive then close() else open()



	


	
