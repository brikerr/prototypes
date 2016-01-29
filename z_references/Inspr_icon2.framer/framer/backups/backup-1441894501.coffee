w = 640
h = 1136
h_edit_panel = 576
scrolling = false
scrollingV = false
scrollingH = false

app = new Layer width:w, height:h, backgroundColor:"#ffffff"
Canvas = new Layer width:w, height:774, image:"images/canvas.png", superLayer: app
edit_panel = new Layer width:w, height: h_edit_panel, y: h-h_edit_panel, backgroundColor:"#28282A", shadowColor:"#000", shadowY:-2, shadowBlur:20, superLayer: app
controls_scroller = new ScrollComponent width:560, height: h_edit_panel, x:w-560, superLayer: edit_panel, scrollHorizontal: false
controls = new Layer width:560, height: 2400,image:"images/edit_controls.png", superLayer:controls_scroller.content

el_icon = new Layer width: 128, height: 128, x:260, y:260, image:"images/icon_temp_1_1.png"

ic_packs=[]
ic_packs_scroller=[]
# ic_packs[0] = new Layer width:560-20, height: 200, x:20, y:274, superLayer: controls, backgroundColor: ""
ic_packs_scroller[0] = new ScrollComponent width:560-20, height: 200, x:40, y:274, superLayer: controls, scrollVertical: false, backgroundColor: ""
ic_packs_image = new Layer width: 1152, height: 200, image:"images/ic_pack01.png", superLayer: ic_packs_scroller[0].content


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
