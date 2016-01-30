
colors = ["#866ccc", "#28affa", "#2dd7aa", "#ffc22c", "#7ddd11", "#f95faa"]

bg = new BackgroundLayer backgroundColor: "#000"
bg.bringToFront()

# Set-up ScrollComponent
page = new PageComponent
	width: 1440, height: 900
	y: 0, scrollHorizontal: false
	contentInset: {top: 0, left: 0, right: 0}

# Array that will store our layers
allIndicators = []	
amount = 4

# Generate card layers
for i in [0...amount]
	card = new Layer 
		backgroundColor: colors[i], borderRadius: 0
		width: 1440, height: 900 
		y: 900 * i, superLayer: page.content
				
	card.style.boxShadow = "0 1px 6px rgba(0,0,0,0.2)"
	
	indicator = new Layer 
		backgroundColor: '#fff'
		width: 12, height: 12
		x: 28 * i, y: 800
		borderRadius: "50%", opacity: 0.2
		
	# Stay centered regardless of the amount of cards
	indicator.x += (Screen.width / 2) - (12 * amount)
	
	# States
	indicator.states.add(active: {opacity: 1, scale:1.2})
	indicator.states.animationOptions = time: 0.5
	
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
	
	# Animation of pages fading out
	page.previousPage.animate 
		properties: {scale: 0.95}
		curve: "spring", curveOptions: {tension: 100, friction: 50, velocity: 0, tolerance: 1}
			
	page.previousPage.once Events.AnimationEnd, -> this.scale = 1
