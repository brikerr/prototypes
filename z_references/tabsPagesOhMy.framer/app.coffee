
# Original file by Diego Oriani

Framer.Defaults.Animation = curve: "spring(300,35,0)"


# Variables ------------------------------------

tabCount = 10

statusBarHeight = 40
navigationBarHeight = 88

tabHeight = 100
tabWidth = 235
tabFocusHeight = 8

tabScrollHeight = Screen.height - statusBarHeight - navigationBarHeight

selectedTab = null
tappedTab = false

pages = []
tabs = []



# Layers ----------------------------------------

bg = new BackgroundLayer


pageContainer = new PageComponent
	width: Screen.width, height: tabScrollHeight
	scrollVertical: false
	y: statusBarHeight + navigationBarHeight


tabScroll = new ScrollComponent
	width: Screen.width, height: tabHeight
	superLayer: pageContainer
	scrollVertical: false
	backgroundColor: "grey"

tabScroll.content.draggable.overdrag = false
tabScroll.content.draggable.bounce   = false


tabFocus = new Layer
	width: tabWidth, height: tabFocusHeight
	backgroundColor: "white"
	y: (tabScroll.maxY - tabFocusHeight) + 1
	superLayer: pageContainer


navigationBar = new Layer
	width: Screen.width, height: navigationBarHeight + statusBarHeight
	backgroundColor: "white"


statusBar = new Layer
	width: Screen.width, height: statusBarHeight
	backgroundColor: "rgba(0,0,0,.1)"



for i in [0...tabCount]

	randomColor = Utils.randomColor(.5)

	page = pages[i] = new Layer
		name: "page#{i+1}"
		width: 750, height: tabScrollHeight - tabHeight
		backgroundColor: randomColor
		y: tabHeight

	pageContainer.addPage(page, "right")

	tab = tabs[i] = new Layer
		name: "tab#{i+1}"
		width: tabWidth , height: tabHeight
		backgroundColor: randomColor
		x: tabWidth * i
		superLayer: tabScroll.content
		html: "Tab #{i+1}"
		style:
			color: "white"
			fontWeight: "400"
			textAlign: "center"
			lineHeight: "#{tabHeight-tabFocusHeight + 5}px"
			fontSize: "28px"
			textShadow: "0px 0px 20px rgba(0,0,0,.1)"


	# animate tabFocus onTouchEnd
	tab.on Events.TouchEnd, ->

		selectedTab = @
		tappedTab = true

		tabFocus.animate
			properties:
				midX: @.midX + tabScroll.content.x

		return if tab.isMoving
		pageContainer.snapToPage(pages[@index-1])





selectedTab = tabs[0] # select the first tab on init



# Events ----------------------------------------

# update tabFocus on scroll
tabScroll.content.on "change:x", ->

	tabFocus.animateStop()
	tabFocus.midX = selectedTab.midX + @.x # compensate for scroll movement


# update tabFocus on pageChange
pageContainer.on "change:currentPage", ->

	tabFocus.animateStop()
	selectedTab = tabs[@.verticalPageIndex(pageContainer.currentPage)]
	scrollToTab = tabs[@.verticalPageIndex(pageContainer.currentPage) - 1] # centers tabFocus to the middle tab

	tabFocus.animate
		properties:
			midX: selectedTab.midX + tabScroll.content.x

	tabScroll.scrollToLayer(scrollToTab) unless tappedTab
	tappedTab = false






