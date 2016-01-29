w = 640
h = 1136
h_edit_panel = 576
scrolling = false
scrollingV = false
scrollingH = false

app = new Layer width:w, height:h, backgroundColor:"#ffffff"
Canvas = new Layer width:w, height:774, image:"images/canvas.png", superLayer: app

#edit_panel
edit_panel = new Layer width:w, height: h_edit_panel, y: h-h_edit_panel, backgroundColor:"#28282A", shadowColor:"#000", shadowY:-2, shadowBlur:20, superLayer: app
controls_scroller = new ScrollComponent width:560, height: h_edit_panel, x:w-560, superLayer: edit_panel, scrollHorizontal: false
controls = new Layer width:560, height: 1864,image:"images/edit_controls.png", superLayer:controls_scroller.content

more_icon = new Layer width: 200, height: 80, superLayer: controls, x:360, y:100,backgroundColor: ""

el_icon = new Layer width: 128, height: 128, x:260, y:260, image:"images/icon_temp_1_1.png"

ic_packs=[]
ic_packs_scroller=[]
# ic_packs[0] = new Layer width:560-20, height: 200, x:20, y:274, superLayer: controls, backgroundColor: ""
ic_packs_scroller[0] = new ScrollComponent width:560-20, height: 128, x:40, y:212, superLayer: controls, scrollVertical: false, backgroundColor: ""
ic_packs_image = new Layer width: 1144, height: 64, image:"images/ic_pack.png", superLayer: ic_packs_scroller[0].content


edit_tabs = new Layer width:80, height:h_edit_panel, superLayer: edit_panel, backgroundColor:""
edit_tab = []
for i in [0..4]
	edit_tab[i] = new Layer width:80, height:80,y: 10+110*i , image:"images/edit_tab"+(i+1)+"_disabled.png", superLayer: edit_tabs

switch_tab_pos = [0,590,1120,1530,1940,2070]

switch_tab = (i_selected) ->
	for i in [0..4]
		if i_selected != i
			edit_tab[i].image = "images/edit_tab"+(i+1)+"_disabled.png"	
		else
			edit_tab[i].image = "images/edit_tab"+(i+1)+".png"	

switch_tab(0)
controls_scroller.on Events.Move, ->
# 	print(controls_scroller.scrollY)
	if controls_scroller.scrollY<switch_tab_pos[1]
		switch_tab(0)
	else if controls_scroller.scrollY<switch_tab_pos[2]
		switch_tab(1)
	else if controls_scroller.scrollY<switch_tab_pos[3]
		switch_tab(2)
	else if controls_scroller.scrollY<switch_tab_pos[4]
		switch_tab(3)
	else if controls_scroller.scrollY<switch_tab_pos[5]
		switch_tab(4)
	
controls_scroller.on Events.ScrollStart, ->
	if scrolling == false
		ic_packs_scroller[0].scrollHorizontal = false
		scrolling = true

controls_scroller.on Events.ScrollEnd, ->
	scrolling = false
	ic_packs_scroller[0].scrollHorizontal = true
	
ic_packs_scroller[0].on Events.ScrollStart, ->
	if scrolling == false
		controls_scroller.scrollVertical = false
		scrolling = true
ic_packs_scroller[0].on Events.ScrollEnd, ->
	scrolling = false
	controls_scroller.scrollVertical = true
ic_packs_scroller[0].on Events.Click, ->
	el_icon.image="images/icon_temp_1_"+Math.floor(Utils.randomNumber(1,10))+".png"


edit_tab[0].on Events.Click, ->
	switch_tab(0)
	controls_scroller.scrollToPoint(
		x:0, y:switch_tab_pos[0]
		true
		curve: "ease"
	)
	
edit_tab[1].on Events.Click, ->
	switch_tab(1)
	controls_scroller.scrollToPoint(
		x:0, y:switch_tab_pos[1]
		true
		curve: "ease"
	)
	
edit_tab[2].on Events.Click, ->
	switch_tab(2)
	controls_scroller.scrollToPoint(
		x:0, y:switch_tab_pos[2]
		true
		curve: "ease"
	)
	
edit_tab[3].on Events.Click, ->
	switch_tab(3)
	controls_scroller.scrollToPoint(
		x:0, y:switch_tab_pos[3]
		true
		curve: "ease"
	)
	
edit_tab[4].on Events.Click, ->
	switch_tab(4)
	controls_scroller.scrollToPoint(
		x:0, y:switch_tab_pos[4]
		true
		curve: "ease"
	)

#icon_panel
icon_panel = new Layer width:w, height: h_edit_panel, y: h+100, backgroundColor:"#28282A", shadowColor:"#000", shadowY:-2, shadowBlur:20, superLayer: app
icon_panel.states.add
	shown:
		y: h-h_edit_panel
	hidden:
		y:h+100
icon_panel.states.animationOptions.curve = "spring(100,15,0)"
icon_scroller = new ScrollComponent width:560, height: h_edit_panel-90, x:w-560, y:90, superLayer: icon_panel, scrollHorizontal: false
icon_content = new Layer width: 540, height: 1552, x:20, y:-40, image:"images/icon_panel.png", superLayer: icon_scroller.content
icon_tabs_scroller = new ScrollComponent width:100, height: h_edit_panel, superLayer: icon_panel, scrollHorizontal: false
icon_tabs = new Layer width:80, height:h_edit_panel, y:110, superLayer: icon_tabs_scroller.content, backgroundColor:"" 

icon_tab = []
for i in [0..5]
	icon_tab[i] = new Layer width:80, height:80,y: 90*i, x:10 , image:"images/icon_tab_"+(i+1)+".png", superLayer: icon_tabs
icon_tab[0].image = "images/icon_tab_1_active.png"

buy_icon = new Layer width: 80, height: 100, superLayer: icon_panel, x:10, image:"images/icon_buy.png"


switch_icon_tab_pos = [0,150,300,450,600,750,900]

switch_icon_tab = (i_selected) ->
	for i in [0..5]
		if i_selected != i
			icon_tab[i].image = "images/icon_tab_"+(i+1)+".png"
		else
			icon_tab[i].image = "images/icon_tab_"+(i+1)+"_active.png"
	if i_selected == 0 	
		icon_tabs_scroller.scrollToPoint(
			x:0, y:0
			true
			curve: "spring(100,15,0)"
		)
	else if i_selected ==5
		icon_tabs_scroller.scrollToPoint(
			x:0, y:80
			true
			curve: "spring(100,15,0)"
		)

switch_icon_tab(0)
icon_scroller.on Events.Move, ->
# 	print(icon_scroller.scrollY)
	if icon_scroller.scrollY<0
	else if icon_scroller.scrollY<switch_icon_tab_pos[1]
		switch_icon_tab(0)
	else if icon_scroller.scrollY<switch_icon_tab_pos[2]
		switch_icon_tab(1)
	else if icon_scroller.scrollY<switch_icon_tab_pos[3]
		switch_icon_tab(2)
	else if icon_scroller.scrollY<switch_icon_tab_pos[4]
		switch_icon_tab(3)
	else if icon_scroller.scrollY<switch_icon_tab_pos[5]
		switch_icon_tab(4)
	else if icon_scroller.scrollY<switch_icon_tab_pos[6]
		switch_icon_tab(5)
		
btn_icon_confirm = new Layer superLayer: icon_panel, html:"Done", color:"#0082E3", width:100, x:w-100-32, y:20, height:80, backgroundColor: ""
btn_icon_confirm.style = {
	"font-size" : "30px"
	"text-align" : "right"
}

btn_icon_confirm.on Events.Click,->
	icon_panel.states.switch("hidden")
	
more_icon.on Events.Click,->
	icon_panel.states.switch("shown")