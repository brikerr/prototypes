# Imports all the layers for "rnv1" into rnv1Layers
sketch = Framer.Importer.load "imported/rnv1"

# Base layer
bg = new BackgroundLayer backgroundColor: "black"

# Scroll properties
scroll = ScrollComponent.wrap sketch.content
scroll.scrollHorizontal = false
scroll.contentInset = 
	top: 180
	bottom: 150
	
# Layer defaults	
Utils.globalLayers(sketch)
selectedBagBtn.opacity = 0
selectedBagBtn.scale = .2
foodItem.scale = .1
tintLayer.opacity = 0
editProduct.opacity = 0
titleLabel.opacity = 0
titleBlock.scale = .8
productImage.scale = .7
tintDetail.opacity = 1

# States for adding items to bag
bagTab.states.add
    added: { y:1226 }
foodItem.states.add
    added: { scale:1 }	
selectedBagBtn.states.add
    added: { opacity:1, scale: 1 }	
defaultBagBtn.states.add
	added: { opacity:0, scale:.5 }    
editProduct.states.add
	added: { opacity:1 }
editProduct.states.add
	added: { opacity:1 } 
productPriceTwo.states.add
	added: { opacity:0 }	  
# States for menu flyout
menuPanel.states.add
	show: { x:0}
tintLayer.states.add
	show: { opacity:1 }
# State for viewing bag 
bagPanel.states.add
	up: { y:290 } 
# State for product info 
productDetail.states.add
	detail: { x:0 } 
infoItems.states.add
	detail: {y:500}
titleBlock.states.add
	detail: {scale:1}
productImage.states.add
	detail: {scale:1}
tintDetail.states.add
	detail: {opacity:.2}


 
# Animation curves
bagTab.states.animationOptions = curve: "spring(300,40,0)"
foodItem.states.animationOptions = curve: "spring(200,20,0)"
selectedBagBtn.states.animationOptions = curve: "spring(300,30,0)"
defaultBagBtn.states.animationOptions = curve: "spring(500,50,0)"
editProduct.states.animationOptions = curve: "spring(500,50,0)"
productPriceTwo.states.animationOptions = curve: "spring(500,50,0)"
# Animation curves
menuPanel.states.animationOptions = curve: "spring(500,50,0)"
tintLayer.states.animationOptions = curve: "spring(500,50,0)"
# Animation curves
bagPanel.states.animationOptions = curve: "spring(500,50,0)"
# Animation curves
productDetail.states.animationOptions = curve: "spring(500,50,0)"
infoItems.states.animationOptions = curve: "spring(300,50,0)"
titleBlock.states.animationOptions = curve: "spring(200,50,0)"
productImage.states.animationOptions = curve: "spring(300,50,0)"
tintDetail.states.animationOptions = curve: "spring(100,50,0)"

# Switch states on tap of food item
foodTwo.on Events.Click, ->
	bagTab.states.next("added", "default")
	foodItem.states.next("added", "default")
	selectedBagBtn.states.next("added", "default")
	defaultBagBtn.states.next("added", "default")
	editProduct.states.next("added", "default")
	productPriceTwo.states.next("added", "default")
# Switch states on tap of menu item	
header.on Events.Click, ->
	menuPanel.states.next("show", "default")
	tintLayer.states.next("show", "default")	
# reverse because above is below active layer	
menuPanel.on Events.Click, ->
	menuPanel.states.next("default")
	tintLayer.states.next("default")
	
bagTab.on Events.Click, ->
	bagPanel.states.next("up")
	tintLayer.states.next("show")
	bagTab.states.next("default")
		
bagPanel.on Events.Click, ->
	bagPanel.states.next("default")
	tintLayer.states.next("default")
	bagTab.states.next("added")	


foodThree.on Events.Click, ->
	productDetail.states.next("detail")
	infoItems.states.next("detail")
	titleBlock.states.next("detail")
	productImage.states.next("detail")
	tintDetail.states.next("detail")



productDetail.on Events.Click, ->
	productDetail.states.next("default")
	productImage.states.next("default")
	infoItems.states.next("default")
	titleBlock.states.next("default")
	tintDetail.states.next("default")
	

	
# Header tranisition based on scroll position
scroll.on Events.Move, ->	
	logo.opacity = Utils.modulate(scroll.scrollY, [0, 200], [1, 0], false)
	logo.scale = Utils.modulate(scroll.scrollY, [0, 200], [1, 0], false)
	
	titleLabel.y = Utils.modulate(scroll.scrollY, [0, 120], [100, 80], true)
	titleLabel.opacity = Utils.modulate(scroll.scrollY, [0, 900], [0, 1], false)






	