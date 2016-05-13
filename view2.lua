-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")


	-- Display Properties

function scene:create( event )


-- forward references
	local updateTime, timerPause, countDownTimer, 
	showStartButton, showPauseButton, showResumeButton, showCancelButton, 
	startButton, buttonGroup, countDown, timerGroup

	--add these to sceneGroup
	local circleCountdown, clockText, text, pauseButton, resumeButton, cancelButton, rect
	_CX = display.contentCenterX
	_CY = display.contentCenterY
	_H = display.actualContentHeight
	_W = display.actualContentWidth


	local sceneGroup = self.view
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
		
	display.setDefault("background", 1, 1, 1 )

	local tomatoGradient = {1, 83/255, 87/255}
	-- Keep track of time in seconds
	local startMinutes = 15
	local secondsLeft = startMinutes * 60  -- 20 minutes * 60 seconds

	timerGroup = display.newGroup( )
	timerGroup.x = _CX 
	timerGroup.y = _CY 

	circleCountDown = display.newCircle( timerGroup, 0, 0, _W/3 )
	circleCountDown:setFillColor( 1, 1, 1 )
	circleCountDown.strokeWidth = 2
	circleCountDown:setStrokeColor( unpack(tomatoGradient) )

	sceneGroup:insert(timerGroup)

	clockText = display.newText(timerGroup, startMinutes .. ":00", 0, 0, native.systemFontBold, 50)
	clockText:setFillColor( unpack(tomatoGradient) )
	clockText.anchorY = 0.5
	clockText.y = -_W/3 + _W/4 

	--sceneGroup:insert(clockText)
	
	--local playImage = display.newPolygon()


	local text

	function updateTime()
		-- decrement the number of seconds
		secondsLeft = secondsLeft - 1
		
		-- time is tracked in seconds.  We need to convert it to minutes and seconds
		local minutes = math.floor( secondsLeft / 60 )
		local seconds = secondsLeft % 60
		
		-- make it a string using string format.  
		local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
		clockText.text = timeDisplay

	    --Displays when timer hits 0


	    if secondsLeft == 0 then 
	        text = display.newText( timerGroup, "You won", 0, 0, Arial, 20)
	        text.y = 30
	        text:setFillColor( unpack(tomatoGradient) )

	        sceneGroup:insert(text)

	        print("Time Ended")
	    
	    end

	    

	end

	-- run them timer

	function countDownTimer(event) 

		if (event.phase == "ended") then
			
			countDown = timer.performWithDelay( 1000, updateTime, secondsLeft )
			showPauseButton()
			showCancelButton()
			--composer.gotoScene("menu")
			display.remove(startButton)

			
	        
		end
		return true
	end

	--[[
	function showStartButton()
		startButton = widget.newButton({
		width = 110,
		height = 48,
		defaultFile = 'images/buttons/shadedLight42.png',
		overFile = 'images/buttons/transparentLight40.png',
		onEvent = countDownTimer

		})

		startButton.anchorX = 1
		startButton.anchorY = 1
		buttonGroup:insert(startButton)

	end

	--]]
	function showPauseButton()
	        --pauseButton = display.newImageRect(buttonGroup, 'images/buttons/shadedLight14.png', 50, 48 )
	        --pauseButton.x = _W * .25

	        display.remove(resumeButton)

	        pauseButton = widget.newButton({
	        width = 50,
	        height = 48,
	        defaultFile = 'icons/ios9pause.png',
	        --overFile = 'images/buttons/transparentLight12.png',
	        onRelease = function() 
	            pause = timer.pause(countDown)
	            showResumeButton()
	            end

	        })

	        pauseButton.anchorX = 1
	        pauseButton.anchorY = 1
	        --pauseButton.x = -_CX * .25
	        buttonGroup:insert(pauseButton)

	        sceneGroup:insert(buttonGroup)

	    end

	    --resumeButton is the "play" button
	function showResumeButton()

	    display.remove(pauseButton)

	    resumeButton = widget.newButton({
	    width = 50,
	    height = 48,
	    defaultFile = 'icons/ios9play.png',
	    --overFile = 'images/buttons/transparentLight14.png',
	    onRelease = countDownTimer

	    })

	    resumeButton.anchorX = 1
	    resumeButton.anchorY = 1
	    --resumeButton.x = -_CX * .25

	    buttonGroup:insert(resumeButton)
	    sceneGroup:insert(buttonGroup)

	end

	function showCancelButton()

	    cancelButton = widget.newButton({
	    width = 50,
	    height = 48,
	    defaultFile = 'icons/ios9cancel.png',
	    --overFile = 'images/buttons/transparentLight33.png',
	    onRelease = function()
	    	display.remove( pauseButton )
	    	display.remove(resumeButton)
	    	display.remove(cancelButton)
	        display.remove( text )
	    	--this resets the timer perform delay
	        timer.cancel(countDown)

	        --this restarts the seconds remaining
	        --because canceling the tiemr is not enough	
	        secondsLeft = startMinutes * 60
	        showResumeButton()
	        clockText.text = startMinutes .. ":00"
	        --
	        end

	    })

	    cancelButton.anchorX = 0.5
	    cancelButton.anchorY = 0.5
	    cancelButton.x = (_W/4) + _H/25
	    cancelButton.y = (-_W/1.8) 
	    buttonGroup:insert(cancelButton)
	    sceneGroup:insert(buttonGroup)
	    
	end


	-- display objects
	--this group controls where the controls are located 
	buttonGroup = display.newGroup( )
	timerGroup:insert(buttonGroup)
	buttonGroup.x = _W/2 
	buttonGroup.y =  timerGroup.y + ((_W/3) - _W/6)
	--[[local rect = display.newRect( buttonGroup, 0, 0, _W, _H * .15 )
	rect:setFillColor( unpack(tomatoGradient) )]]--
	showResumeButton()
	sceneGroup:insert(buttonGroup)

	--for debugging
	showCancelButton()
end
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen

	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen


			--remove the comment if you want to pause the timer when you switch tabs
		--[[ 

		timer.pause( countDown )
		showResumeButton()

		]]--
		
		

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	display.remove( timerGroup )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
