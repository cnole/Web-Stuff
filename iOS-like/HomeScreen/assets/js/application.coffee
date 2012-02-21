class Icon

	constructor: (@id, @title) ->
		@markup = "<div class='icon' style='background-image:url(assets/images/icons/#{@id}.png)' title='#{@title}'></div>"

class DockIcon extends Icon

	constructor: (id, title) ->
		super(id, title)
		@markup = @markup.replace("class='icon'", "class='dockicon'")

class Screen
                                         
	constructor: (icons = []) ->
		@icons = icons

	attachIcons: (icons = []) ->
		Array.prototype.push.apply(@icons, icons)

	generate: ->
		markup = []
		markup.push(icon.markup) for icon in @icons

		"<div class='screen'>#{markup.join(' ')}</div>"

class Stage

	screenWidth: 332

	constructor: (icons) ->
		@currentScreen = 0
		@screens = []

		num = Math.ceil(icons.length / 9)
		i = 0

		while num--
			s = new Screen(icons[i...i+9])
			@screens.push(s)

			i += 9

	addScreensTo: (element) ->
		@element = $(element)
		@element.width(@screens.length*@screenWidth)

		for screen in @screens
			@element.append(screen.generate())

	addIndicatorsTo: (element) ->
		@ul = $(element)

		for screen in @screens
			@ul.append('<li>')

		@ul.find('li:first').addClass('active')

	goTo: (screenNum) ->
		if @element.is(':animated')
			return false

		if @currentScreen == screenNum
			[from, to] = ['+=15', '-=15']

			if @currentScreen != 0
				[from, to] = [to, from]

			@element.animate({ marginLeft : from }, 150).animate({ marginLeft : to }, 150)
		else
			@element.animate({ marginLeft: -screenNum*@screenWidth }, => @currentScreen = screenNum)
			@ul.find('li').removeClass('active').eq(screenNum).addClass('active')
			
	next: ->
		toShow = @currentScreen + 1
		
		if toShow == @screens.length
			toShow = @screens.length - 1
			
		@goTo(toShow)
		
	previous: ->
		toShow = @currentScreen - 1
		
		if toShow == -1
			toShow = 0
			
		@goTo(toShow)
		
$ ->
	allIcons = [
		new Icon('Photos', 'Photo Gallery'), new Icon('Maps', 'Google Maps')
		new Icon('Chuzzle', 'Chuzzle'), new Icon('Safari', 'Safari')
		new Icon('Weather', 'Weather'), new Icon('nes', 'NES Emulator')
		new Icon('Calendar', 'Calendar'), new Icon('Clock', 'Clock')
		new Icon('BossPrefs', 'Boss Prefs'), new Icon('Chess', 'Chess')
		new Icon('Mail', 'Mail'), new Icon('Phone', 'Phone')
		new Icon('SMS', 'SMS Center'), new Icon('Camera', 'Camera')
		new Icon('iPod', 'iPod'), new Icon('Calculator', 'Calculator')
		new Icon('Music', 'Music'), new Icon('Poof', 'Poof')
		new Icon('Settings', 'Settings'), new Icon('YouTube', 'Youtube')
		new Icon('psx4all', 'PSx4All'), new Icon('VideoRecorder', 'Record Video')
		new Icon('Installer', 'Installer'), new Icon('Notes', 'Notes')
		new Icon('RagingThunder', 'RagingThunder'), new Icon('Stocks', 'Stocks')
		new Icon('genesis4iphone', 'Genesis'), new Icon('snes4iphone', 'SNES Emulator')
		new Icon('Calendar', 'Calendar'), new Icon('Clock', 'Clock')
		new Icon('Photos', 'Photo Gallery'), new Icon('Maps', 'Google Maps')
	]
	
	dockIcons = [
		new DockIcon('Camera', 'Camera')
		new DockIcon('iPod', 'iPod')
		new DockIcon('Calculator', 'Calculator')
	]
	
	allScreens = $('#allScreens')
	
	allScreens.Touchable()
	
	stage = new Stage(allIcons)
	
	stage.addScreensTo(allScreens)
	stage.addIndicatorsTo('#indicators')
	
	allScreens.bind 'touchablemove', (e, touch)->
		stage.next() if touch.currentDelta.x < -5
		stage.previous() if touch.currentDelta.x > 5
		
	dock = $('#dock')
	
	for icon in dockIcons
		dock.append(icon.markup)