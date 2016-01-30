colors = ["#866ccc", "#28affa", "#2dd7aa", "#ffc22c"]

data = ["#866ccc", "#28affa", "#2dd7aa", "#ffc22c"]

# textLabels = new Layer
# 		width: page.width, height: page.height
# 		backgroundColor: ''
# 		
# 		style:
# 			lineHeight: "#{Screen.height}px"
# 			textAlign: "center"
# 			fontSize: "240px"
# 			fontWeight: "100"
# 			fontFamily: "Helvetica Neue"




allIndicators = []	
amount = 3

# Set background
bg = new BackgroundLayer backgroundColor: "#000"
bg.bringToFront()

# Create PageComponent
page = new PageComponent
	width: 1440, height: 900
	scrollHorizontal: false
	backgroundColor: "null"
	contentInset: 
		top: 0
		bottom: 10
		right: 10
	borderRadius: 0

page.center()


# Array that will store our layers
for i in [0..3]
	layerA = new Layer
		width: 1440, height: 900
		y: (902 * i) + 0
		borderRadius: 0
		opacity: 100
		html:data[i]
		backgroundColor: colors[i]
		superLayer: page.content 
		y: page.height * i, superLayer: page.content
						
	indicator = new Layer 
		backgroundColor: "#222"
		width: 8, height: 8
		y: 28 * i, x: 1370
		borderRadius: "50%", opacity: 0.2
		

	# Stay centered regardless of the amount of cards
	indicator.y += (Screen.height / 2) - (12 * amount)
	

	
	# States
	indicator.states.add(active: {opacity: 1, scale:1.2})
	indicator.states.animationOptions = time: 0.7
	
	# Store indicators in our array
	allIndicators.push(indicator)

# Set indicator for current page
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Define custom animation curve for page switches
page.animationOptions = curve: "spring(200,22,0)"

# Update indicators
page.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	
	current = page.horizontalPageIndex(page.currentPage)
	allIndicators[current].states.switch("active")

	    
logo = new Layer
	width: 221, height: 64
	x:1150, y: 40
	image: "images/logo.png"