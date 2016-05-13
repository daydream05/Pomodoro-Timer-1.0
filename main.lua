-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"


-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "view1" )
end

local function onSecondView( event )
	composer.gotoScene( "view2" )
end

local function onThirdView( event)
	composer.gotoScene("settings-tab")

end

-- create a tabBar widget with two buttons at the bottom of the screen

-- table to setup buttons

--local tabBg = display.newRect( display.contentCenterX , display.actualContentHeight - 50, display.actualContentWidth, 100 )
--tabBg:setFillColor( 1, 83/255, 87/255 )


local tabButtons = {
	{ label="First", defaultFile="icon1.png", overFile="icon1-down.png", width = 32, height = 32, onPress=function() local firstview = onFirstView() end  },
	{ label="Timer", defaultFile="icons/tabIcons/ios9timer.png", overFile="icons/tabIcons/ios9timerFill.png", width = 32, height = 32, onPress=onSecondView, selected=true}, 
	{ label="Settings", defaultFile="icons/tabIcons/ios9settings.png", overFile="icons/tabIcons/ios9settingsFill.png",width = 32, height = 32, onPress=onThirdView }
}


-- create the actual tabBar widget
local tabBar = widget.newTabBar{
	-- 50 is default height for tabBar widget
	top  =  display.contentHeight - 5,
	buttons = tabButtons,
	height = 50
	
}

onSecondView()	-- invoke first tab button's onPress event manually