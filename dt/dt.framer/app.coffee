

# Set background
bg = new BackgroundLayer backgroundColor: "#000"
bg.bringToFront()



# Create ScrollComponent
scroll = new ScrollComponent
	width: 1440
	height: 900
	contentInset: 0
	top: 0
	bottom: 6
	backgroundColor: "#000"
		

# Import file "discoverTogetherV1"
sketch = Framer.Importer.load("imported/discoverTogetherV1@1x")
		
Utils.globalLayers(sketch)
button.opacity = 0
startText.opacity = 0
bkgndShape.opacity = 0
bkgndShape.scale = .5
whiteDotImage.opacity = 0
avatars.opacity = 0
avatars.scale = .8
avatarOne.scale = .5
avatarTwo.scale = .5
avatarThree.scale = .5
avatarFour.scale = .5
bottomText.opacity = 0

# btnFillOne = new Layer
# 	x:200, y: 200
# 	width: 300, height: 120
# 	borderRadius: 60
# 	backgroundColor: 'red'


		
		
# ScrollComponent
scroll.center()			
scroll = ScrollComponent.wrap(sketch.content)
scroll.scrollHorizontal = false


# scroll.on Events.Scroll, ->		
# 	if scroll.scrollY > 350
# 		scroll.on Events.Move, ->
# 			button.y = Utils.modulate(scroll.scrollY, [20, 1138], [1118, 1200], true)


# 			button.opacity = Utils.modulate(scroll.scrollY, [0, 1000], [0, 1], false)

# 			buttonFillTwo.y = Utils.modulate(scroll.scrollY, [1000, 0], [-35, 0], true)
# 			buttonFillThree.y = Utils.modulate(scroll.scrollY, [1000, 0], [-55, 0], true)
	
# scroll.on Events.Scroll, ->		
# 	if scroll.scrollY > 450
# 		button.animate 
# 			properties: 
# 				opacity: 1
# 		buttonFillOne.animate 
# 			properties: 
# 				y:500
#         buttonFillTwo.animate 
# 			properties: 
# 				y:0   
# 	    buttonFillThree.animate 
# 			properties: 
# 				opacity: 0 

scroll.on Events.Scroll, -> 
  if scroll.scrollY > 50
  	startText.animate 
      properties:
        y: 870, opacity: 1
      time: 1
      

scroll.on Events.Scroll, -> 
  if scroll.scrollY > 200
    button.animate 
      properties:
        opacity: 1
    buttonFillOne.animate 
      properties:
        y: -12
      curve: "ease"
    buttonFillTwo.animate 
      properties:
        y: -28
      curve: "ease"
    buttonFillThree.animate 
      properties:
        y: -45
      curve: "ease"


scroll.on Events.Scroll, -> 
  if scroll.scrollY > 700
    bkgndShape.animate 
      properties:
        opacity: 1
        scale: 1
      curve: "spring(100, 10, 0)"
      time:1	
    whiteDotImage.animate 
      properties:
        opacity: 1
      curve: "spring(100, 10, 0)"
      delay:.25
    avatars.animate 
      properties:
        opacity: 1, scale: 1
      curve: "spring(100, 20, 0)"
      delay:.3
    avatarOne.animate 
      properties:
        opacity: 1, scale: 1 
      curve: "spring(100, 20, 0)"
      delay:.4   
    avatarTwo.animate 
      properties:
        opacity: 1, scale: 1
      curve: "spring(100, 20, 0)"
      delay:.5
    avatarThree.animate 
      properties:
        opacity: 1, scale: 1
      curve: "spring(100, 20, 0)"
      delay:.6     
    avatarFour.animate 
     properties:
       opacity: 1, scale: 1
     curve: "spring(100, 20, 0)"
     delay:.7
            
scroll.on Events.Scroll, -> 
  if scroll.scrollY > 900
    bottomText.animate 
      properties:
        opacity: 1, y:1870
        scale: 1
      curve: "ease"
      time:1.5