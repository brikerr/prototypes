scroll = new ScrollComponent
	width: 750
	height: 1334
	scrollHorizontal: false
	backgroundColor: ""
	visible: false
	contentInset:
		top: 0
		bottom: 0
	borderRadius: 8
	
image = new Layer
	width: 750, height: 12634
	y:100
	image: "images/content.png"
	
scroll = ScrollComponent.wrap(image)
scroll.scrollHorizontal = false
	
nav = new Layer
	width: 750, height: 100
	image: "images/nav.png"
	
subNav = new Layer
	width: 750, height: 48
	y:99
	backgroundColor: "#181616"
	opacity: 0

seriesTypeText = new Layer
	width: 300
	x: 70, y:106
	backgroundColor: ''
	opacity:0
seriesTypeText.html = 'HOMELAND'	
seriesTypeText.style = "font-size": "24px", "color":"#CB292E"	

	
scroll.on Events.Scroll, ->		
	if scroll.scrollY > 150
        subNav.animate
            properties: 
            	opacity: 1
            	
            curve: "ease-in"
        seriesTypeText.animate
            properties: 
            	opacity: 1
            	x:83
            curve: "ease"
        
            	
	    else if scroll.scrollY < 300
	        subNav.animate
	            properties: 
	            	opacity: 0
	            	
	            curve: "ease-in" 
	        seriesTypeText.animate
	            properties: 
	            	opacity: 0
	            	x:70
	            curve: "ease"           
