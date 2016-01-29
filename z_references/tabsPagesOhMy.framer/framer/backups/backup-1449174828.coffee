	########## Variables ##############################

bg = new BackgroundLayer

gray1 = "#EEEEEE"
black = "#000000"

statusBarHeight = 40
navigationBarHeight = 88

tabComponentOffset = 88
tabsWidth = Screen.width
tabsHeight = Screen.height - statusBarHeight - navigationBarHeight


allScreens = []
alltab = []
allLabels = ["District", "Circle", "Victoria", "Central"]

numScreens = 2

tabHeight = 100
tabWidth = tabsWidth / numScreens
tabFocusHeight = 2

	########## Layers ##############################

tabComponent = new PageComponent
	name: "tabComponent"
	width: tabsWidth,	height: tabsHeight
	scrollVertical: false
	y: statusBarHeight + navigationBarHeight

tabs = new Layer
	name: "tabs"
	width: tabsWidth, height: tabHeight
	superLayer: tabComponent
	
tabFocus = new Layer
	name: "tabFocus"
	width: tabWidth, height: tabFocusHeight
	backgroundColor: black
	y: (tabs.maxY - tabFocusHeight) + 1
	superLayer: tabComponent

statusBar = new Layer
	name: "statusBar"
	image: "images/general/statusBar.png"
	width: Screen.width, height: statusBarHeight

navigationBar = new Layer
	name: "navigationBar"
	image: "images/StJamesPark/navigationBar.png"
	width: Screen.width, height: navigationBarHeight
	y: statusBarHeight
	
for i in [0...numScreens]
	screen = allScreens[i] = new Layer
		name: "screen#{i+1}"
		image: "images/StJamesPark/screen#{i+1}.png"
		width: 750, height: tabsHeight - tabHeight
		backgroundColor: Utils.randomColor()
		x: tabsWidth * i
		y: tabHeight
		
	tabComponent.addPage(screen, "right")
		
	tab = alltab[i] = new Layer
		name: "tab#{i+1}"
		width: tabWidth , height: tabHeight
		backgroundColor: gray1
		x: tabWidth * i
		superLayer: tabs
	
	tab.html = allLabels[i]
	tab.style =
		color: "black"
		textAlign: "center"
		lineHeight: "92px"
		fontSize: "28px"

	tab.on Events.Click, ->
		tabComponent.snapToPage(allScreens[@index-1])
		
tabComponent.content.on "change:x", ->	
	offsetScreen = tabComponent.width * (numScreens - 1)
	offsetTab = tabWidth * (numScreens - 1)
	
	tabFocus.x = Utils.modulate(tabComponent.content.x, [0, - offsetScreen], [alltab[0].x, offsetTab], true)

return {
	tabComponent:tabComponent
}

