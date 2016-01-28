sketch = Framer.Importer.load "imported/episodePicker"

bg = new BackgroundLayer backgroundColor: "black"


Utils.globalLayers(sketch)
descriptionText.opacity = 0

image.on Events.TouchMove, (start) ->
    image.animate
	    properties:
	        opacity: .5
	    curve: "ease-in-out"
    ep.animate
	    properties:
	         y: 220
	     curve:"spring(200,40,0)"      
    descriptionText.animate
	    properties:
	         opacity:1, y:255
	    curve:"ease"
    jpeg.animate
	    properties:
	         scale:1.2, blur:3
	    curve:"ease"
 
bg.on Events.TouchMove, (end) ->
	image.animate
	    properties:
	        opacity: 1
	    curve: "ease-in-out"
    ep.animate
	    properties:
	         y: 303
	     curve:"spring(200,40,0)"      
    descriptionText.animate
	    properties:
	         opacity:0, y:278
	    curve:"ease"
    jpeg.animate
	    properties:
	         scale:1, blur:0
	    curve:"ease"
	