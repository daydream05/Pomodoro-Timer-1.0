local composer = require( "composer" )

local scene = composer.newScene()
local widget = require("widget")

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here
local pickerWheel
local startingTime = {}
-- -------------------------------------------------------------------------------
--Populate the startingTime table

for t = 1, 9 do

    startingTime[t] = t * 5 .. " minutes"
end


local columnData =
{
    --Pomodoro Time
    {
        align = "right",
        width = 140,
        --starting time is 25 minutes
        startIndex = 5,
        labels = startingTime 
    }
}



-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    pickerWheel = widget.newPickerWheel( 
    {
        top = display.contentCenterY,
        columns = columnData
        } )

    sceneGroup:insert(pickerWheel )

    local function getValues( )
         local values = pickerWheel:getValues( )
    local time = values[1].value
    print(time)
 end
    Runtime:addEventListener( "touch", getValues )


    
    
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.


-- Create two tables to hold data for days and years      


end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene