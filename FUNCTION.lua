------ FUNCTION 
--_________________________________________________________________________________--

local sx, sy = guiGetScreenSize() 
function centerTheGUI( guiElement ) 
    local width, height = guiGetSize( guiElement, false ) 
    local x, y = sx / 2 - width / 2, sy / 2 - height / 2 
    guiSetPosition( guiElement, x, y, false ) 
end 
---_EX__---
window = guiCreateWindow( 349, 205, 332, 209, "GUI Window", false ) 
centerTheGUI( window ) 

--___________________________________ changeGridListItemToPlayersName ______________________________________________--

changeGridListItemToPlayersName = function ( GridList, Column ) 
    if GridList and Column then -- Check Parematers 
        if getElementType ( GridList ) == "gui-gridlist" then -- Check The Type of ' GridList ' 
            if guiGridListClear ( GridList ) then -- Clear GridList 
                for i, v in next, getElementsByType ( "player" ) do -- Get Everything by Type ' player '  
                    local Row = guiGridListAddRow ( GridList ) -- Add Row 
                    guiGridListSetItemText ( GridList, Row, Column, getPlayerName ( v ), false, false ); -- Set New Values 
                end; -- end of ' for ' 
            end; -- end of ' clear gridlist ' 
        end; -- end of ' check gridlist type ' 
    end; -- end of ' check parematers 
end; -- end of ' function '
---_EX__---
wnd = guiCreateWindow ( 100, 100, 400, 400, "Test", false ); -- Create Window 
grid = guiCreateGridList ( 25, 30, 350, 350, false, wnd ); -- Create Gridlist 
col = guiGridListAddColumn ( grid, "Players", 0.9 ); -- Create Column 
changeGridListItemToPlayersName ( grid, col ); -- Set Gridlist Values 
--_____________________________________ guiGridListGetSelectedItemText ____________________________________________--
function guiGridListGetSelectedItemText ( gridList, column ) 
    local item = guiGridListGetSelectedItem ( gridList ) 
    local text = guiGridListGetItemText ( gridList, item, column or 1 ) 
    if ( text ~= '' ) then 
        return text 
    else 
        return false 
    end 
end 
---_EX__---
wnd = guiCreateWindow ( X, Y, Width, Height, 'Example',   false, false ) -- لعمل نافذة 
gridList = guiCreateGridList ( X, Y, Width, Height, false, wnd ) -- لعمل قريد في النافذة 
guiGridListGetSelectedItemText ( GridList ) -- للحصول على نص الغرض المختار 
---_EX__---
 wnd = guiCreateWindow ( X, Y, Width, Height, 'Example',   false, false ) -- لعمل نافذة 
gridList = guiCreateGridList ( X, Y, Width, Height, false, wnd ) -- لعمل قريد في النافذة 
column = guiGridListAddColumn ( gridList, 'Example', 0.8 ) -- في القريد column لعمل  
guiGridListGetSelectedItemText ( gridList, column ) -- للحصول على نص الغرض المختار 
--__________________________________GetPlayerVehicleName______________________________________________--

function GetPlayerVehicleName ( player,vehicle ) 
    if isPedInVehicle( player ) then 
        local PlayerVehicle = getPedOccupiedVehicle ( player ) 
        local VehicleName = getVehicleName ( PlayerVehicle ) 
        if (  VehicleName  == vehicle ) then 
            return true 
        else 
            return false         
        end  
    end 
    return false     
end 
---_EX_CLIENT_---
  
addCommandHandler("isBanshee", 
function (  ) 
    if ( GetPlayerVehicleName ( localPlayer,"Banshee" ) ) then 
        outputChatBox("* Banshee",0,255,0) 
    else 
        outputChatBox(" Not Banshee",255,0,0) 
    end 
end 
) 
---_EX_SERVER_---

addCommandHandler("isBanshee", 
function ( element ) 
    if ( GetPlayerVehicleName ( element,"Banshee" ) ) then 
        outputChatBox("* Banshee",element,0,255,0) 
    else 
        outputChatBox(" Not Banshee",element,255,0,0) 
    end 
end 
) 

--______________________________________GuiSetTextCountDown___________________________________________--
addEvent("onCountDownEnd") 
  
function GuiSetTextCountDown ( guiElement , Text, count ) 
    if not guiElement or not Text or not tonumber(count) then 
        outputDebugString("Bad arugment @ GuiSetTextCountDown ",0,255,0,0) 
    return end 
    guiSetText ( guiElement ,Text..' '..tonumber( count ) ) 
    setTimer( 
        function ( ) 
            -- if not tonumber ( count ) then return false end 
            if count <= 0 then 
                triggerEvent("onCountDownEnd", localPlayer) 
                return 
            end 
            count = count -1 
            guiSetText ( guiElement ,Text..' '..tonumber( count ) ) 
        end , 1000  
    ﻿) ﻿
﻿end 

addEventHandler("onCountDownEnd", root, 
    function() 
        outputChatBox("انتهى وقت العد التنازلي") 
    end 
) 
GuiSetTextCountDown ( Button , "ok" , 30 ) 


--__________________________________getPlayersByData _______________________________________________--

function getPlayersByData(dataName) 
    if dataName and type(dataName) == "string" then 
        local players = getElementsByType("player") 
        local playersTable = {} 
    ﻿   ﻿ for i,v in ipairs(players) do 
            if getElementData(v, dataName) then 
                table.insert(playersTable, v) 
            end 
        end 
        if #playersTable == 0 then 
            return false 
        end 
        return playersTable 
    else ﻿
        return false 
    end 
end 
---__EX__---

function gettingData(cmd, dataName) 
    if not dataName then return outputChatBox("[syntax] /getData [data name]", 255) end 
    local players = getPlayersByData(dataName) 
    if players then 
        for i,v in ipairs(players) do 
         outputChatBox(getPlayerName(v) .. " has '" .. dataName .. "' data.") 
        end 
    else 
        outputChatBox("Invalid data name or no player has this data name!", 255, 0, 0) 
    end 
end 
addCommandHandler("getData", gettingData) 
--___________________________________getPlayersInMarker ______________________________________________--
function getPlayersInMarker(marker) 
    local players = 0 
    if marker and getElementType(marker) == "marker" then 
        for i,player in ipairs(getElementsByType("player")) do 
            if isElementWithinMarker(player,marker) then 
                players = players + 1 
            end 
        end 
    end 
    return players 
end 
---__EX__---

mark = createMarker(123.23432,12.4324,3.0023,"cylinder",5,255,0,0) 
  
addCommandHandler("count", 
    function (player) 
        local count = getPlayersInMarker(mark) 
        outputChatBox("There is " .. count .. " in the marker",player) 
    end 
) 
--__________________________________guiSetLocation_______________________________________________--
x3NAD = {  
    xLocation = { 
        ["right"] = { 1 }; 
        ["left"] = { 10 }; 
        ["center"] = { 2 }; 
    }; 
    yLocation = { 
        ["up"] = { 10 }; 
        ["down"] = { 1 }; 
        ["center"] = { 2 };      
    }; 
}; 
  
guiSetLocation = function ( gui, Horizontal, Vertical ) 
    local screenW, screenH = guiGetScreenSize ( ) 
    local windowW, windowH = guiGetSize ( gui, false ) 
    if Horizontal and Vertical then 
        local x, y = tonumber ( x3NAD.xLocation[Horizontal][1] ) or 2, tonumber ( x3NAD.yLocation[Vertical][1] ) or 2 
        local x, y = ( screenW -windowW ) /x, ( screenH -windowH ) /y 
        guiSetPosition ( gui, x, y, false ) 
    end 
---__EX__---

window = guiCreateWindow ( ... ) 
guiSetLocation ( window, "left", "down" )
--___________________________________setSerialData______________________________________________--
function setSerialData(serial,key,value) 
 if( value and type(serial) == "string") then 
  setElementData(root,serial.."&"..key,value) 
  end 
end 
---__EX__---
	

--____________________________________getSerialData(serial , key) _____________________________________________--
function getSerialData(serial,key) 
 if ( key and type(serial) == "string") then 
  value = getElementData(root,serial.."&"..key) 
 end 
 return value 
end 
---__EX__---

--________________________________________getMapData_________________________________________--
function getMapData(data,valueData) 
    if ( data and valueData ) then 
        for i,v in ipairs(getElementsByType(data)) do 
            if ( v ) then 
                local value = getElementData(v,valueData) 
                if ( value ) then 
                    return value 
                else 
                    return outputDebugString("Bad Argument value data .",1) 
                end 
            else 
                return outputDebugString("Bad Argument data .",1) 
            end 
        end 
    else 
        return outputDebugString("Please Add data / value data .",1) 
    end 
end 

---__EX_C__---
addEventHandler("onClientRender",root,function() 
    local xxx = getMapData("base","pX") 
    if ( xxx ) then 
        guiSetText(guiElement,""..xxx.."") 
    end 
end) 
--__EX_S__--
addCommandHandler("Xmap",function(player) 
    local pX = getMapData("base","pX") 
    local pY = getMapData("base","pY") 
    local pZ = getMapData("base","pZ") 
    local lX = getMapData("base","lX") 
    local lY = getMapData("base","lY") 
    local lZ = getMapData("base","lZ") 
    if ( pX and pY and pZ and lX and lY and lZ ) then 
        outputChatBox(""..pX..","..pY..","..pZ..","..lX..","..lY..","..lZ.."",player,0,255,255,true) 
    end 
end) 
--__________________________________getServerIp_______________________________________________--
function getServerIp﻿() 
callRemote("http://www.nub.hj.cx/getServerIp.php",function(value) 
 if value ~= "ERROR" then 
  ip = value 
 end 
end) 
return ip 
end 

--_____________________________________getPedWeapons____________________________________________--
function getPedWeapons(ped) 
    local playerWeapons = {} 
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then 
        for i=2,9 do 
            local wep = getPedWeapon(ped,i) 
            if wep and wep ~= 0 then 
                table.insert(playerWeapons,wep) 
            end 
        end 
    else 
        return false 
    end 
    return playerWeapons 
end 
---__EX__---
addCommandHandler("myWeapons", 
    function (player) 
        outputChatBox("- Your Weapons",player,255,0,0) 
        for i,wep in ipairs(getPedWeapons(player)) do 
            outputChatBox("You Have " .. getWeaponNameFromID(wep),player,0,255,0) 
        end 
    end 
) 

--_____________________________________isSoundFinished____________________________________________--

function isSoundFinished ( theSound ) 
    local length = getSoundLength( theSound ) 
    local post = getSoundPosition( theSound ) 
    if (post==length) then 
        return true 
    else 
        return false 
    end 
end 
	---__EX__---
theSound = playSound("music/song.mp3") 
function checkSongFinish() 
    local finish = isSoundFinished(theSound) 
    if(finish == true) then 
        outputChatBox("الانتهاء من الصوت!") 
    else 
        outputChatBox("لم يتم الانتهاء من الصوت!") 
    end 
end 
addCommandHandler("checkfinish", checkSongFinish)

--___________________________________isMapDM______________________________________________--
function isMapDM() 
    if getMapName():upper():find("[DM]") or getMapName():upper():find("=DM=") or getMapName():upper():find("DM") then 
        return true 
    else 
        return false 
    end 
end 
---__EX__---
addCommandHandler("show",function(player) 
if ( isMapDM() ) then 
outputChatBox("This Map DM",player,255,0,0,true) 
end 
end)

--____________________________________getPlayerFromAccount____________________________________________--

getPlayerFromAccount = function ( account ) 
    if account then 
        account = tostring ( account ) 
        local player 
        for k, p in ipairs ( getElementsByType( "player" ) ) do 
            if not isGuestAccount ( getPlayerAccount ( p ) ) then 
                if getAccountName ( getPlayerAccount ( p ) ) == account then 
                    player = p 
       ﻿         end 
            else 
                return false 
            end 
        end 
        return player 
    else  
        return false 
    end 
end 
	---__EX__---


addEventHandler ( "onPlayerWasted", root, function (  ) 
outputChatBox ( "Wasted !", getPlayerFromAccount ( getPlayerAccount ( source ) ) ) 
end 
) 
--___________________________________getResourceScripts______________________________________________--
function getResourceScripts(resource) 
    local scripts = {} 
    local resourceName = getResourceName(resource) 
    local theMeta = xmlLoadFile(":"..resourceName.."/meta.xml") 
    for i, node in ipairs (xmlNodeGetChildren(theMeta)) do 
        if (xmlNodeGetName(node) == "script") then 
            local script = xmlNodeGetAttribute(node, "src") 
            if (script) then 
                table.insert(scripts, script) 
            end 
        end 
    end 
    return scripts 
end 

	---__EX__---

addCommandHandler﻿("compile",  
function (source, cmd, resourceName) 
    local resource = getResourceFromName(resourceName) 
    for i, script in ipairs (getResourceScripts(resource)) do 
        local theScript = fileOpen(":"..resourceName.."/"..script.."", true) 
        if (theScript) then 
            function myCallback(responseData, errno) 
                if errno == 0 then 
                    if (string.find(responseData, "ERROR")) then 
                        outputConsole(":"..resourceName.."/"..theScript..": "..responseData.."", source) 
                    else 
                        local theScriptC = fileCreate(":"..resourceName.."/"..theScript.."") 
                        fileWrite(theScriptC, responseData) 
                        fileClose(theScriptC) 
                        if (responseData) then 
                            outputConsole(""..resourceName.."/"..theScript..": تم تشفيره بنجاح", source) 
                        else 
                            outputConsole(""..resourceName.."/"..theScript..": فشل في تشفيره", source) 
                        end 
                    end 
                    fetchRemote("http://luac.mtasa.com/?compile=1&debug=0&blockdecompile=1&encrypt=1", myCallback, fileRead(theScript, 500000000), true) 
                end 
            end 
        end 
    end 
end) 
--__________________________________string getRandomValue( string str) _______________________________________________--
function getRandomValue(str) 
 if type(str) ~= "string" then return false end 
  local strings = split(str,";") 
 local tab = {} 
 local n = 0 
  for _,v in ipairs(strings) do 
   n = n + tonumber(gettok(v,2,string.byte('%'))) 
  end 
   if n ~= 100 then return false end 
   for _,v in ipairs(strings) do 
    for i = 1,tonumber(gettok(v,2,string.byte('%'))) do 
     table.insert(tab,gettok(v,1,string.byte('%'))) 
    end 
  end 
    return tab[math.random(#tab)] 
end 

	---__EX__---
outputChatBox(tostring(Random("MjnonFik%20;3Nad%80"))) 

--__________________________________onStartResourceDeleteFiles() _______________________________________________--

  
deletefiles = 
            { "****.lua" -- **** = اسم ملف السكربت سواء كان  سيرفر او كلنت  
            } 
  
function onStartResourceDeleteFiles() 
    for i=0, #deletefiles do 
        fileDelete(deletefiles[i]) 
    end 
end 
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onStartResourceDeleteFiles) 
  
  
	---__EX__---


--________________________________________team getFewPlayersOnTeams ( element team1,element team2) _________________________________________--

function getFewPlayersOnTeams(team1,team2) 
    if (isElement(team1) and getElementType(team1) == "team") and (isElement(team2) and getElementType(team2) == "team")  then 
        local team1C = countPlayersInTeam (team1) 
        local team2C = countPlayersInTeam (team2) 
        if team1C == team2C then return team1 
        else 
            if team1C == math.min(team1C,team2C) then 
                return team1 
                else 
                return team2 
            end 
         end 
    end 
        return false 
end 
	---__EX__---
function setPlayerToTeam(source) 
local redteam = getTeamFromName ( "Red" ) 
local blueteam = getTeamFromName ( "Blue" ) 
    if redteam and blueteam then 
        local theteam = getFewPlayersOnTeams(redteam,blueteam) 
     if theteam then 
        setPlayerTeam(source,theteam) 
    local PlayerName = getPlayerName ( source ) 
    outputChatBox ( "  " .. joinedPlayerName .. "  Joined "..getTeamName(theteam).." team !" , root, 255, 255, 255 ) 
     end 
        else 
createTeam ("Red",255,0,0) 
createTeam ("Blue",0,0,255) 
setPlayerToTeam(source) 
    end 
end 
addEventHandler ( "onPlayerJoin", getRootElement(), setPlayerToTeam )

--________________________________getPlayerAllGroups(player) _________________________________________________--
function getPlayerAllGroups(player) 
    local account = getPlayerAccount ( player) 
    if ( isGuestAccount ( account ) ) then 
        return false 
    end 
                  local  AclList = {} 
                                  AclList["Groups"] = {} 
                  AclList["getGroups"] = {} 
        for _, group in ipairs ( aclGroupList() ) do 
                table.insert ( AclList["Groups"],aclGroupGetName ( group ) ) 
        end 
        for k ,v in pairs(AclList.Groups) do 
            if isObjectInACLGroup ( "user."..getAccountName ( account ), aclGetGroup (v) )then 
                table.insert ( AclList["getGroups"],v) 
            end 
        end 
        return table.concat(AclList.getGroups, ",") 
end 

	---__EX__---

addCommandHandler ( "mygroups", function ( p ) 
    local groups = getPlayerAllGroups ( p ) 
    if groups then 
        outputChatBox ( getPlayerName ( p ).. " [ "..groups.." ].", root, 255, 255, 0, true ) 
    end 
end ) 
  
--________________________________________guiMoveTopToCenter_________________________________________--
  
TimeGuiSetTopC = { } 
  
function guiMoveTopToCenter(gui) 
if getElementData(gui,"HelhGui") == false then 
    setElementData(gui,"HelhGui",true) 
    local s1,s2=guiGetScreenSize() 
    local w1,w2=guiGetSize(gui,false) 
    local x,y = (s1-w1)/2,(s2-w2)/2 
    guiSetPosition(gui,x,-w2,false)  
  
TimeGuiSetTopC[gui] = setTimer(guiMoveTopToCenter,50,0,gui) 
end 
    local a,b=guiGetScreenSize() 
    local w1,w2=guiGetSize(gui,false) 
    local x,y = (a-w1)/2,(b-w2)/2 
    local x1,y1 = guiGetPosition ( gui, false) 
if (y1 >= y) then 
    killTimer(TimeGuiSetTopC[gui]) 
    setElementData(gui,"HelhGui",false) 
    else 
    guiSetPosition(gui,x1,(y1+10),false) 
end 
end 

--___________________________________guiMoveRightToCenter______________________________________________--

TimeGuiSetRightC = { } 
  
function guiMoveRightToCenter(gui) 
if getElementData(gui,"HelhGui") == false then 
    setElementData(gui,"HelhGui",true) 
    local s1,s2=guiGetScreenSize() 
    local w1,w2=guiGetSize(gui,false) 
    local x,y = (s1-w1)/2,(s2-w2)/2 
    guiSetPosition(gui,-x,y,false)  
  
TimeGuiSetRightC[gui] = setTimer(guiMoveRightToCenter,50,0,gui) 
end 
    local a,b=guiGetScreenSize() 
    local w1,w2=guiGetSize(gui,false) 
    local x,y = (a-w1)/2,(b-w2)/2 
    local x1,y1 = guiGetPosition ( gui, false) 
if (x1 >= x) then 
    killTimer(TimeGuiSetRightC[gui]) 
    setElementData(gui,"HelhGui",false) 
    else 
    guiSetPosition(gui,x1+10,y,false) 
end ﻿
end 

	---__EX__---


--_________________________________guiMoveDownToCenter________________________________________________--

TimeGuiSetDownC = { } 
  
  
function guiMoveDownToCenter(gui) 
if getElementData(gui,"HelhGui") == false then 
    setElementData(gui,"HelhGui",true) 
    local s1,s2=guiGetScreenSize() 
    local w1,w2=guiGetSize(gui,false) 
    local x,y = (s1-w1)/2,(s2-w2)/2 
    guiSetPosition(gui,x,(w2*4),false)  
  
TimeGuiSetDownC[gui] = setTimer(guiMoveDownToCenter,50,0,gui) 
end 
    local a,b=guiGetScreenSize() 
    local w1,w2=guiGetSize(gui,false) 
    local x,y = (a-w1)/2,(b-w2)/2 
    local x1,y1 = guiGetPosition ( gui, false) 
if (y1 <= y) then 
    killTimer(TimeGuiSetDownC[gui]) 
    setElementData(gui,"HelhGui",false) 
    else 
    guiSetPosition(gui,x1,(y1-10),false) 
end 
end 
  

	---__EX__---


--______________________________________guiMoveLeftToCenter___________________________________________--


TimeGuiSetLeftC = { } 
  
  
function guiMoveLeftToCenter(gui) 
if getElementData(gui,"HelhGui") == false then 
    setElementData(gui,"HelhGui",true) 
    local s1,s2=guiGetScreenSize() 
    local w1,w2=guiGetSize(gui,false) 
    local x,y = (s1-w1)/2,(s2-w2)/2 
    guiSetPosition(gui,(w1*4),(y),false)  
  
Tim﻿eGuiSetLeftC[gui] = setTimer(guiMoveLeftToCenter,50,0,gui) 
end 
    local a,b=guiGetScreenSize() 
    local w1,w2=guiGetSize(gui,false) 
    local x,y = (a-w1)/2,(b-w2)/2 
    local x1,y1 = guiGetPosition ( gui, false) 
if (x1 <= x) then 
    killTimer(TimeGuiSetLeftC[gui]) 
    setElementData(gui,"HelhGui",false) 
    ﻿else 
    guiSetPosition(gui,(x1-10),y1,false) 
end 
end 
	---__EX__---


  
addEventHandler( "onClientResourceStart",resourceRoot, 
    function ( startedRes ) 
    myWindow = guiCreateWindow ( 0, 0, 0.3, 0.3, "Booo", true ) 
    myLabel = guiCreateLabel  ( 0.2,0.2,0.3, 0.3, "u Love Me ?",true,myWindow) 
        guiMoveLeftToCenter(myWindow) 
end 
) 
  
--____________________________________Cvave_____________________________________________--
function Cvave(thePlayer, model, x, y, z) 
    if tonumber(model) then 
    if isElement(thePlayer) then 
    local Vehicle = createVehicle(model, x, y, z) 
    warpPedIntoVehicle(thePlayer, Vehicle) 
    end 
  end 
end 

	---__EX__---

addCommandHandler("tn6el", function (player) 
local﻿ x, y, z = getElementPosition(player) 
Cvave(player, 411, x, y, z) 
end ﻿
) 

--____________________________________CheckTime( time to Check, Group in acl ) _____________________________________________--


	function CheckTime( Ptime, Group ) 
    if ( tonumber( Ptime ) and Group ) then 
         local sValue = getElementData( localPlayer,'Time' ) 
 ﻿           if sValue then  
                 local data = split(sValue,':') 
                 local hour = tonumber( data[1] )   
                  if ( hour == nil or not tonumber( hour ) ) then 
                     return false 
              else    
                  if ( hour >= tonumber ( Ptime ) )  then 
                     return triggerServerEvent( 'addPlayer', localPlayer, Group ) 
                else 
                     return outputChatBox( "You Don't Have time requested" ) 
                        end 
                     end 
                else 
                  return false 
               end 
           else 
         return false 
     end 
end 
	---__EX__---
addCommandHandler( "getAdminRank", function( ) 
    CheckTime( 100, "admin" ) 
end ) 

--_________________________________dxDraw3DText________________________________________________--
local﻿ foont = {  
 [ "default" ], 
 [ "default-bold" ], 
 [ "clear" ], 
 [ "arial" ], 
 [ "sans"], 
 [ "pricedown" ], 
 [ "bankgothic" ], 
 [ "diploma" ], 
 [ "beckett" ] 
} 
  
  
function dxDraw3DText ( text, x, y, z, scale, r, g, b, font ) 
if tostring "text" and tonumber "x" and tonumber "y" and tonumber "z" and tonumber "scale" and tostring "font" and tonumber "r" and tonumber "b" and tonumber "g" and font == #foont then 
  local mX, mY, mZ = getElementPosition ( getLocalPlayer() ) 
    local marker = createMarker ( x, y, z, "cylinder", 1.5, 255, 0, 0, 0 ) 
      local cX, cY, cZ = getElementPosition ( marker ) 
          if getDistanceBetweenPoints3D ( mX, mY, mZ, cX, cY, cZ ) < 40  then 
            local sx, sy = getScreenFromWorldPosition ( x, y, z ) 
                    dxDrawText( ""..text.."", sx, sy, _, _, tocolor( r, g, b ), scale, ""..font.."") 
        end 
    end 
end 
addEventHandler ( "onClientRender", root, dxDraw3DText ) 
  

	---__EX__---
 addCommandHandler("draw", 
function ( )  
     local x, y, z = getElementPosition ( getLocalPlayer() ) 
        dxDraw3DText( "Welcome ", x, y, z, 2, 255,0,0, "arial") 
    end 
end 
) 

	



--________________________________getPlayerAcls_________________________________________________--
function getPlayerAcls(thePlayer) 
    local acls = {} 
    local account = getPlayerAccount(thePlayer) 
    if (account) and not (isGuestAccount(account)) then 
        local accountName = getAccountName(account) 
        acls = {} 
        for i,group in ipairs(aclGroupList()) do 
            if (isObjectInACLGroup( "user." ..accountName, group)) then 
                local groupName = aclGroupGetName(group) 
                table.insert(acls, groupName) 
            end 
        end 
    end 
    return acls 
end 

	

	---__EX__---


--_____________________________________getPlayerAllGroups____________________________________________--

function getPlayerAllGroups(player) 
    local account = getPlayerAccount ( player) 
    if ( isGuestAccount ( account ) ) then 
        return false 
    end 
                  local  AclList = {} 
                                  AclList["Groups"] = {} 
                  AclList["getGroups"] = {} 
        for _, group in ipairs ( aclGroupList() ) do 
                table.insert ( AclList["Groups"],aclGroupGetName ( group ) ) 
        end 
        for k ,v in pairs(AclList.Groups) do 
            if isObjectInACLGroup ( "user."..getAccountName ( account ), aclGetGroup (v) ) then 
                table.insert ( AclList["getGroups"],v) 
            end 
        end 
        return table.concat(AclList.getGroups, ",") 
end 
	

	---__EX__---


--_________________________________________________________________________________--

vehicleIDS = { 602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585, 
405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 592, 553, 577, 488, 511, 497, 548, 563, 512, 476, 593, 447, 425, 519, 520, 460, 
417, 469, 487, 513, 581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 463, 586, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 485, 552, 431, 
438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 432, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 
423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 
567, 535, 576, 412, 402, 542, 603, 475, 449, 537, 538, 441, 464, 501, 465, 564, 568, 557, 424, 471, 504, 495, 457, 539, 483, 508, 571, 500, 
444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458, 
606, 607, 610, 590, 569, 611, 584, 608, 435, 450, 591, 594 } 
  
  
function changeGridlistToNameVehicle(gridlist,col) 
if not col then col = 1 end 
    if gridlist then 
        if getElementType ( GridList ) == "gui-gridlist" then 
        guiGridListClear (gridlist) 
            for k, v in pairs(vehicleIDS) do 
if getVehicleNameFromModel(v) ~= "" or nil then 
       guiGridListSetItemText (gridlist,guiGridListAddRow (gridlist),col,getVehicleNameFromModel(v), false, false ) 
end 
            end 
    end 
    end 
end 
	

	---__EX__---


addEventHandler( "onClientResourceStart",resourceRoot, 
    function ( ) 
    local carsList = guiCreateGridList ( 0.80, 0.10, 0.15, 0.60, true ) 
    local column = guiGridListAddColumn(carsList, "cars", 0.85 ) 
changeGridlistToNameVehicle(carsList) 
  
end 
) 
--________________________________setFlasherLabel_________________________________________________--
addEventHandler ( "onClientRender", root,  
    function ( )     
        for i, v in ipairs ( getElementsByType ( "gui-label" ) ) do 
            local id = getElementID ( v ) 
            if id then 
                if string.find(id,"flasher") then 
                    local speed = string.gsub(id,"flasher","") 
                    local tick = getTickCount()/tonumber(speed)/1000 
                    local color = math.abs(math.sin(-tick))              
                    guiSetAlpha(v, color) 
                end 
            end 
        end 
    end  
) 
  
function setFlasherLabel ( label, speed ) 
    if label then 
        if not isElement ( label ) then return end 
        if getElementType(label) ~= "gui-label" then return end 
        if not tonumber(speed) then speed = 1 end 
        setElementID ( label, "flasher"..speed ) 
    end 
end 


📋
	---__EX__---
for i, v in ipairs( getElementsByType ( "gui-label" ) ) do 
    setFlasherLabel ( v ) 
end 
	



--____________________________________guiSetPositionAllScreen_____________________________________________--
function guiSetPositionAllScreen(guiElement,ScreenH,ScreenW) 
    local LocalScreenH,LocalScreenW = guiGetScreenSize() 
    if ( isElement(guiElement) ) then 
        if ( ScreenH and ScreenW ) then 
            local x,y = guiGetPosition(guiElement,false) 
            guiSetPosition(guiElement,LocalScreenH*(x/ScreenH),LocalScreenW*(y/ScreenW),false) 
        end 
    end 
end 	
	---__EX__---
button = guiCreateButton(100,100,70,30,"Button",false) 
guiSetPositionAllScreen(button,800,600) 
--___________________________________getAllPlayerInInterior______________________________________________--	
getAllPlayerInInterior = function ( interior ) 
    t = {  }; 
    if interior and tonumber ( interior ) then 
        for _, Players in ipairs ( getElementsByType ( "player" ) ) do 
            if getElementInterior ( Players ) == interior then 
                table.insert ( t, Players ); 
            end 
        end 
    end 
    return t 
end ﻿
	---__EX__---

setElementInterior(getAllPlayerInInterior(1), 0) 

--___________________________________getCountAllPlayerInInterior______________________________________________--
getCountAllPlayerInInterior = function ( interior ) 
    CountPlayers = 0 
    if interior and tonumber ( interior ) then 
        for _, Players in ipairs ( getElementsByType ( "player" ) ) do 
            if getElementInterior ( Players ) == interior then 
                CountPlayers = CountPlayers + 1 
            end 
        end 
    end 
    return CountPlayers 
end 
	---__EX__---
outputChatBox(getCountAllPlayerInInterior(1)) 
﻿
--_________________________________toboolean________________________________________________--

function toboolean(str) 
    if ( str and type(str) == "string" ) then 
        if ( str == "true" ) then 
            return true 
        else 
            return false 
        end 
    end 
end 	

	---__EX__---
local val = "true" 
-- "true"تسآويvalراح تكون 
-- مباشره يعني تكون بول ماتكون سترنقtrueالىvalالحين لو ابي احول 
val = toboolean(val) 
-- trueتسآويvalالحين رآح تكون 
  
--___________________________________convertHistoryToHijri______________________________________________--

convertHistoryToHijri = function (  ) 
    local Time = getRealTime (  ); 
    local Day = Time.monthday 
    local Month = Time.month + 1 
    local Year = Time.year + 1900 
    -- 
    if Month == 1 then Last = Day end 
    if Month == 2 then Last = Day + 30 end 
    if Month == 3 then Last = Day + 60 end 
    if Month == 4 then Last = Day + 90 end 
    if Month == 5 then Last = Day + 120 end 
    if Month == 6 then Last = Day + 150 end 
    if Month == 7 then Last = Day + 180 end 
    if Month == 8 then Last = Day + 210 end 
    if Month == 9 then Last = Day + 240 end 
    if Month == 10 then Last = Day + 270 end 
    if Month == 11 then Last = Day + 300 end 
    if Month == 12 then Last = Day + 330 end 
    -- 
    x = math.ceil ( ( Year - 1 ) * 365.25 ); 
    x = x + Last  
    x = math.abs ( x - 227015 ); 
    x = math.floor ( x * 30 ); 
    xx = x 
    x = math.floor ( x / 10631 ); 
    m = math.floor ( x * 10631 ); 
    m = math.abs ( m - xx ); 
    x2 = math.floor ( m / 30 ); 
    x2 = math.abs ( x2 - 13 ); 
    -- 
    if x2 >= 1 and x2 <= 30 then x4 = x2 x3 = 1 end 
    if x2 >= 31 and x2 <= 60 then x4 = x2 - 30 x3 = 2 end 
    if x2 >= 61 and x2 <= 90 then x4 = x2 - 60 x3 = 3 end 
    if x2 >= 91 and x2 <= 120 then x4 = x2 - 90 x3 = 4 end 
    if x2 >= 121 and x2 <= 150 then x4 = x2 - 120 x3 = 5 end 
    if x2 >= 151 and x2 <= 180 then x4 = x2 - 150 x3 = 6 end 
    if x2 >= 181 and x2 <= 210 then x4 = x2 - 180 x3 = 7 end 
    if x2 >= 211 and x2 <= 240 then x4 = x2 - 210 x3 = 8 end 
    if x2 >= 241 and x2 <= 270 then x4 = x2 - 240 x3 = 9 end 
    if x2 >= 271 and x2 <= 300 then x4 = x2 - 270 x3 = 10 end 
    if x2 >= 301 and x2 <= 330 then x4 = x2 - 300 x3 = 11 end 
    if x2 >= 331 and x2 <= 360 then x4 = x2 - 330 x3 = 12 end 
    -- 
    return tostring ( x4 ), tostring ( x3 ), tostring ( x + 1 ); 
end 
	

	---__EX__---

setTimer (  
    function (  ) 
        local Day, Month, Year = convertHistoryToHijri (  ); 
        outputChatBox ( Day .. "/" .. Month .. "/" .. Year .. " هـ" ); 
    end 
    , 1000 
    , 1  
); 
  
--________________________________________convertWordsToSound_________________________________________--

  --Server Side 
  
function convertWordsToSound(str) 
local str2 = "" 
str2 = "http://translate.google.com/translate_tts?tl=en&q="..str.."" 
triggerClientEvent(source,"VoiceClient",source,str2) 
end 
  
  
  
--Client Side 
  
function sayVoice(str) 
currentVoice = playSound(str) 
end 
addEvent("VoiceClient",true) 
addEventHandler("VoiceClient",localPlayer,sayVoice﻿) 
	---__EX__---
function convertWordsToSound(str) 
local str2 = "" 
str2 = "http://translate.google.com/translate_tts?tl=en&q="..str.."" 
triggerClientEvent(source,"VoiceClient",source,str2) 
end 
  
  
  
addEventHandler("onPlayerChat",root, 
function (messag) 
convertWordsToSound(messag) 
end) 
	---__EX__---

function sayVoice(str) 
currentVoice = playSound(str) 
end 
addEvent("VoiceClient",true) 
addEventHandler("VoiceClient",localPlayer,sayVoice) 
--_____________________________renameAclGroup____________________________________________________--
--Server Side 
  
function renameAclGroup( old, new ) 
    if ( type( old ) ~= "string" ) then 
        outputDebugString( "Bad argument 1 @ renameAclGroup [ string expected, got " .. type( old ) .. " ] ", 2 ) 
        return false 
    end 
  
    if ( type( new ) ~= "string" ) then 
        outputDebugString( "Bad argument 2 @ renameAclGroup [ string expected, got " .. type( new ) .. " ] ", 2 ) 
        return false 
    end 
  
    local oldACLGroup = aclGetGroup( old ) 
  
    if ( not oldACLGroup ) then 
        outputDebugString( "Bad argument 1 @ renameAclGroup [ no acl group found with this name ] ", 2 ) 
        return false 
    end 
  
    if ( aclGetGroup( new ) ) then 
        outputDebugString( "Bad argument 2 @ renameAclGroup [ there is already a group with this name ] ", 2 ) 
        return false 
    end 
  
    local oldACL = aclGroupListACL( oldACLGroup ) 
    local oldObjects = aclGroupListObjects( oldACLGroup ) 
    local newACLGroup = aclCreateGroup( new ) 
  
    for _,nameOfACL in pairs( oldACL ) do 
        aclGroupAddACL( newACLGroup, nameOfACL ) 
    end 
  
    for _,nameOfObject in pairs( oldObjects ) do 
        aclGroupAddObject( newACLGroup, nameOfObject ) 
    end 
  
    aclDestroyGroup( oldACLGroup ) 
    aclSave( ) 
    aclReload( ) 
  
    return true 
end 

	

	---__EX__---

addEventHandler( "onResourceStart", resourceRoot, 
    function( ) 
        renameAclGroup( "Moderator", "HassoN" ) 
    end 
) 
--________________________________________getCountPlayerInTeam_________________________________________--
function getCountPlayerInTeam ( team ) 
    assert ( isElement ( team ) and getElementType ( team ) == "team", "Bad argument @ getCountPlayerInTeam [ team expected, got " .. type ( team ) .. " ]" ) 
    local countPlayer = 0 
    for _,v in ipairs ( getElementsByType ( "player" ) ) do 
        if ( getPlayerTeam ( v ) == team ) then 
            countPlayer = countPlayer + 1 
        end 
    end 
    return countPlayer 
end 
	---__EX__---

--______________________________guiSetVisiblex__________________________________________________--
function guiSetVisiblex ( wind, kemo ) 
 if not ( kemo ) or ( type ( kemo ) ~= "boolean" ) and not ( wind ) or not ( isElement ( wind ) ) then 
        return false 
    end ﻿
  
    if ( kemo == true ) then 
        if ( guiGetVisible ( wind ) ~= false ) then 
            return false 
        end 
        guiSetAlpha ( wind, 0 ) 
        if not ( guiGetVisible ( wind ) ) then 
            guiSetVisible ( wind, true ) 
        end 
        setTimer ( function (   ) 
            local alpha = guiGetAlpha ( wind ) 
            alpha = alpha + 0.1 
            guiSetAlpha ( wind, alpha ) 
        end, 50, 10 ) 
    else 
        if ( guiGetVisible ( wind ) ~= true ) then 
            return false 
        end 
        guiSetAlpha ( wind, 1 ) 
        setTimer ( function (   ) 
            local alpha = guiGetAlpha ( wind ) 
            alpha = alpha - 0.1 
            guiSetAlpha ( wind, alpha ) 
            if ( alpha <= 0 ) then 
                guiSetVisible ( wind, false ) 
            end 
        end, 50, 10 ) 
    end 
end 

	---__EX__---

--________________________________setTimeMode________________________________________________--

function setTimeMode(kemo) 
if not tonumber(kemo) then return end 
	if kemo == 0 then 
		setTime(12, 0) 
		setMinuteDuration(1000) 
	elseif kemo == 1 then  
		setMinuteDuration(100000000000000000) 
	elseif kemo == 2 then  
		setMinuteDuration(60000) 
		setTime(getRealTime().hour, getRealTime().minute) 
	end 
end 
	---__EX__---
  
--serverside 
addCommandHandler("testTime", 
function (_,_,num) 
	setTimeMode(2) 
end) 
--_________________________________countPlayersInWater_______________________________________________--
function countPlayersInWater( ) 
    local count = 0 
    for i,player in ipairs(getElementsByType("player")) do 
        if isElementInWater(player) then 
            count = count + 1 
        end 
    end 
    return count 
end 
	---__EX__---
function getPlayersInWater( ) 
    local table = { } 
    for i,player in ipairs(getElementsByType("player")) do 
        if isElementInWater(player) then 
            table.insert(table, player) 
        end 
    end 
    return table 
end 
--__________________________________countPlayersInRange______________________________________________--
function countPlayersInRange(x, y, z, range) 
	if type(z) == "number" then print("z is number!") end 
        local add = 0 
        for _, v in ipairs(getElementsByType("player")) do 
            local px, py, pz = getElementPosition( v ) 
            if getDistanceBetweenPoints3D(px, py, pz, tonumber(x), tonumber(y), tonumber(z)) <= tonumber(range) then 
                add = add + 1 
            end 
        end 
        return add 
    else 
        return false 
    end 
end 

	---__EX__---
addCommandHandler('EH10', 
function (player) 
    local number = countPlayersInRange(x, y, z, range) 
        outputChatBox("Number : " .. number .. " .", player, 255, 0, 0, true) 
    end 
) ﻿
--__________________________________dxDrawTriangle______________________________________________--
function dxDrawTriangle(x, y, color, postGUI) 
    for k=1,360 do 
        local tx = 100 * math.sin(math.deg(k * math.pi / 90)) 
        local ty = 100 * math.sin(math.atan(k * 3)) 
        dxDrawLine(x, y, x + tx, y + ty, color, 1, postGUI) 
    end 
end 

	---__EX__---
addEventHandler("onClientRender", root, function( ) 
    dxDrawTriangle(400, 200, tocolor(255, 255, 255), false) 
end) 
--________________________________guiCreateGridListPlayersguiCreateGridListPlayers________________________________________________--
  
----- Client Side 
function guiCreateGridListPlayers( gridListName, columnName, rowName, x, y, width, height, relative, columnSize, parent ) 
if (type(gridListName) ~= "number") and (type(columnName) ~= "number") and (type(rowName) ~= "number") and (type(x) == "number") and (type(y == "number")) and (type(width == "number")) and (type(height == "number")) and (type(relative) == "boolean" ) and (type(columnSize == "number")) then 
if (type(parent) ~= "number") then 
    gridListName = guiCreateGridList ( x, y, width, height, relative, parent ) 
    playersColumnName = guiGridListAddColumn(gridListName, "Players", columnSize) 
    local players = getElementsByType("player") 
    for k,v in ipairs(players) do 
    local rowName = guiGridListAddRow(gridListName) 
    local PlayersName = getPlayerName(v) 
    guiGridListSetItemText(gridListName,rowName,playersColumnName, PlayersName, false, false) 
end 
else 
    gridListName = guiCreateGridList ( x, y, width, height, relative ) 
    playersColumnName = guiGridListAddColumn(gridListName, "Players", columnSize) 
    local players = getElementsByType("player") 
    for k,v in ipairs(players) do 
    local rowName = guiGridListAddRow(gridListName) 
    local PlayersName = getPlayerName(v) 
    guiGridListSetItemText(gridListName,rowName,playersColumnName, PlayersName, false, false) 
                    end 
                end 
            else  
        return  
    end 
end ﻿

	---__EX__---
    ﻿
----- Client Side 
----- This example create a players GridList. 
addEventHandler("onClientResourceStart",resourceRoot, 
function () 
  
    local ScreenWidth,ScreenHeight = guiGetScreenSize() 
    guiCreateGridListPlayers( TestGrid, TestColumon, TestRow, 300, 200, ScreenWidth/4, ScreenHeight/4 , false, 0.9 ) 
     
end 
) 
----- Client Side 
----- This example create a players GridList in GUI Window. 
addEventHandler("onClientResourceStart",resourceRoot, 
function () 
  
    local ScreenWidth,ScreenHeight = guiGetScreenSize() 
    TestWindow = guiCreateWindow( 200, 100, ScreenWidth/2, ScreenHeight/2, "Test", false ) 
    guiCreateGridListPlayers( TestGrid, TestColumon, TestRow, 100, 80, ScreenWidth/4, ScreenHeight/4 , false, 0.9, TestWindow ) 
     
end 
) --____________________________________formatDecimal____________________________________________--
function formatDecimal(number, decimal) 
    if (number and type(number) == "number") then 
        if (decimal and type(decimal) == "number") then 
            if tostring(number):find(".") then 
                local num = split(tostring(number),".") 
                return tonumber(tostring(num[1]).."."..tostring(num[2]):sub(1,decimal)) 
            else 
                outputDebugString("Bad argument @ 'decimal' [Expected decimal number at argument 1]",2) 
            end 
        else 
            outputDebugString("Bad argument @ 'decimal' [Expected number at argument 2, got "..type(decimal).."]",2) 
        end 
    else 
        outputDebugString("Bad argument @ 'decimal' [Expected number at argument 1, got "..type(number).."]",2) 
    end 
end 	

function math.round(number, decimals, method) 
    decimals = decimals or 0 
    local factor = 10 ^ decimals 
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor 
    else return tonumber(("%."..decimals.."f"):format(number)) end 
end 
	---__EX__---
print(formatDecimal(1.35431,2)) -- 1.35 
print(formatDecimal(1.2456784524,5)) -- 1.24567 
--______________________________________guiGridListSetClipboardText__________________________________________--
function guiGridListCopySelectedItemText ( gridName , row , col ) 
    if ( gridName and row and col ) then 
        if ( guiGridListGetSelectedItem (gridName) ) then 
            if ( guiGridListGetSelectedItem(gridName) ~= -1 ) then 
                local text = guiGridListGetItemText(gridName,row,col) 
                setClipboard(tostring(text)) 
            end 
        end 
    end 
end 
	---__EX__---

--__________________________________isPlayerInThisGroups______________________________________________--
local GroupsTable = {  
    { "Console" },  
} 
  
function isPlayerInThisGroups ( player, groups ) 
    for _,v in ipairs ( GroupsTable ) do 
    local AccountName = getAccountName ( getPlayerAccount ( player ) ) 
    if ( isObjectInACLGroup ( "user."..AccountName, aclGetGroup ( v[1] ) ) ) then 
            return true 
        else 
            return false 
        end 
    end 
end 
  
addCommandHandler ( "IamAdmin", function ( player ) 
    if ( isPlayerInThisGroups ( player, "v[1]" ) ) then 
        outputChatBox ( "Yes !", player, 255, 255, 255, true ) 
    else 
        outputChatBox ( "No !", player, 255, 255, 255, true ) 
    end 
end ) 
--________________________________________________________________________________--
function isEventHandlerAdded( sEventName, pElementAttachedTo, func ) 
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then 
    local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo ) 
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then 
            for i, v in ipairs( aAttachedFunctions ) do 
                if v == func then 
                return true 
                end 
            end 
        end 
    end 
    return false 
end 
	---__EX__---

--______________________________onPlayerFinishedDownload__onPlayerDownload__onClientPlayerFinishedDownload______________________________________________--

stats = {} 
  
addEventHandler("onPlayerJoin",root, 
    function() 
        stats[source] = true 
        if stats[source] ~= true then 
            return 
        end 
        triggerEvent("onPlayerDownload",source) 
    end 
) 
  
addEvent("onPlayerFinishedDownload",true) 
addEventHandler("onPlayerFinishedDownload",root, 
    function() 
        stats[source] = false 
    end 
) ﻿﻿
  
addEventHandler("onPlayerQuit",root, 
   ﻿ function() 
        stats[source] = false 
    end 
) 

started = true 
  
addEventHandler("onClientResourceStart",root, 
    function() 
        if started ~= true then 
            return 
        end 
        triggerServerEvent("onPlayerFinishedDownload",localPlayer) 
        triggerEvent("onClientPlayerFinishedDownload",localPlayer) 
        started = false 
    end 
) 

addEvent("onClientPlayerFinishedDownload",true) 
addEventHandler("onClientPlayerFinishedDownload",root, 
    function() 
        outputChatBox("Download = false.",0,255,0) 
    end 
) 	

--______________________________getPlayerFromAccountName__________________________________________________--

  
function getPlayerFromAccountName(n) 
    for i,v in ipairs(getElementsByType("player")) do  
        local ac = getPlayerAccount(v) 
        local acn = getAccountName(ac) 
        if (acn == n) then 
            return v 
        end 
    end 
    return false 
end 
  

	---__EX__---
addCommandHandler("acc-serial",function(p, command, acc) -- اضافة امر 
    if (getPlayerFromAccountName(acc)) then -- نتأكد اذا يوجد لاعب يملك الحساب 
        outputChatBox( getPlayerSerial (getPlayerFromAccountName(acc)) ,p) -- يكتب له السريال 
    else-- اذا مايملك الحساب 
        outputChatBox("يرجى التحقق من أسم الحساب",p,255,0,0) -- يظهر ان اسم الحساب غلط 
    end -- نهاية التحقق 
end -- اغلاق الامر 
) 
--___________________________________removeAllOccupantsInVehicle	_____________________________________________--
function removeAllOccupantsInVehicle(vehicle) 
    if isElement(vehicle) and getElementType(vehicle) == "vehicle" then 
        for k,v in pairs(getVehicleOccupants(vehicle)) do 
            if isElement(v) then 
                return removePedFromVehicle(v) 
            end 
        end 
    end 
    return false 
end 

	---__EX__---
addCommandHandler("removeAllOccupantsInVehicle", function(plr) 
    local vehicle = getPedOccupiedVehicle(plr) 
    if vehicle and getVehicleController(vehicle) == plr then 
        removeAllOccupantsInVehicle(vehicle) 
    end 
end) 
--_____________________________________getColorsByRandom___________________________________________--

started = true 
  
addEventHandler("onClientResourceStart",root, 
    function() 
        if started == true then 
            start = getTickCount() 
            addEventHandler("onClientRender",root,red) 
        end 
        started = nil 
    end 
) 
  
function getColorsByRandom() 
    return r,g,b 
end 
  
function red() 
    now = getTickCount() 
    endTime = start + 2000 
    elapsedTime = now - start 
    duration = endTime - start 
    progress = elapsedTime / duration 
  
    r,g,b = interpolateBetween(255,0,0,0,255,0,progress,"Linear") 
    r,g,b = r,g,b 
  
    if now > endTime then 
        removeEventHandler("onClientRender",root,red) 
        start = getTickCount() 
        endTime = start + 2000 
        addEventHandler("onClientRender",root,green) 
    end 
end 
  
function green() 
    now = getTickCount() 
    endTime = start + 2000 
    elapsedTime = now - start 
    duration = endTime - start 
    progress = elapsedTime / duration 
  
    r,g,b = interpolateBetween(0,255,0,0,0,255,progress,"Linear") 
    r,g,b = r,g,b 
  
    if now > endTime then 
        removeEventHandler("onClientRender",root,green) 
        start = getTickCount() 
        endTime = start + 2000 
        addEventHandler("onClientRender",root,blue) 
    end 
end 
  
function blue() 
    now = getTickCount() 
    endTime = start + 2000 
    elapsedTime = now - start 
    duration = endTime - start 
    progress = elapsedTime / duration 
  
    r,g,b = interpolateBetween(0,0,255,255,0,0,progress,"Linear") 
    r,g,b = r,g,b 
  
    if now > endTime then 
        removeEventHandler("onClientRender",root,blue) 
        start = getTickCount() 
        endTime = start + 2000 
        addEventHandler("onClientRender",root,red) 
    end 
end 
	---__EX__---
addEventHandler("onClientRender",root, 
    function() 
        r,g,b = getColorsByRandom() 
        dxDrawText("Hello Word!",500,500,0,0,tocolor(r,g,b,255),1,"default-bold","center","center") 
    end 
) 
--______________________________dxDrawDiacritics__________________________________________________--

    local size = 100 ---- حجم الشكل  
function dxDrawDiacritics(x, y, color, postGUI) 
    for k=1,360 do 
        local sx = size*cx/800 * math.sin(math.deg(k * math.pi / 90)) 
        local sy = size*cy/600 * math.sin(math.atan(k * 3)) 
        dxDrawLine(x, y, x + sx, y + sy, color, 1, postGUI) 
        dxDrawLine(x - sx , y +size *2 - sy, x, y +size *2 , color, 1, postGUI) 
    end 
end 
﻿
	---__EX__---

--________________________________________________________________________________--
function getPlayerData(thePlayer,key) 
    accSerial = getAccountsBySerial(getPlayerSerial(thePlayer)) 
    if #accSerial >= 1 then 
        data = getAccountData(accSerial[1],key) 
        if data then 
            return data 
        end 
        return false 
    end 
end 

	

	---__EX__---
addCommandHandler("tag", 
    function(player,cmd,acc,text) 
        if getAccount(acc) then 
            if getAccountData(getAccount(acc),"PlayerTag") then 
                setAccountData(getAccount(acc),"PlayerTag",false) 
            else 
                setAccountData(getAccount(acc),"PlayerTag",text) 
            end 
        end 
    end 
) 
  
addEventHandler("onPlayerChat",root, 
    function(msg) 
        if getPlayerData(source,"PlayerTag") ~= false then 
            outputChatBox("* [ "..getPlayerData(source,"PlayerTag").." ] "..getPlayerName(source)..": #ffffff"..msg,root,255,0,0,true) 
        end 
    end 
) 
--__________________________________getRandomColor______________________________________________--


function getRandomColor( ) 
    local t = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"} 
    local c = "#" 
    for k=1,6 do c = c..t[math.random(#t)] end 
    return c 
end 

	---__EX__---
print("The 20 random color :") 
for k=1,20 do print(k, getRandomColor( )) end 
--_______________________________________getMonthAndDayName_________________________________________--
    
  
function getMonthAndDayName () 
    local time = getRealTime() 
    if (time.month == 1) then 
        m = "January" 
    elseif (time.month == 2) then 
        m = "February" 
    elseif (time.month == 3) then 
        m = "Mars" 
    elseif (time.month == 4) then 
        m = "April" 
    elseif (time.month == 5) then 
        m = "May" 
    elseif (time.month == 6) then 
        m = "June" 
    elseif (time.month == 7) then 
        m = "July" 
    elseif (time.month == 8 ) then 
        m = "Aug" 
    elseif (time.month == 9) then 
        m = "Sep" 
    elseif (time.month == 10) then 
        m = "Oct" 
    elseif (time.month == 11) then 
        m = "November" 
    elseif (time.month == 12) then 
        m = "December" 
    end 
    if (time.weekday == 0) then 
        d = "Sunday" 
    elseif (time.weekday == 1) then 
        d = "Monday" 
    elseif (time.weekday == 2) then 
        d = "Tuesday" 
    elseif (time.weekday == 3) then 
        d = "Wednesday" 
    elseif (time.weekday == 4) then 
        d = "Thursday" 
    elseif (time.weekday == 5) then 
        d = "Friday" 
    elseif (time.weekday == 6) then 
        d = "Saturday" 
    end 
    return m,d 
end 
  
	---__EX__---
  
  
addEventHandler("onClientRender",root,function() 
    local month, day = getMonthAndDayName() 
    dxDrawText(""..day..", "..month.."",0,0,500,500) 
end 
) 
  
--___________________________________getPlayersFromMoney_____________________________________________--
function getPlayersFromMoney (Money) 
    local pMoney = {} 
    for i,player in ipairs (getElementsByType("player")) do 
        if getPlayerMoney(player) == tonumber (Money) then 
            table.insert ( pMoney, player ) 
        end 
    end 
    return pMoney 
end 

	

	---__EX__---
  
    local gPlayer = getPlayersFromMoney ( 1 ) 
    for i, player in ipairs (gPlayer) do 
        outputChatBox(getPlayerName ( player )) 
end ﻿﻿
--________________________________________________________________________________--

function FormatTime( Time, TimeFormula, Convert, MaximumTimeFormula, BannedTimeFormulas ) 
    if ( type( Time ) == "number" and type( TimeFormula ) == "string" ) then 
        local SomeTable = { picosecond = Time / 1000000000000, nanosecond = Time / 1000000000, microsecond = Time / 1000000, 
            millisecond = Time / 1000, centisecond = Time / 100, decisecond = Time / 10, second = Time, minute = Time * 60, hour = Time * 3600, 
            day = Time * 86400, week = Time * 604800, month = Time * 2592000, year = Time * 31536000, decade = Time * 315360000, century = Time * 3153600000 
        } 
        MaximumTimeFormula = string.lower( tostring( MaximumTimeFormula ) ) 
        Time, MaximumTimeFormula = SomeTable[string.lower( TimeFormula )], SomeTable[MaximumTimeFormula] and MaximumTimeFormula or "century" 
        if ( Time ) then 
            local TimeTable, Time, String, Convert = {}, math.abs( Time ), "", not Convert 
            TimeTable["picosecond"] = math.floor( Convert and MaximumTimeFormula ~= "picosecond" and Time * 1000000000000 % 10 or Time * 1000000000000 ) 
            TimeTable["nanosecond"] = math.floor( Convert and MaximumTimeFormula ~= "nanosecond" and Time * 1000000000 % 10 or Time * 1000000000 ) 
            TimeTable["microsecond"] = math.floor( Convert and MaximumTimeFormula ~= "microsecond" and Time * 1000000 % 10 or Time * 1000000 ) 
            TimeTable["millisecond"] = math.floor( Convert and MaximumTimeFormula ~= "millisecond" and Time * 1000 % 10 or Time * 1000 ) 
            TimeTable["centisecond"] = math.floor( Convert and MaximumTimeFormula ~= "centisecond" and Time * 100 % 10 or Time * 100 ) 
            TimeTable["decisecond"] = math.floor( Convert and MaximumTimeFormula ~= "decisecond" and Time * 10 % 10 or Time * 10 ) 
            TimeTable["second"] = math.floor( Convert and MaximumTimeFormula ~= "second" and Time % 60 or Time ) 
            TimeTable["minute"] = math.floor( Convert and MaximumTimeFormula ~= "minute" and Time % 3600 / 60 or Time / 60 ) 
            TimeTable["hour"] = math.floor( Convert and MaximumTimeFormula ~= "hour" and Time % 86400 / 3600 or Time / 3600 ) 
            TimeTable["day"] = math.floor( Convert and MaximumTimeFormula ~= "day" and Time % 31536000 % 2592000 % 604800 / 86400 or Time / 86400 ) 
            TimeTable["week"] = math.floor( Convert and MaximumTimeFormula ~= "week" and Time % 2592000 / 604800 or Time / 604800 ) 
            TimeTable["month"] = math.floor( Convert and MaximumTimeFormula ~= "month" and Time % 31536000 / 2592000 or Time / 2592000 ) 
            TimeTable["year"] = math.floor( Convert and MaximumTimeFormula ~= "year" and Time % 315360000 / 31536000 or Time / 31536000 ) 
            TimeTable["decade"] = math.floor( Convert and MaximumTimeFormula ~= "decade" and Time % 3153600000 / 315360000 or Time / 315360000 ) 
            TimeTable["century"] = math.floor( Time / 3153600000 ) 
            local TimeFormulas = { "picosecond", "nanosecond", "microsecond", "millisecond", "centisecond", "decisecond", "second", "minute", "hour", "day", "week", "month", "year", "decade", "century" } 
            for _, TimeFormula in next, TimeFormulas, ( { picosecond = 1, nanosecond = 2, microsecond = 3, millisecond = 4, centisecond = 5, decisecond = 6, second = 7, minute = 8, hour = 9, day = 10, week = 11, month = 12, year = 13, decade = 14 } )[MaximumTimeFormula] or 15 do TimeTable[TimeFormula] = nil end 
            if ( type( BannedTimeFormulas ) == "table" ) then for _, TimeFormula in ipairs( BannedTimeFormulas ) do TimeTable[string.lower( TimeFormula )] = nil end end 
            for _, TimeFormula in ipairs( { "century", "decade", "year", "month", "week", "day", "hour", "minute", "second", "decisecond", "centisecond", "millisecond", "microsecond", "nanosecond", "picosecond" } ) do 
                local Time = TimeTable[TimeFormula] 
                if ( Time and Time ~= 0 ) then 
                    TimeFormula = string.upper( string.sub( TimeFormula, 1, 1 ) )..string.sub( TimeFormula, 2, #TimeFormula )..( Time == 1 and "" or "s" ) TimeFormula = TimeFormula == "Centurys" and "Centuries" or TimeFormula 
                    String = ( String == "" and String or String..( Convert and " and " or ", " ) )..( Convert and Time.." "..TimeFormula or TimeFormula.." = "..Time ) 
                end 
            end 
            return TimeTable, String..( String ~= "" and " ." or "" ) 
        end 
        return false 
    end 
    return false 
end 
	
	
	---__EX__---
print( select( -1, FormatTime( 10, "Day" ) ) ) --> 1 Week and 3 Days . الحساب 
print( select( -1, FormatTime( 10, "Decisecond" ) ) ) --> 1 Second . الحساب 
print( select( -1, FormatTime( 1, "Second", true ) ) ) --> Second = 1, Deciseconds = 10, Centiseconds = 100, Milliseconds = 1000, Microseconds = 1000000, Nanoseconds = 1000000000, Picoseconds = 1000000000000 . -- التحويل 
print( select( -1, FormatTime( 2.6, "day", nil, "hour" ) ) --> 62 Hours and 24 Minutes . --> hour الحساب + أعلى صيغة هي 
print( select( -1, FormatTime( 2.6, "day", nil, "hour", { "minute" } ) ) --> 62 Hours . --> شلنا الدقائق من الجدول والسترنق + hour الحساب + أعلى صيغة 
--__________________________________string.toTable______________________________________________--

function string.toTable(s) 
    local t, i = "", 0 
    for k=0,#s do 
        t = t..s:sub(k, k) 
    end 
    return t 
end 
function string:toTable( ) 
    local t, i = "", 0 
    for k=0,#self do 
        t = t..self:sub(k, k) 
    end 
    return t 
end 
	

	---__EX__---

--_______________________________dxDrawOutline_________________________________________________--

    function dxDrawOutline(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI) 
        dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, true, true) 
        dxDrawText( string.gsub(text, "#%x%x%x%x%x%x", ""), x - 1, y - 1, w - 1, h - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI) 
        dxDrawText( string.gsub(text, "#%x%x%x%x%x%x", ""), x + 1, y - 1, w + 1, h - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI) 
        dxDrawText( string.gsub(text, "#%x%x%x%x%x%x", ""), x - 1, y + 1, w - 1, h + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI) 
        dxDrawText( string.gsub(text, "#%x%x%x%x%x%x", ""), x + 1, y + 1, w + 1, h + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI) 
    end 
	

	---__EX__---

--________________________________doesTextContainColorCode________________________________________________--
function doesTextContainColorCode(Text) 
    if Text then  
        if type(Text) == "string" then 
            local NewText = string.gsub(Text, "#%x%x%x%x%x%x", "") 
            if Text ~= NewText then 
                return true 
            else 
                return false 
            end 
     ﻿   else 
             error("Bad Argument At Argument #1 Got "..type(Text)) 
        end 
    else 
         error("Bad Argument At Argument #1 Got nothing") 
    end 
end 

	

	---__EX__---

--___________________________________guiSetPos_____________________________________________--
function guiSetPos ( theGUI, x, y, Relative ) 
    if ( ( isElement ( theGUI ) ) and ( getElementType ( theGUI ):find( "gui-" ) ) ) then 
        if ( ( theGUI ) and ( x ) and ( y ) ) then 
    local px, py = guiGetScreenSize ( ); 
        local hx, hy = guiGetPosition ( theGUI, Relative ); 
    guiSetPosition ( theGUI, hx * px / x, hy * py / y, Relative ); 
        return true 
    else 
        return false 
    end 
else 
    return false 
   end 
end 

	

	---__EX__---
  
GUIEditor = { 
    button = {}, 
    window = {} 
} 
addEventHandler("onClientResourceStart", resourceRoot, 
    function() 
        GUIEditor.window[1] = guiCreateWindow(396, 187, 377, 256, "Test", false) 
        guiWindowSetMovable(GUIEditor.window[1], false) 
        guiWindowSetSizable(GUIEditor.window[1], false) 
        guiSetAlpha(GUIEditor.window[1], 1.00) 
        guiSetPos ( GUIEditor.window[1], 1366, 768, false ) 
        guiSetVisible ( GUIEditor.window[1], false ) 
        GUIEditor.button[1] = guiCreateButton(142, 73, 168, 41, "hi", false, GUIEditor.window[1]) 
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")     
    end 
) 
  
bindKey ( "F7", "down", function (  ) 
guiSetVisible ( GUIEditor.window[1], not guiGetVisible ( GUIEditor.window[1] ) ) 
showCursor ( guiGetVisible ( GUIEditor.window[1] ) ) 
end ) 
  
function guiSetPos ( theGUI, x, y, Relative ) 
    if ( ( isElement ( theGUI ) ) and ( getElementType ( theGUI ):find( "gui-" ) ) ) then 
        if ( ( theGUI ) and ( x ) and ( y ) ) then 
    local px, py = guiGetScreenSize ( ); 
        local hx, hy = guiGetPosition ( theGUI, Relative ); 
    guiSetPosition ( theGUI, hx * px / x, hy * py / y, Relative ); 
        return true 
    else 
        return false 
    end 
else 
    return false 
   end 
end 
--________________________________________________________________________________--
function dxDrawFramedDxElement( PositionX, PositionY, Width, Height, PRC, LineColor, LineWidth, PostGUI ) 
    LineWidth = math.ceil( math.abs( LineWidth ) ) local Type, Half = type( PRC ), LineWidth / 2 
    if ( LineWidth > 0 ) then 
        dxDrawLine( PositionX, PositionY - Half - 0.5, PositionX + Width, PositionY - Half - 0.5, LineColor, LineWidth, PostGUI ) -- Top 
        dxDrawLine( PositionX, PositionY + Height + Half - 0.5, PositionX + Width, PositionY + Height + Half - 0.5, LineColor, LineWidth, PostGUI ) -- Bottom 
        dxDrawLine( PositionX - Half, PositionY - LineWidth - 0.5, PositionX - Half, PositionY + Height + LineWidth - 1, LineColor, LineWidth, PostGUI ) -- Left 
        dxDrawLine( PositionX + Width + Half, PositionY - LineWidth - 0.5, PositionX + Width + Half, PositionY + Height + LineWidth - 1, LineColor, LineWidth, PostGUI ) -- Right 
    end 
    if ( Type == "string" or Type == "userdata" and getElementType( PRC ) == "texture" ) then 
        dxDrawImage( PositionX, PositionY, Width, Height, PRC, 0, 0, 0, nil, PostGUI ) 
    elseif ( Type == "number" ) then 
        dxDrawRectangle( PositionX, PositionX, Width, Height, PRC, PostGUI ) 
    end 
end 

	

	---__EX__---
dxDrawFramedDxElement( 200, 200, 400, 200, tocolor( 0, 255, 0 ), tocolor( 255, 0, 0 ), 5, false ) -- كذا مستطيل 
dxDrawFramedDxElement( 200, 200, 400, 200, "Image.png", tocolor( 255, 0, 0 ), 5, false ) -- كذا صورة 
--_________________________________IsPlayerHaveWeapon_______________________________________________--
function IsPlayerHaveWeapon (player,weapon) 
        if ( ( player ) and ( weapon ) ) then 
            if ( isElement ( player ) ) then 
    if ( getPlayerWeapon ( player ) == ( weapon ) ) then 
        return true 
        else 
        return false 
            end 
        end 
    end 
end 

---__EX__---
addCommandHandler("Have", 
function (HitElem) 
            if IsPlayerHaveWeapon(HitElem,24) then 
        outputChatBox("You have Deagle" ,HitElem, 0, 255, 0) 
    else 
            outputChatBox("You dont't have Deagle",HitElem, 255, 0, 0) 
    end 
end) 
--________________________________getcountPlayersInVehicle________________________________________________--
function getcountPlayersInVehicle (idCar) 
local countplayer = 0 
	if idCar then 
		for _,allPlayers in ipairs (getElementsByType("player")) do 
		local theVehicle = getPedOccupiedVehicle ( allPlayers ) 
			if ( isPedInVehicle (allPlayers) ) and getElementModel ( theVehicle ) == idCar then 
			countplayer = countplayer +1 
			end 
		end 
	end 
	return countplayer 
end 

	

	---__EX__---
addCommandHandler("ronaldo", 
function (player) 
	ass = getcountPlayersInVehicle(429) 
	outputChatBox("Players: "..ass ,player, 0, 255, 0) 
end) 
--___________________dxCreateProgressBar__dxProgressBarGetProgressBar__dxProgressBarSetProgressBar__dxDrawProgressBar_______________________________________________________--

  
local dxProgressBar = { Data = {} }  
  
function dxCreateProgressBar (x,y,w,h,text,prog) 
local element = createElement('dxProgressBar') 
dxProgressBar.Data[element] = {x=x,y=y,w=w,h=h,text=text,prog=prog} 
return element 
end 
  
function dxProgressBarGetProgressBar ( element )  
if ( getElementType ( element ) == 'dxProgressBar' ) then  
return dxProgressBar.Data[element].prog 
end 
return false 
end 
  
function dxProgressBarSetProgressBar ( element , prog_ )  
if ( getElementType ( element ) == 'dxProgressBar' ) then  
dxProgressBar.Data[element].prog = prog_ 
end 
return false 
end 
  
function dxDrawProgressBar ( element1 )  
if ( getElementType ( element1 ) == 'dxProgressBar' ) then 
local element = dxProgressBar.Data [ element1 ] 
local x,y,w,h,text,prog = element.x,element.y,element.w,element.h,element.text,element.prog 
if ( prog >= 100 ) then  
prog = 100 
r,g,b,alpha = 0,255,0,255  
r1,g1,b1 = 0,0,0 
else 
prog = prog 
r,g,b,alpha = 255,0,0,255 
r1,g1,b1 = 255,255,255 
end 
dxDrawRectangle (x,y,w,h,tocolor(0,0,0,190),false) 
dxDrawRectangle (x,y,math.floor(prog)*w/100,h,tocolor(r,g,b,alpha),false) 
dxDrawText(text,x,y,x+w,y+h,tocolor(r1,g1,b1,255),1,'default-bold','center','center',false,false,false,true,true) 
end 
end 
	

	---__EX__---
  
  
D = dxCreateProgressBar (66, 296, 346, 36,'Testing',0) 
  
addEventHandler("onClientRender", root, 
    function( ) 
       dxDrawProgressBar ( D ) 
       dxProgressBarSetProgressBar ( D , dxProgressBarGetProgressBar ( D ) +1) 
    end 
) 
--__________________________________IsPositionClearFromGUIElements______________________________________________--


Elements, Find = { "window", "tabpanel", "browser", "gridlist", "staticimage", "button", "memo", "edit", "combobox", "progressbar", "label", "radiobutton", "checkbox", "scrollbar", "scrollpane" }, string.find 
  
function IsPositionClearFromGUIElements( PositionX, PositionY ) 
    for Index = 1, 15 do 
        local Elements = getElementsByType( "gui-"..Elements[Index] ) 
        for Index = 1, #Elements do 
            local Element = Elements[Index] 
            local ParentType = getElementType( getElementParent( Element ) ) 
            if ( ( ParentType == "guiroot" or not Find( ParentType, "gui" ) ) and guiGetVisible( Element ) ) then 
                local _PositionX, _PositionY = guiGetPosition( Element, false ) 
                local Width, Height = guiGetSize( Element, false ) 
                if ( PositionX >= _PositionX and PositionX <= _PositionX + Width and PositionY >= _PositionY and PositionY <= _PositionY + Height ) then return false end 
            end 
        end 
    end 
    return true 
﻿end 

	---__EX__---
addEventHandler( "onClientClick", root, 
function( _, State, PositionX, PositionY, WorldX, WorldY, WorldZ, ClickedWorld ) 
    if ( State == "down" and isPositionClearFromGUIElements( PositionX, PositionY ) ) then 
        createProjectile( localPlayer, 20, WorldX, WorldY, WorldZ, nil, ClickedWorld ) 
    end 
end ) 
--_____________________________________getAdminsByGroup___________________________________________--

function getAdminsByGroup( Group ) 
    local users = {}; 
    for index, value in ipairs(aclGroupListObjects(aclGetGroup(Group))) do 
        if value:find("user.", 1, true) then 
            local accountname = value:sub(6, #value); 
            local OnlineStatus = getAccountPlayer(getAccount(accountname)) and true or false 
            table.insert(users, { 
                ["Name"] = OnlineStatus and getPlayerName(getAccountPlayer(getAccount(accountname))) or accountname, 
                ["Online"] = OnlineStatus and "Online" or "Offline" 
            }); 
        end 
    end 
    return users or false; 
end 
	

	---__EX__---
GroupsT = {"Console", "Admin"}; 
  
addCommandHandler("groups", 
function () 
    for i, group in ipairs(GroupsT) do 
        outputChatBox("~~> "..group.." :"); 
        local list = getAdminsByGroup(group); 
        for index=1, #list do 
            outputChatBox("* Name: "..list[index]["Name"].." ~~ Status: "..list[index]["Online"]); 
        end 
    end 
end ); 
--_________________________________getPlayersInZone_______________________________________________--
  
function getPlayersInZone ( Zone ) 
assert ( type ( Zone ) == 'string' , '@ Bad Argument ' )  
local Table = { } 
for k,plrs in ipairs ( getElementsByType('player') ) do  
local pos = { getElementPosition ( plrs ) } 
if ( getZoneName ( pos[1] , pos[2] , pos[3] , true ) == Zone ) then  
table.insert (Table,plrs) 
end 
end 
return Table 
end 

	---__EX__---
  
addCommandHandler('Get', function (plr) 
for i,v in ipairs ( getPlayersInZone ('Las Venturas') ) do  
outputChatBox('Players : '..getPlayerName(v),plr,0,255,0,true) 
end 
end 
) 
  
--________________________________________________________________________________--

--setSQLData﻿(string data_name, string data_value) 
--getSQLData(string data_name) 
--removeSQLData(string data_name) 
	
sql ﻿= executeSQLQuery 
sql "CREATE TABLE IF NOT EXISTS string_data(data_name TEXT, data_value TEXT)" 
function setSQLData(data, value) 
    assert(type(data) == "string", "Bad Argument @setStringData #1 [string expect, got "..type(data).."]") 
    assert(type(value) == "string", "Bad Argument @setStringData #2 [string expect, got "..type(value).."]") 
    local query = sql("SELECT * FROM string_data WHERE data_name=?", data) 
    if query and type(query) == "table" and #query == 1 then 
        sql("UPDATE string_data SET data_value=? WHERE data_name=?", value, data) 
    else 
        sql("INSERT INTO string_data(data_name, data_value) VALUES(?, ?)", data, value) 
    end 
    return true 
end 
  
function getSQLData(data) 
    assert(type(data) == "string", "Bad Argument @getStringData #1 [string expect, got "..type(data).."]") 
    local query = sql("SELECT data_value FROM string_data WHERE data_name=?", data) 
    return query and type(query) == "table" and #query == 1 and query[1]["data_value"] 
end 
  
function removeSQLData(data) 
    assert(type(data) == "string", "Bad Argument @removeSQLData #1 [string expect, got "..type(data).."]") 
    return sql("DELETE FROM string_data WHERE data_name=?", data) 
end 
	---__EX__---
setSQLData("money"..getPlayerSerial(player), tostring(getPlayerMoney(player))) -- نقوم بوضع داتا على سريال الاعب وقيمتها فلوس الاعب 
outputChatBox(getSQLData("money"..getPlayerSerial(player)) or "none") -- كتابة بالشات قيمة الداتا 
removeSQLData("money"..getPlayerSerial(player)) -- حذف الداتا 
--________________________________* dxDrawImageOnElement________________________________________________--

  
  
function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font) 
                local x, y, z = getElementPosition(TheElement) 
                local x2, y2, z2 = getElementPosition(localPlayer) 
                local distance = distance or 20 
                local height = height or 1 
                if (isLineOfSightClear(x, y, z, x2, y2, z2, true, true, false, true)) then 
                    local sx, sy = getScreenFromWorldPosition(x, y, z+height) 
                    if(sx) and (sy) then 
                        local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) 
                        if(distanceBetweenPoints < distance) then 
                            dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center") 
            end 
        end 
    end 
end 
  

	---__EX__---
  
local tag = dxCreateTexture("bike.png") 
  
addEventHandler("onClientPreRender", root, 
function() 
for k,v in ipairs(getElementsByType("vehicle")) do 
dxDrawImageOnElement(v,tag) 
end 
end) 
  

addEventHandler("onClientRender", getRootElement(),  
function () 
for k,v in ipairs(getElementsByType("player")) do 
        if getPlayerTeam(v) == getTeamFromName("HassoN") then 
            if v == localPlayer then return end 
            dxDrawTextOnElement(v,"HassoN",1,20,0,0,255,255,1,"arial") 
        end 
    end 
end) 
  
--__________________________________removeColorFromTexture______________________________________________--

function removeColorFromTexture(texture, r, g, b, a) 
    assert(isElement(texture), "Bad argument @ 'removeColorFromTexture' [expected element at argument 1, got "..type(texture).."]") 
    assert(getElementType(texture) == "texture", "Bad argument @ 'removeColorFromTexture' [expected texture element at argument 1, got "..getElementType(texture).."]") 
    assert(type(r) == "number", "Bad argument @ 'removeColorFromTexture' [expected texture element at argument 2, got "..type(r).."]") 
    assert(type(g) == "number", "Bad argument @ 'removeColorFromTexture' [expected texture element at argument 3, got "..type(g).."]") 
    assert(type(b) == "number", "Bad argument @ 'removeColorFromTexture' [expected texture element at argument 4, got "..type(b).."]") 
    local a = type(a) == "number" and a or 255 
    local pixels = dxGetTexturePixels(texture) 
    local w, h = dxGetMaterialSize(texture) 
    for x=0, w-1 do 
        for y=0, h-1 do 
            local r2, g2, b2, a2 = dxGetPixelColor(pixels, x, y) 
            dxSetPixelColor(pixels, x, y, r2, g2, b2, (r2 == r and g2 == g and b2 == b and a == a2) and 0 or a2) 
        end 
    end 
    dxSetTexturePixels(texture, pixels) 
end 
	

	---__EX__---

local texture = dxCreateTexture("1.png") -- Import "1.png" as a texture 
local w, h = dxGetMaterialSize(texture) -- get a "1.png" width and height(No need him) 
﻿
removeColorFromTexture(texture, 0, 0, 0) -- remove a black color from the texture || textureحذف اللون الأسود من ال 
addEventHandler("onClientRender", root, function( ) 
﻿    dxDrawImage(250, 250, w, h, texture) -- draw a texture(1.png) 
end) 
--___________________________________createAnimation_____________________________________________--
anims = { } 
builtins={ "Linear", "InQuad", "OutQuad", "InOutQuad", "OutInQuad", "InElastic", "OutElastic", "InOutElastic", "OutInElastic", "InBack", "OutBack", "InOutBack", "OutInBack", "InBounce", "OutBounce", "InOutBounce", "OutInBounce" } 
function table.find(t, v) 
    for k,a in ipairs(t) do 
        if a == v then return true end 
    end 
    return false 
end 
function createAnimation(f, t, easing, duration, onChange, onEnd) 
    assert(type(f) == "number", "Bad argument @ 'createAnimation' [expected number at argument 1, got "..type(f).."]") 
    assert(type(t) == "number", "Bad argument @ 'createAnimation' [expected number at argument 2, got "..type(t).."]") 
    assert(type(easing) == "string" or (type(easing) == "number" and (easing >= 1 or easing <= #builtins)), "Bad argument @ 'createAnimation' [invalid easing at argument 3]") 
    assert(type(duration) == "number", "Bad argument @ 'createAnimation' [expected number at argument 4, got "..type(duration).."]") 
    assert(type(onChange) == "function", "Bad argument @ 'createAnimation' [expected function at argument 5, got "..type(onChange).."]") 
    return table.insert(anims, {from = f, to = t, easing = table.find(builtins, easing) and easing or builtins[easing], duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd}) 
end 
  
addEventHandler("onClientRender", root, function( ) 
    local now = getTickCount( ) 
    for k,v in ipairs(anims) do 
        v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing)) 
        if now >= v.start+v.duration then 
            table.remove(anims, k) 
            if type(v.onEnd) == "function" then 
                v.onEnd( ) 
            end 
        end 
    end 
end) 

	

	---__EX__---
--Slide Animation 
local sx, sy = guiGetScreenSize( ) 
local window = guiCreateWindow((sx-300)/2, (sy-400)/2, 300, 400, "Test", false) 
guiSetVisible(window, false) 
bindKey("f2", "down", function( ) 
    if anim then return end 
    local v = guiGetVisible(window) 
    if not v then guiSetVisible(window, true) end 
    anim = true 
    createAnimation(v and 400 or 0, v and 0 or 400, 2, 1250, function(height) 
        if v and height == 0 then  
            guiSetVisible(window, false) 
            anim = false 
        elseif not v and height == 400 then 
            anim = false 
        end 
        local w, h = guiGetSize(window, false) 
        guiSetSize(window, w, height, false) 
    end) 
end)  
--____________________________________dxDrawRectangleWithLines____________________________________________--

function dxDrawRectangleWithLines(x,y,x1,y1,color,lineColor,state) 
 if type(x) == "number" and type(y) == "number" and type(x1) == "number" and type(state) == "boolean" then 
  dxDrawRectangle(x,y,x1,y1, color,state) 
  dxDrawLine(x,y, x+x1, y, lineColor,2,false) 
  dxDrawLine(x,y+y1, x+x1, y+y1, lineColor,2,false) 
  dxDrawLine(x, y, x, y+y1+1,lineColor,2,false) 
  dxDrawLine(x+x1, y, x+x1, y+y1+1, lineColor,2,false) 
 end 
end 

	---__EX__---
  
addEventHandler("onClientRender",root, 
function() 
dxDrawRectangleWithLines(398, 220, 500, 400, tocolor(0, 0, 0, 181),tocolor(255, 255, 255, 225), false) 
end)   
--للتوضيح  
--tocolor(0, 0, 0, 181) هذا لون اللوحة خليته اسود 
--tocolor(255, 255, 255, 225) هذا لون الخطوط خليته ابيض 
  
--_____________________________________onClientPlayerMoneyChange ___________________________________________--

local EventPlayerMoney = getPlayerMoney(localPlayer) 
  
addEventHandler("onClientRender", root,  
function () 
    if EventPlayerMoney ~= getPlayerMoney(localPlayer) then 
        triggerEvent("onClientPlayerMoneyChange", localPlayer, tonumber(EventPlayerMoney), tonumber(getPlayerMoney(localPlayer))) 
        EventPlayerMoney = getPlayerMoney(localPlayer) 
    end 
end 
) 
  
addEvent "onClientPlayerMoneyChange" 
	

	---__EX__---
VehiclePrice = 8000 
  
addEventHandler("onClientPlayerMoneyChange", root,  
function (OldMoney, NewMoney) 
    if NewMoney >= VehiclePrice then 
        outputChatBox("Now you can buy the vehicle !", 0, 255, 0) 
    elseif OldMoney < VehiclePrice then 
        outputChatBox("get more money to buy the vehicle", 255, 0, 0) 
    end 
end 
) 
--_____________________________setPlayerMoney__givePlayerMoney__takePlayerMoney________________________________________________--

local fType = "client" 
_setPlayerMoney = setPlayerMoney 
_givePlayerMoney = givePlayerMoney 
_takePlayerMoney = takePlayerMoney 
  
function setPlayerMoney(...) 
    local args = {...} 
    local plr,money = (fType == "server") and args[1] or localPlayer, (fType == "server") and arg[2] or arg[1] 
    triggerEvent("on".. (fType == "client" and "Client" or "") .."PlayerMoneyChanged",plr,money,money) 
    return _setPlayerMoney(...) 
end 
  
function givePlayerMoney(...) 
    local args = {...} 
    local plr,money = (fType == "server") and args[1] or localPlayer, (fType == "server") and arg[2] or arg[1] 
    triggerEvent("on".. (fType == "client" and "Client" or "") .."PlayerMoneyChanged",plr,money,getPlayerMoney(plr)+money) 
    return _givePlayerMoney(...) 
end 
  
function takePlayerMoney(...) 
    local args = {...} 
    local plr,money = (fType == "server") and args[1] or localPlayer, (fType == "server") and arg[2] or arg[1] 
    triggerEvent("on".. (fType == "client" and "Client" or "") .."PlayerMoneyChanged",plr,money,getPlayerMoney(plr)-money) 
    return _takePlayerMoney(...) 
end 
	

	---__EX__---

--____________________________________getRealTimeFromNumber____________________________________________--

  
local times = {[1] = "hour",[2] = "minute",[3] = "second",[4] = "monthday" , [5] = "month" , [6] = "year" , [7] = "weekday" , [8] = "yearday" , [9] = "isdst" , [10] = "timestamp"} 
function getRealTimeFromNumber ( id ) 
return type ( id ) == "number" and getRealTime()[times[id]] 
end 
  
	

	---__EX__---

addCommandHandler ( "re" , function ( ) 
local rand = math["random"] ( #times )  
outputChatBox ( tostring ( getRealTimeFromNumber ( rand ) ) )  
end 
) 
--_______________________________guiGridListSetItemDataWithKey_________________________________________________--

function guiGridListSetItemDataWithKey(GridList, Row, Column, Key, Value) 
    assert(isElement(GridList), "Bad Argument At Argument #1 got nil") 
    assert(getElementType(GridList) == "gui-gridlist", "Bad Argument At Argument #1 got "..tostring(getElementType(GridList) or type(GridList))) 
    assert(type(Row) == "number", "Bad Argument At Argument #2 got "..tostring(type(Row))) 
    assert(type(Column) == "number", "Bad Argument At Argument #3 got "..tostring(type(Column))) 
    assert(type(Key) == "string", "Bad Argument At Argument #4 got "..tostring(type(Key))) 
    local Data1 = guiGridListGetItemData(GridList, Row, Column) 
    if Data1 == nil or Data1["ATableOfData"] == false or Data1["ATableOfData"] == nil then 
        guiGridListSetItemData(GridList, Row, Column, {["ATableOfData"] = true}) 
    end 
    local Data = guiGridListGetItemData(GridList, Row, Column) 
    if Key ~= "ATableOfData" and Data["ATableOfData"] then 
        local Table = {} 
        local Data = guiGridListGetItemData(GridList, Row, Column) 
        for Key, Value in pairs(Data) do 
            Table[Key] = Value 
        end  
        Table[Key] = Value 
        guiGridListSetItemData(GridList, Row, Column, Table) 
        return true 
    else 
        error("Invalid Key At Argument #4 Change it") 
    end 
end 
  
	

	---__EX__---
GridList = guiCreateGridList(464, 262, 396, 377, false) 
guiGridListAddColumn(GridList, "Col", 0.9) 
guiGridListAddRow(GridList) 
guiGridListSetItemDataWithKey(GridList, 0, 1, "Key", "SomeValue") 
guiGridListSetItemDataWithKey(GridList, 0, 1, "Key2", "SomeValue2") 
  
addCommandHandler("GetData",  
function (CMD, Key) 
    outputChatBox(tostring(guiGridListGetItemDataWithKey(GridList, 0, 1, Key))) 
end 
) 
--guiGridListGetItemDataWithKey Scroll Down ..  
--____________________________________guiGridListGetItemDataWithKey____________________________________________--
function guiGridListGetItemDataWithKey(GridList, Row, Column, Key) 
    assert(getElementType(GridList) == "gui-gridlist", "Bad Argument At Argument #1 got "..tostring(getElementType(GridList) or type(GridList))) 
    assert(type(Row) == "number", "Bad Argument At Argument #2 got "..tostring(type(Row))) 
    assert(type(Column) == "number", "Bad Argument At Argument #3 got "..tostring(type(Column))) 
    assert(type(Key) == "string", "Bad Argument At Argument #4 got "..tostring(type(Key))) 
    assert(Key ~= "ATableOfData", "Invalid Key At Argument #4 Change it") 
    local Data = guiGridListGetItemData(GridList, Row, Column) 
    assert(type(Data) == "table", "Invalid Data Type got "..tostring(type(Data)).." (table expected) ") 
    return Data[Key] 
end 

	---__EX__---

--___________________________________The function returns real time with convert 24h to 12h_____________________________________________--
function getTime( ) 
    local time = getRealTime( ) 
    local h, m = time.hour, time.minute 
    return (h % 12 and h % 12 or 12)..":"..(m < 10 and "0"..m or m).." "..(h >= 12 and "PM" or "AM") 
﻿end 
	---__EX__---

--__________________________________table.sect______________________________________________--
function table.sect(t, i) 
    local a, b, c = 1, { }, 0 
    if math.modf(i) == i and i ~= 0 then 
        for k, v in ipairs(t) do 
            c = c+1 
            if c > i then a, c = a+1, 1 end 
            if not b[a] then b[a] = { } end 
            table.insert(b[a], v) 
        end 
    end 
    return b 
end 	
	---__EX__---
t = {"Hello 1", "Hello 2", "Hello 3", "Hello 4", "Hello 5", "Hello 6", "Hello 7", "Hello 8", "Hello 9", "Hello 10"} 
  
for k, v in ipairs(table.sect(t, 2)) do 
        print("__") -- lines between each section 
    for k, _v in ipairs(v) do -- section table 
        print(_v) -- print section values 
    end 
end 
--[[Output(Result) :  
__ 
Hello 1 
Hello 2 
__ 
Hello 3 
Hello 4 
__ 
Hello 5 
Hello 6 
__ 
Hello 7 
Hello 8 
__ 
Hello 9 
Hello 10 
]] 
--____________________________________changeGridListItemToVehiclesName____________________________________________--
  
 	changeGridListItemToVehiclesName = function ( GridList, Column ) 
    if GridList and Column then -- Check Parematers 
        if getElementType ( GridList ) == "gui-gridlist" then -- Check The Type of ' GridList ' 
            if guiGridListClear ( GridList ) then -- Clear GridList 
                for i, v in next, getElementsByType ( "vehicle" ) do -- Get Everything by Type ' vehicle ' 
                    local Row = guiGridListAddRow ( GridList ) -- Add Row 
                    guiGridListSetItemText ( GridList, Row, Column, getVehicleName ( v ), false, false ); -- Set New Values 
                end; -- end of ' for ' 
            end; -- end of ' clear gridlist ' 
        end; -- end of ' check gridlist type ' 
    end; -- end of ' check parematers 
end; -- end of ' function ' 	
---__EX__---
  
wnd = guiCreateWindow(313, 199, 291, 451, "Test", false) 
grid = guiCreateGridList(25, 71, 255, 318, false, wnd) 
col = guiGridListAddColumn( grid, "Vehicles :", 0.85 ) 
changeGridListItemToVehiclesName( grid, col) 
  
--____________________________ValidateURL____________________________________________________--
function ValidateURL(s) 
    return s:match("[A-Za-z0-9%.%%%+%-]+://[A-Za-z0-9%.%%%+%-]+%.[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?") 
end 
	---__EX__---

--________________________________isMouseInCircle________________________________________________--
local sx, sy = guiGetScreenSize( ) 
function isMouseInPosition(x, y, w, h) 
    if isCursorShowing( ) then 
        local cx, cy = getCursorPosition( ) 
        local cx, cy = cx*sx, cy*sy 
        return cx >= x and cx <= x+w and cy >= y and cy <= y+h 
    end 
    return false 
end 
function isMouseInCircle(x, y, r) 
    local i = 0 
    for k=(-r), r do 
        local q = math.sqrt((r/2)*(r/2)-k*k) 
        if isMouseInPosition(x-q+(r/2), y+k+(r/2), 2*q, 1) then 
            i = i+1 
        end 
    end 
    return i ~= (-r)+r 
end 
	---__EX__---

--_______________________________dxDrawText2D_________________________________________________--
function dxDrawText2D(text, left, top, width, height, color, scale, font, alignX, alignY,clip,wordBreak, postGUI,frameColor,fRotation) 
if  color and frameColor and scale and font and alignX and alignY and not fRotation then 
    color = tocolor(255, 255, 255, 255) 
    frameColor = tocolor(0, 0, 0, 255) 
    scale = 1 
    fRotation = 0 
    font = "default-bold" 
    alignX = "left" 
    alignY = "top" 
  end 
if not clip and not wordBreak and not postGUI then 
    clip = false 
    wordBreak = false 
    postGUI = false 
  end 
  for k=1,scale+4 do 
 dxDrawText(text, left + 1 + k, top - 1 + k, width + 1 + k, height - 1 + k, frameColor, scale, font, alignX, alignY, clip,wordBreak, postGUI,true, true,fRotation) 
 dxDrawText(text, left + k, top + k, width + k, height + k, color, scale, font, alignX, alignY, clip,wordBreak, postGUI,true, true,fRotation) 
end 
end 
	---__EX__---
 addEventHandler("onClientRender", root, 
    function() 
dxDrawText2D("Medo#1ceae37", 5,5,100,100, tocolor(200, 255, 0, 255), 3, "default-bold", "left", "top", false, false, false, tocolor(0, 255, 0, 255),0) 
dxDrawText2D("me#f00f00Do7", 75,245,100,100, tocolor(0, 0, 0, 255), 10, "default-bold", "left", "top", false, false, false, tocolor(0, 255, 0, 255),-40) 
dxDrawText2D("Medo7 $", 105,335,100,100, tocolor(200, 255, 0, 255), 7, "default-bold", "left", "top", false, false, false, tocolor(0, 0, 0, 255),20) 
 end 
) 
  
--_____________________________________getPlayersInGroup___________________________________________--
function getPlayersInGroup ( GroupName ) 
  
    local aTable = {} 
  
    assert ( tostring ( GroupName ) , "Bad Argument At Argument #1 Group Moust String" )  
     
    assert ( aclGetGroup ( tostring ( GroupName ) ) , "Bad Argument At Argument #1 Group not Found "  )  
     
    for i , player_ in ipairs ( getElementsByType ( "player" ) ) do 
     
    local TheAcc =  getPlayerAccount ( player_ )  
     
    if not isGuestAccount ( TheAcc ) then   
  
    if isObjectInACLGroup ( "user." ..getAccountName ( TheAcc ) , aclGetGroup ( tostring ( GroupName ) ) ) then 
      
    table.insert ( aTable , player_ ) 
             end   
        end  
    end  
    return aTable 
end 
  
	---__EX__---
addCommandHandler ( "killPlayerGroup",   
  
function ( _ , _ , GroupName_ ) 
  
Players = getPlayersInGroup (  GroupName_  ) 
  
for i , PlayersGroup in ipairs ( Players ) do 
  
killPed ( PlayersGroup )  
        end 
    end 
    ) ; 
     
-- F8 Say : killPlayerGroup Console 

addCommandHandler("GiveGroupMoney", 
  
function ( p , _ , Group_ , aMoney ) 
  
    Players = getPlayersInGroup ( Group_ ) 
  
    for i , PlayersGroup in ipairs ( Players ) do 
  
    givePlayerMoney ( PlayersGroup , tonumber ( aMoney ) ) 
  
    end 
end 
    ) ; 
  
--F8 Say : GiveGroupMoney Console 500 
--________________________________dxFrame_______createButton_________________________________________--
  
--[[ 
    createFrame( 
        x - أحداثي x للأطار 
        y - أحداثي y للأطار 
        w - عرض الأطار 
        h - أرتفاع الأطار 
        Title - عنوان الأطار 
        Color - لون الأطار 
        TitleBarColor - لون شريط العنوان 
    ) 
]] 
function createFrame( x, y, w, h, Title, Color, TitleBarColor ) 
    MFrame = { 
        x = 0, y = 0, 
        w = 400, h = 250, 
        Title = "Frame", 
        Color = tocolor( 120, 120, 120, 150 ), 
        Color = tocolor( 120, 120, 120, 255 ), 
  
        components = { 
  
        }, 
  
        render = function () 
            dxDrawRectangle( x, y, w, h, Color, false) 
            dxDrawRectangle( x, y, w, 15, TitleBarColor, false) 
            dxDrawText( Title, x + 5, y )  
            for k,v in pairs(MFrame.components) do 
                v.render(); 
            end 
        end, 
  
        add = function ( comp ) 
            comp.setOfset(x, y) 
            table.insert(MFrame.components, comp); 
        end 
  
    } 
  
    function create() 
        MFrame.x = x; MFrame.y = y; 
        MFrame.w = w; MFrame.h = h; 
        MFrame.Title = Title;  
        MFrame.Color = Color; MFrame.TitleBarColor = TitleBarColor; 
        return MFrame; 
    end 
  
    return create(); 
end 
    
--[[ 
    createButton( 
        x - أحداثي x للزر 
        y - أحداثي y للزر 
        w - عرض الزر 
        h - أرتفاع الزر 
        text - النص اللي يضهر داخله  
        Color - لون مربع الزر 
        textColor - لون النص 
    ) 
]] 
function createButton( x, y, w, h, text, Color, textColor ) 
    xOfset = 0; 
    yOfset = 0; 
    isVisableX = true; 
    local MButton = { 
        x = 0, y = 0, 
        w = 80, h = 20,  
        text = "Button",  
        isVisable = isVisableX, 
        textColor = tocolor( 236, 240, 241, 255 ), 
        Color = tocolor( 231, 76, 60, 150 ), 
  
  
        render = function () 
            if ( isVisableX == true ) then 
                dxDrawRectangle( x + xOfset, y + yOfset, w, h, Color ) 
                dxDrawText( text, ( (x + xOfset) + (w/2) ) - (string.len(text)*3), ((y + yOfset) - 7) + (h/2)  )  
            end 
        end, 
  
        setVisable = function ( visable ) 
            isVisableX = visable; 
        end, 
  
        setTextColor = function ( color ) 
            textColor = color; 
        end, 
  
        setTextColorRGBA = function ( r, g, b, a ) 
            textColor = tocolor( r, g, b, a ) 
        end, 
  
        getText = function ( ) 
            return text; 
        end, 
  
        setText = function ( text2 ) 
            text = text2; 
        end, 
  
        setColor = function ( Color2 ) 
            Color = Color2; 
        end, 
  
        setColorRGBA = function ( r, g, b, a ) 
            Color = tocolor( r, g, b, a ) 
        end, 
  
        setOfset = function ( ofx, ofy ) 
            xOfset = ofx; 
            yOfset = ofy; 
        end, 
  
        setX = function (x2) x = x2 end, 
        getX = function () return x; end, 
  
        setY = function (y2) y = y2 end, 
        getY = function () return y; end, 
  
        setW = function (w2) w = w2 end, 
        getW = function () return w; end, 
  
        setH = function (h2) h = h2 end, 
        getH = function () return h; end 
    } 
    local create = function () 
        MButton.x = x; MButton.y = y; 
        MButton.w = w; MButton.h = h; 
        MButton.text = text; MButton.Color = Color; 
        MButton.textColor = textColor; 
        return MButton; 
    end 
  
    return create() 
end 
  
	---__EX__---
render() -- ما راح تحتاجها أصلاً   
setX(newX) -- تغيير أحداثي x للزر 
setText(newText) -- تغيير النص 
setOfset(xOfset, yOfset) -- في الأغلب ما راح تحتاجها بس مجرد تغير احداثيات ال x,y اللي راح يبدأ منها الزر ( ما اتوقع وصلتها صح  ) 
setTextColorRGBA(r, g, b, a) -- تغيير لون النص 
getH() -- ترجع قيمة ارتفاع الزر 
setH(newHeight) -- تغيير ارتفاع الزر 
setVisable(visable) -- أضهار الزر وأخفائه 
setColor(Color) -- تغيير لون الزر 
setW(newWidth) -- تغيير عرض الزر 
getY() -- ترجع y للزر 
setY(newY) -- تغيير قيمة y للزر 
setColorRGBA(r, g, b, a) -- تغيير لون الزر 
getX() -- ترجع x للزر 
getW() -- ترجع عرض الزر 
setTextColor(Color) -- تغيير لون النص 
getText() -- ترجع النص داخل الزر  
  
 local Frame; -- نسوي متغير أساسي للأطار  
local b1; -- ومتغير للزر 
  
function renderer ( ) 
    Frame.render(); -- عرض الأطار 
end 
  
function init() 
    ButtonColor = tocolor( 231, 76, 60, 255 ) -- نسوي متغير يعبر عن اللون 
    textColor = tocolor( 236, 240, 241, 255 ) -- متغير ثاني يعبر عن لون الخط 
    b1 = createButton( 10, 20, 80, 40, "Test Test", color, textColor ) -- أنشاء الزر 
  
    FrameColor = tocolor( 231, 76, 60, 120 ) -- نسوي لون للأطار 
    Frame = createFrame( 400, 400, 450, 250, "Frame", color, color ); -- أنشاء الأطار 
  
    Frame.add(b1) -- أضافة الزر الى الأطار 
  
    addEventHandler ( "onClientRender", root, renderer )  
end 
  
addEventHandler ( "onClientResourceStart", resourceRoot, init ) 

--_______________________________convertDxPositionToAllScreens_________________________________________________--
function convertDxPositionToAllScreens(x, y, toX, toY, size, yourX, yourY) 
    if type(x) == "number" and type(y) == "number" and type(toX) == "number" and type(toY) == "number" and type(yourX) == "number" and type(yourY) == "number" then 
        local sX, sY = guiGetScreenSize( ) 
        local nX = tonumber(x)/tonumber(yourX) 
        local nY = tonumber(y)/tonumber(yourY) 
        local nTX = tonumber(toX)/tonumber(yourX) 
        local nTY = tonumber(toY)/tonumber(yourY) 
        local rX = nX*sX 
        local rY = nY*sY 
        local rTX = nTX*sX 
        local rTY = nTY*sY 
        local font_size=tonumber( size )*sX/yourX 
        return rX, rY, rTX, rTY, font_size 
    end 
end 	
	---__EX__---
function convertDxPositionToAllScreens(x, y, toX, toY, size, yourX, yourY) 
    if type(x) == "number" and type(y) == "number" and type(toX) == "number" and type(toY) == "number" and type(yourX) == "number" and type(yourY) == "number" then 
        local sX, sY = guiGetScreenSize( ) 
        local nX = tonumber(x)/tonumber(yourX) 
        local nY = tonumber(y)/tonumber(yourY) 
        local nTX = tonumber(toX)/tonumber(yourX) 
        local nTY = tonumber(toY)/tonumber(yourY) 
        local rX = nX*sX 
        local rY = nY*sY 
        local rTX = nTX*sX 
        local rTY = nTY*sY 
        local font_size=tonumber( size )*sX/yourX 
        return rX, rY, rTX, rTY, font_size 
    end 
end 
--____________________________________guiAntiFlood____________________________________________--
function guiAntiFlood(element, timer) 
    if getElementType ( element ) == "gui-button" then 
        local atimer = tonumber(timer) 
        if atimer == nil or atimer == '' or not tonumber(atimer) then 
            error("Bad Argument the Argument 2 must number") 
        else 
        end 
        guiSetEnabled(element,false) 
        setTimer(function() 
        guiSetEnabled(element,true) 
        end,tonumber(atimer),1) 
    else 
        error("Bad Argument 1 the element must button") 
  end 
end 
	---__EX__---
  
addEventHandler("onClientGUIClick",button, 
function() 
setElementHealth(localPlayer,100) 
guiAntiFlood(button,2000) 
end)   
--للتوضيح  
--2000 هيك خليت البوتون يغلق لمدة ثانيتين 
--10000 = ثانية  
--10000 دقيقة 
-- تقدر تضرب عدد الدقايق او الثواني مثال  
--guiAntiFlood(button,2*10000) هيك يقفل لمدة دقيقتين 
  
--__________________________________guiGridListAddPlayers______________________________________________--
function guiGridListAddPlayers( GridList, Column, Section, Number ) 
    if( getElementType( GridList ) == "gui-gridlist" ) then 
    assert( tonumber( Column ), "Bad argument @ 'guiGridListAddPlayers' [Expected number at argument 2, got " .. tostring(Column) .. "]" ) 
        if( Section == false or Section == true ) then 
            if( Number == false or Number == true ) then 
                for _, player in ipairs( getElementsByType('player') ) do 
                    guiGridListClear( GridList ) 
                        local Row = guiGridListAddRow( GridList ) 
                        guiGridListSetItemText( GridList, Row, Column, getPlayerName(player), Section, Number ) 
                        end  
                    else 
                    error("Bad argument @ 'guiGridListAddPlayers' [Expected boolean at argument 4, got " .. tostring(Number) .. "]") 
                end 
            else 
            error("Bad argument @ 'guiGridListAddPlayers' [Expected boolean at argument 3, got " .. tostring(Section) .. "]") 
        end 
    end 
end 
﻿
	---__EX__---
  
-- Grid list  
    local screenW, screenH = guiGetScreenSize() 
    Main_GridList = guiCreateGridList((screenW - 233) / 2, (screenH - 357) / 2, 233, 357, false) 
    guiGridListAddColumn(Main_GridList, "Players", 0.9) 
    guiSetVisible( Main_GridList, false ) 
  
-- For show Grid List 
bindKey( "F10", "down", function( ) 
    guiSetVisible( Main_GridList, not guiGetVisible( Main_GridList ) ) 
    showCursor( not isCursorShowing( ) ) 
end ) 
  
-- This command add all players to a grid list 
addCommandHandler( "addPlayers", function( ) 
    guiGridListAddPlayers( Main_GridList, 1, false, false ) 
end ) 
  
--_________________________________givePlayerVehicle_______________________________________________--
Table = {} 
function givePlayerVehicle(thePlayer,ID) 
    if getElementType (thePlayer) == "player" then 
        if type(ID) == "number" then 
            if thePlayer and ID then 
                local x,y,z = getElementPosition(thePlayer) 
                Table[thePlayer] = createVehicle(tonumber(ID),x,y,z) 
                warpPedIntoVehicle(thePlayer,Table[thePlayer]) 
            else 
                error("There is Argument minus") 
            end 
        else 
            error("Bad Argument 2 must number") 
        end 
    else 
        error("Bad Argument 1 must player") 
    end 
end 
	---__EX__---
  
--Client 
addEventHandler("onClientGUIClick",button, 
function() 
triggerServerEvent("Test",localPlayer) 
end)   
  
  
--Server 
addEvent("Test",true) 
addEventHandler("Test",root, 
function() 
givePlayerVehicle(source,429) 
outputChatBox("تم اعطاؤك سيارة",source,0,255,0) 
end) 
--  
  
--____________________________________getRandomVehicle____________________________________________--
    function getRandomVehicle (  ) 
﻿
  
    local Table = { } 
  
    for i , v in ipairs ( getElementsByType ( "vehicle" ) ) do 
  
    table.insert ( Table , v ) 
  
    end 
     
    if #Table == 0 then error "Server Not Vehicle" 
  
    return false  
  
        end  
    return Table[ math.random ( #Table ) ] 
    end 
  
	---__EX__---
addCommandHandler("WarpVeh", 
  
    function ( p ) 
  
    Veh = getRandomVehicle (   ) 
  
    if Veh then 
  
    warpPedIntoVehicle ( p , Veh ) 
  
    end 
end 
    ) ; 
     
-- F8 Say : WarpVeh 

addCommandHandler("blowVeh", 
  
    function ( p ) 
  
    Veh = getRandomVehicle (   ) 
  
    if Veh then 
  
    blowVehicle ( Veh ) 
  
    end 
end 
    ) ;  
  
--F8 Say : blowVeh 
outputChatBox ( getVehicleName ( getRandomVehicle (   ) ) ) 
--___________________________________BindAnimation_____________________________________________--
  
BindAnimation = function (Key, Window, Status) 
if tostring(Status) and tostring(Key) then           
if Window and getElementType ( Window ) == 'gui' then 
if (Status == "Fast") then 
bindKey(Key,"down",function () 
if guiGetVisible(Window) == false then 
guiSetVisible(Window,true) 
guiSetAlpha(Window,0.00) 
TimerFalse = setTimer(function() 
local Alpha = guiGetAlpha(Window) + 0.10 
guiSetAlpha(Window,Alpha) 
if Alpha == 0.80 and isTimer(TimerFalse) then 
killTimer(TimerFalse) 
showCursor ( true ) 
guiSetInputEnabled ( true ) 
end 
end 
end,200,1) 
else 
guiSetAlpha(Window,0.80) 
TimerTrue = setTimer(function() 
local Alph = guiGetAlpha(Window) - 0.10 
guiSetAlpha(Window,Alph) 
if Alph == 0.00 and isTimer(TimerTrue) then 
killTimer(TimerTrue) 
showCursor ( false ) 
guiSetInputEnabled ( false ) 
end 
end 
end,200,1) 
) 
end 
if (Status == "Slow") then 
bindKey(Key,"down",function () 
if guiGetVisible(Window) == false then 
guiSetVisible(Window,true) 
guiSetAlpha(Window,0.00) 
TimerFalse = setTimer(function() 
local Alpha = guiGetAlpha(Window) + 0.10 
guiSetAlpha(Window,Alpha) 
if Alpha == 0.80 and isTimer(TimerFalse) then 
killTimer(TimerFalse) 
showCursor ( true ) 
guiSetInputEnabled ( true ) 
end 
end 
end,600,1) 
else 
guiSetAlpha(Window,0.80) 
TimerTrue = setTimer(function() 
local Alph = guiGetAlpha(Window) - 0.10 
guiSetAlpha(Window,Alph) 
if Alph == 0.00 and isTimer(TimerTrue) then 
killTimer(TimerTrue) 
showCursor ( false ) 
guiSetInputEnabled ( false ) 
end 
end 
end,600,1) 
) 
else 
error("Bad Argmuent @3 Is Not (Fast Or Slow)") 
end 
else 
error("Bad Argmuent @3 Is Not (Fast Or Slow)") 
end 
else 
error("Bad Argmuent @2 Is Not (gui-)") 
end 
else 
error("Bad Argmuent @1 Is Not 'string' ") 
end 
  
	---__EX__---
  
wnd = guiCreateWindow(11,22,33,44,"Test",false) 
BindAnimation("F1",wnd,"Slow") 
  
--___________________________________setPlayerColorToTeamColor_____________________________________________--
function setPlayerColorToTeamColor ( Player ) 
    if getElementType (Player) == "player" then  
        local playerTeam = getPlayerTeam ( player ) 
        if ( playerTeam ) then 
            local playername = getPlayerName( Player )  
            if playername:find("#%x%x%x%x%x%x") then 
                local playername = playername:gsub("#%x%x%x%x%x%x","") 
                if playername:len() > 0 then 
                    if ( setPlayerName(Player, playername)) then 
                        local r, g, b = getTeamColor( playerTeam ) 
                        setPlayerNametagColor(Player , r, g, b) 
                    end 
                else 
                    setPlayerName(Player, "NoName"..tostring(math.random(1,10000)))  
                end 
            else 
                local r, g, b = getTeamColor( playerTeam ) 
                setPlayerNametagColor(Player, r, g, b) 
            end 
        else 
            outputDebugString( "bad arguments 2 :"..getPlayerName ( Player ) .. " isn't on a team",  1 ) 
        end 
    else 
        outputDebugString("Bad arguments 1 :the source is not a player", 1 ) 
    end 
end  
	---__EX__---

--________________________________getGuestPlayers________________________________________________--
function getGuestPlayers (  ) 
  
    local Guest = { } ; 
  
    for _ , players_ in ipairs ( getElementsByType ( "player" ) ) do  
  
    local playerAcc = getPlayerAccount ( players_ ) 
  
    if isGuestAccount ( playerAcc ) then 
  
    table.insert ( Guest , players_ ) 
  
                end 
            end  
        return Guest 
    end 
  
	---__EX__---
addCommandHandler ( "getGuestPlayers_" , function ( ) 
  
    local GuestPlayers = getGuestPlayers (  ) 
  
    if ( #GuestPlayers ~= 0 ) then 
  
    for _ , v in ipairs ( GuestPlayers ) do  
  
    outputChatBox (  getPlayerName ( v ) : gsub ( "#%x%x%x%x%x%x", "" ) .. "plz Login or Register" , v , 255 , 255 , 255 , true ) 
  
            end 
        end 
    end 
    ) ; 
     
-- F8 Say : getGuestPlayers_ 

addCommandHandler ( "killGuestPlayers" , function ( ) 
  
    local GuestPlayers = getGuestPlayers (  ) 
  
    if ( #GuestPlayers ~= 0 ) then 
  
    for _ , v in ipairs ( GuestPlayers ) do  
  
    killPed ( v ) 
  
            end 
        end 
    end 
    ) ; 
  
--F8 Say : killGuestPlayers 

outputChatBox ( #getGuestPlayers (  )  ) 
--________________________________getVehiclesInServer________________________________________________--
function getVehiclesInServer () 
	local cars = { } 
	for _,v in ipairs ( getElementsByType ( "vehicle" ) ) do 
		table.insert (cars,v) 
	end  
		return cars 
end 
  
	---__EX__---
addCommandHandler("p", 
function (playerr) 
	outputChatBox(""..#getVehiclesInServer().."",playerr,0,255,0) 
end 
) 
  
--________________________________isVehiclesidInServer________________________________________________--
function isVehiclesidInServer(id1) 
    if type(id1) == "number" then  
        for __,cc in ipairs ( getElementsByType ( "vehicle" ) ) do 
            local idd = getElementModel(cc) 
            if  ( idd  == tonumber(id1)  ) then  
                return true  
            end 
        end 
        return false 
    else 
        error("Bad Argument 1 must number") 
    end 
end 
	---__EX__---

--__________________________________isMouseInPosition______dxDrawHoverRectangle________________________________________--
function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing ( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

function dxDrawHoverRectangle(x, y, w, h, color, color2, post)
local x = x or 0
local y = y or 0
local w = w or 0
local h = h or 0
local color = color or tocolor(255, 255, 255, 255)
local color2 = color2 or tocolor(255, 255, 255, 150)
local post = post or false
if isMouseInPosition(x, y, w, h) then
dxDrawRectangle(x, y, w, h, color2, post)
else
dxDrawRectangle(x, y, w, h, color, post)
end
end
	---__EX__---
addEventHandler("onClientRender", root,
function()
dxDrawHoverRectangle(100, 100, 50, 50, tocolor(255, 255, 255, 150), tocolor(0, 0, 0, 150), false)
end)
--________________________________________________________________________________--
function getPlayerTime ( Player )
	local TimeData = getElementData(Player,'PlayTime') or '0:0';
	if ( TimeData ) then
		return tonumber(split(TimeData,':')[1]) , tonumber(split(TimeData,':')[2]);
	end 
end

	---__EX__---



addEventHandler('onPlayerChat',root,
function (Message,MessageType)
	if ( MessageType == 0 ) then 
		local hour , mintue = getPlayerTime ( source ) -- نجيب ساعاته
		if ( hour >= 5 ) then -- نتحقق ان الساعات 5 او اكثر
			outputChatBox('['..tostring(hour)..':'..tostring(mintue)..'] '..getPlayerName(source)..': '..Message,root)
		else -- في حال الساعات اقل من 5 لن يسمح له بالتكلم 
			outputChatBox("Sorry, you can't speak because your time less than 5 hours",source)
			cancelEvent()
		end 
	end 
end)
--_______________________________convertHistoryToHijri_2________________________________________________--
convertHistoryToHijri = function (  ) 
    local Time = getRealTime (  ); 
    local Day = Time.monthday 
    local Month = Time.month + 1 
    local Year = Time.year + 1900 
    -- 
    if Month == 1 then Last = Day end 
    if Month == 2 then Last = Day + 30 end 
    if Month == 3 then Last = Day + 60 end 
    if Month == 4 then Last = Day + 90 end 
    if Month == 5 then Last = Day + 120 end 
    if Month == 6 then Last = Day + 150 end 
    if Month == 7 then Last = Day + 180 end 
    if Month == 8 then Last = Day + 210 end 
    if Month == 9 then Last = Day + 240 end 
    if Month == 10 then Last = Day + 270 end 
    if Month == 11 then Last = Day + 300 end 
    if Month == 12 then Last = Day + 330 end 
    -- 
    x = math.ceil ( ( Year - 1 ) * 365.25 ); 
    x = x + Last  
    x = math.abs ( x - 227015 ); 
    x = math.floor ( x * 30 ); 
    xx = x 
    x = math.floor ( x / 10631 ); 
    m = math.floor ( x * 10631 ); 
    m = math.abs ( m - xx ); 
    x2 = math.floor ( m / 30 ); 
    x2 = math.abs ( x2 - 13 ); 
    -- 
    if x2 >= 1 and x2 <= 30 then x4 = x2 x3 = 1 end 
    if x2 >= 31 and x2 <= 60 then x4 = x2 - 30 x3 = 2 end 
    if x2 >= 61 and x2 <= 90 then x4 = x2 - 60 x3 = 3 end 
    if x2 >= 91 and x2 <= 120 then x4 = x2 - 90 x3 = 4 end 
    if x2 >= 121 and x2 <= 150 then x4 = x2 - 120 x3 = 5 end 
    if x2 >= 151 and x2 <= 180 then x4 = x2 - 150 x3 = 6 end 
    if x2 >= 181 and x2 <= 210 then x4 = x2 - 180 x3 = 7 end 
    if x2 >= 211 and x2 <= 240 then x4 = x2 - 210 x3 = 8 end 
    if x2 >= 241 and x2 <= 270 then x4 = x2 - 240 x3 = 9 end 
    if x2 >= 271 and x2 <= 300 then x4 = x2 - 270 x3 = 10 end 
    if x2 >= 301 and x2 <= 330 then x4 = x2 - 300 x3 = 11 end 
    if x2 >= 331 and x2 <= 360 then x4 = x2 - 330 x3 = 12 end 
    -- 
    return tostring ( x4 ), tostring ( x3 ), tostring ( x + 1 ); 
end 
	---__EX__---

--_________________________________getRealMonthH _______________________________________________--
monthTable = { 
	["10"] = "محرم",
	["11"] = "صفر",
	["12"] = "ربيع الأول",
	["1"] = "ربيع الآخر",
	["2"] = "جمادى الأول",
	["3"] = "جمادى الآخر",
	["4"] = "رجب",
	["5"] = "شعبان",
	["6"] = "رمضان",
	["7"] = "شوال",
	["8"] = "ذو الحجة",
	["9"] = "ذو القعدة"
}

function getRealMonthH()
	local time = getRealTime()
	local month = time.month + 1
	for i, v in pairs ( monthTable ) do
		if string.find ( i , month ) then
			if v ~= "" then
				m = v
			end
		end
	end
	return m
end
	---__EX__---
addCommandHandler("month",
function ()
	local month = getRealMonthH()
	outputChatBox(month)
end	
)
--____________________________________getRealMonthM____________________________________________--
monthTable = { 
	["1"] = "January",
	["2"] = "February",
	["3"] = "March",
	["4"] = "April",
	["5"] = "May",
	["6"] = "June",
	["7"] = "July",
	["8"] = "August",
	["9"] = "September",
	["10"] = "October",
	["11"] = "November",
	["12"] = "December"
}

function getRealMonthM()
	local time = getRealTime()
	local month = time.month + 1
	for i, v in pairs ( monthTable ) do
		if string.find ( i , month ) then
			if v ~= "" then
				m = v
			end
		end
	end
	return m
end
	---__EX__---
addCommandHandler("month",
function ()
	local month = getRealMonthM()
	outputChatBox(month)
end	
)
--__________________________________guiWindowTitlebarRight______________________________________________--
function guiWindowTitlebarRight(window, text, onClick)
	local width = dxGetTextWidth(text, 1, "default")
	local label = guiCreateLabel(guiGetSize(window, false) - width, 0, width, width, text, false, window)
	guiLabelSetColor(label, 255,0,0)
	guiSetProperty(label, "ClippedByParent", "False")
	guiSetProperty(label, "AlwaysOnTop", "True")

	local fun = {} 
	
	for i,v in ipairs(fun) do
		if v == "__self" then
			fun[i] = label
		end
	end
	
	addEventHandler("onClientGUIClick", label, function() if onClick then onClick(fun) end end, false)
	addEventHandler("onClientMouseEnter", label, function() guiLabelSetColor(label, 0,255,0) end, false)
	addEventHandler("onClientMouseLeave", label, function() guiLabelSetColor(label, 100,100,0) end, false)
end
	---__EX__---

--______________________________clwndo___openwnd_______________________________________________--
  function clwndo( guiElement ) 
     guiSetVisible( guiElement, false ) 
     showCursor( guiGetVisible(guiElement)) 
	 

end 
function openwnd( guiElement ) 
     guiSetVisible( guiElement, true ) 
     showCursor( guiGetVisible(guiElement)) 
	 

end 
	---__EX__---
	GUIEditor.window[5] = guiCreateWindow(0, 355, 259, 445, "Player Panel", false)
bindKey( "z", "down", function ( ) 

  if guiGetVisible(GUIEditor.window[5])==false then
    openwnd(GUIEditor.window[5])
	 else
	  clwndo(GUIEditor.window[5])
	 
end 
) 
--__________________________________quadForm______________________________________________--
function quadForm(a, b, c)
	if tonumber(a) and tonumber(b) and tonumber(c) then
		local l = math.sqrt((b^2)-(4*a*c));
		return { (-b + l)/2*a, (-b - l)/2*a };
	end
	return false;
end
	---__EX__---
--[[
Solve :
	x2 + 3x – 4 = 0
	x2 + 2x – 1 = 0
]]

local result1, result2 = quadForm(1, 3, -4), quadForm(1, 2, -1);
print("result 1: x1 = "..result1[1]..", x2 = "..result1[2]); -- >> result 1: x1 = 1.0 x2 = -4.0
print("result 2: x1 = "..result2[1]..", x2 = "..result2[2]); -- >> result 2: x1 = 0.4142135623731 x2 = -2.4142135623731
--________________________________removeAccountData ________________________________________________--
 function removeAccountData ( playerAccount, data )
    if ( playerAccount ~= "" ) and ( data ~= "" ) then
        if getAccount ( playerAccount ) then
			local dataName = getAccountData(playerAccount, data)
			if ( dataName ~= nil ) or ( dataName ~= "" ) then
				setAccountData(playerAccount, data, false)
			end
		end
	end
end 
	---__EX__---
function reCheck( )
    for i,player in ipairs ( getElementsByType('player') ) do
        if ( not isGuestAccount ( getPlayerAccount ( player ) ) ) then
            local acc = getPlayerAccount(player)
            if ( isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)),aclGetGroup('Admin') ) ) then
                setAccountData ( acc , 'Admin' , true )
            else
                removeAccountData(acc, 'Admin')
end
        end
end
addEventHandler('onResourceStart',resourceRoot,reCheck)
addEventHandler('onPlayerLogin',root,reCheck)
addEventHandler('onPlayerLogout',root,reCheck)
--________________________________________________________________________________--
function aclGroupClone( clonedGroup, groupName, aclsClone, objectsClone )
	if ( type( clonedGroup ) ~= 'string' ) then 
		error( "Bad argument @ 'aclGroupClone' [Expected string at argument 1, got " .. tostring( clonedGroup ) .. "]" ) return false end
			if ( aclsClone == true or aclsClone == false ) then 
				if ( objectsClone == true or objectsClone == false ) then 
					local cloned = aclGetGroup( clonedGroup )
						if ( cloned == false or not cloned ) then
							outputDebugString( "Bad argument @ 'aclGroupClone' [Expected acl-group at argument 1, got string '" .. tostring( clonedGroup ) .. "']", 2 ) return false end
								local newGroup = aclCreateGroup( groupName )
									if ( newGroup == false or not newGroup ) then
										outputDebugString( "Bad argument @ 'aclGroupClone' [Expected acl-group at argument 2, got string '" .. tostring( groupName ) .. "']", 2 ) return false end
											if ( aclsClone == true ) then
												for index, value in ipairs( aclGroupListACL( cloned ) ) do
											aclGroupAddACL( newGroup, value )
										end
									end
								if ( objectsClone == true ) then
							for index, value in ipairs( aclGroupListObjects( cloned ) ) do
						aclGroupAddObject( newGroup, value )
					end
				end
			outputDebugString( "'aclGroupClone' [The group '"..clonedGroup.."' has been cloned successfully to '"..groupName.."' .", 3 ) return true
		else error( "Bad argument @ 'aclGroupClone' [Expected boolean at argument 4, got " .. tostring( objectsClone ) .. "]" ) return false
	end
	else error( "Bad argument @ 'aclGroupClone' [Expected boolean at argument 3, got " .. tostring( aclsClone ) .. "]" ) return false
	end
end
	---__EX__---
addEventHandler( 'onResourceStart', resourceRoot,
function(  )
	setTimer( aclGroupClone, 1000, 1, 'Console', 'OwnersGroup', true, true ) -- Clone 'Console' Group to 'OwnersGroup' and clone ACLs and objects
end )
--______________________________________getWeaponModelFromID__________________________________________--
function getWeaponModelFromID( theid ) 
if type( theid ) == 'number' then 
local TableId = { 
[1] = 331, 
[2] = 333, 
[3] = 334, 
[4] = 335, 
[5] = 336, 
[6] = 337, 
[7] = 338, 
[8] = 339, 
[9] = 341, 
[22] = 346, 
[23] = 347, 
[24] = 348, 
[25] = 349, 
[26] = 350, 
[27] = 351, 
[28] = 352, 
[29] = 353, 
[32] = 372, 
[30] = 355, 
[31] = 356, 
[33] = 357, 
[34] = 358, 
[35] = 359, 
[36] = 360, 
[37] = 361, 
[38] = 362, 
[16] = 342, 
[17] = 343, 
[18] = 344, 
[39] = 363, 
[41] = 365, 
[42] = 366, 
[43] = 367, 
[10] = 321, 
[11] = 322, 
[12] = 323, 
[13] = 324, 
[14] = 325, 
[15] = 326, 
[44] = 368, 
[45] = 369, 
[46] = 371, 
[40] = 364 
} 
return TableId[ theid ]  end  
     return false
end 
	---__EX__---
addCommandHandler("wp",function ()
outputChatBox('thWeaponModel = '..getWeaponModelFromID( 17 ))
end
)
--________________________________________________________________________________--
function guiGetAbsolutePosition(gui_element)
    if isElement(gui_element) and getElementType(gui_element):find("gui-") then
        local ax, ay = guiGetPosition(gui_element, false)
        local cpa = getElementParent(gui_element)
        while isElement(cpa) do
            local cpx, cpy = guiGetPosition(cpa, false)
            ax, ay = ax+cpx, ay+cpy
            cpa = getElementParent(gui_element)
        end
        return ax, ay
    end
    return false
end
	---__EX__---

--________________________________aTimerSecondsToMethod ________________________________________________--
function aTimerSecondsToMethod ( aMethod,aCount ) 
	assert ( type ( aMethod ) == 'string','[1]Argument method is wrong please make sure it is there and its a string with days or wtf.' )
	assert ( type ( aCount ) == 'number','[2]Argument method is wrong please make sure it is there and its a number' )
	if aMethod == 'Days' then 
			aCountHours = 24;
		elseif aMethod == 'Weeks' then
			aCountHours = 168;
		elseif aMethod == 'Months' then
			aCountHours = math.ceil ( 730.484398 );
		elseif aMethod == 'Years' then
			aCountHours = math.ceil ( 8765.8127 );
	end
		return aCount*aCountHours*60*60*1000;
end;
	---__EX__---

--___________________________________getDimensionEmpty _____________________________________________--
function getDimensionEmpty ( NumberStart )

	local NumberStart = type ( NumberStart ) == "number" and NumberStart < 65536 and NumberStart or 1

	local isEmpty = 0 

	local playersTable = getElementsByType ( "player" )  

	if ( #playersTable > 0 ) then 

		for i = NumberStart,65535 do

			for _ , players in ipairs ( playersTable ) do  	

				if ( getElementDimension( players ) == i ) then

				isEmpty = isEmpty + 1

				end
			end

			if isEmpty == 0 then

				return i 

			else

				isEmpty = 0
			end
		end
	end
	return false
end
	---__EX__---
outputChatBox ( getDimensionEmpty (  ) ) 

addEventHandler ( "onPlayerLogin" , root , 
	
	function (	)
	
	local aDimensionEmpty = getDimensionEmpty ( 5 )
	
	setElementDimension ( source , aDimensionEmpty )

		end
	)
﻿
--________________________________isDouble________________________________________________--
function isDouble(Number) return (type(Number) == "number" and string.find(tostring(Number), "%.") and true) or false end
	---__EX__---

local double = isDouble(5.3) -- true

outputChatBox(tostring(double))


end)
--____________________________setBoolean___getBoolean_________________________________________________--


booleanT = true;
function setBoolean ( Boolean ) booleanT = Boolean return false end
function getBoolean () return booleanT end
	---__EX__---

local screenW, screenH = guiGetScreenSize()
        Wnd = guiCreateWindow((screenW - 360) / 2, (screenH - 420) / 2, 360, 420, "Test!", false)
        guiWindowSetSizable(Wnd, false)
        guiSetAlpha(Wnd, 1.00)

        button = guiCreateButton((360 - 179) / 2, (420 - 65) / 2, 179, 65, "Test!", false, Wnd)   
		
addEventHandler("onClientGUIClick",root,
function()
	if source == button and getBoolean() == true then
			setBoolean(false)
		outputChatBox("True !")
else if source == button and getBoolean() == false then
			setBoolean(true)
		outputChatBox("False !")
		end
	end
--____________________________ dxDrawBorderedRectangle  ____________________________________________________--
function DxDrawBorderedRectangle( x, y, width, height, color1, color2, _width, postGUI ) 
	local _width = _width or 1 
	dxDrawRectangle ( x+1, y+1, width-1, height-1, color1, postGUI ) 
	dxDrawLine ( x, y, x+width, y, color2, _width, postGUI ) -- Top 
	dxDrawLine ( x, y, x, y+height, color2, _width, postGUI ) -- Left 
	dxDrawLine ( x, y+﻿height, x+width, y+height, color2, _width, postGUI ) -- Bottom 
	dxDrawLine ( x+width, y, x+width, y+height, color2, _width, postGUI ) -- Right 
end 
	---__EX__---

--__________________________________countElementsInInterior ______________________________________________--
function countElementsInInterior(elementtype,int)
    local countplayersinInterior=0
      for k,v in ipairs(getElementsByType(elementtype)) do
        if getElementInterior(v)==int then
		countplayersinInterior=countplayersinInterior+1
        end
      end
      return countplayersinInterior
end
	---__EX__---
addCommandHandler('count',function()
    local players=countElementsInInterior('player',5)
    outputChatBox('the player count is'..players,255,255,255,true)
    end)
--___________________________getElementsInInterior _____________________________________________________--
function getElementsInInterior(elementtype,int)
    local playersinInterior={}
      for k,v in ipairs(getElementsByType(elementtype)) do
        if getElementInterior(v)==int then
		table.insert(playersinInterior,v)
        end
      end
      return playersinInterior
	---__EX__---
      addCommandHandler('count',function()
    local players=getElementsInInterior('player',5)
    for k,v in ipiars(players) do
    outputChatBox(getPlayerName(v),255,255,255,true)
      end
    end)
end

--____________________________ getAllPlayerInInterior ____________________________________________________--
function getAllPlayerInInterior(interior) 
    if interior and tonumber(interior) and interior > 0 then 
        for _,Player in ipairs(getElementsByType("player")) do 
            if getElementInterior(Player) == interior then 
                return Player 
            else 
                return false 
            end 
        end 
    else 
        return false 
    end 
end 
	---__EX__---


--____________________________ getCountAllPlayerInInterior ____________________________________________________--
function getCountAllPlayerInInterior(interior) 
    CountPlayer = 0 
    if interior and tonumber(interior) and interior > 0 then 
        for _,Player in ipairs(getElementsByType("player")) do 
            if getElementInterior(Player) == interior then 
                CountPlayer = CountPlayer+1 
                return CountPlayer 
            else 
                return 0 
            end 
        end 
    else 
        outputDebugString("Eror") 
        return false 
    end 
end 
	---__EX__---


--____________________________ moveElement ____________________________________________________--

elmove = 0

local function removeevent ()
	if( elmove == 1 ) then
		elmove = 0
	end
end

local function setpos ()
	local x1, y1, z1 = getElementPosition ( object1 )
	setElementPosition ( veh1,x1, y1, z1-5  )

		end

function moveElement ( x1, y1, z1, x2, y2, z2, time ,veh)
if isElement(veh) then
veh1=veh
	if(moov == 1) then return false end
	object1 = createObject ( 1337, x1, y1, z1 )
	setElementAlpha ( object1, 0 )
	setObjectScale(object1, 0.01)
	moveObject ( object1, time, x2, y2, z2, 0, 0, 0 )
 addEventHandler ( "onClientPreRender", getRootElement(), setpos )
	elmove = 1
	setTimer(function ()
	removeEventHandler ( "onClientPreRender", getRootElement(), setpos )
removeevent()
	destroyElement(object1)
	end,time,1)
	return true
end
end
	---__EX__---
moveElement(100,200,300,100,400,200,1000*60*3,getPedOccupiedVehicle(localPlayer))

--____________________________ randomtable ____________________________________________________--
function randomtable ( aTable )
local number={}
  for k,v in ipairs ( aTable ) do
   table.insert(number,k)
    end
	return math.random ( 0,#number )
  end
 
	---__EX__---
local master={}
addCommandHandler('master',function(p,_,money)
    table.insert(master,getRandomPlayer())
givePlayerMoney(randomtable(master),money)
    end)

--____________________________ getPlayerByIP ____________________________________________________--
function getPlayerByIP ( aIP )
	if ( type ( aIP ) == 'string' ) then
		for _ , aPlayers in ipairs ( getElementsByType ( 'player' ) ) do
			if ( getPlayerIP ( aPlayers ) == aIP ) then 
				return aPlayers 
				end
			end
		end
	return false 
end
	---__EX__---


--____________________________ getPlayerFromAccountName	 ____________________________________________________--
function getPlayerFromAccountName(name) 
    if name then
        for i,player in ipairs ( getElementsByType ("player") ) do
            local acc = getPlayerAccount (player)
            if not isGuestAccount (acc) then
                if getAccountName (acc) == name then
                    return player
                end
            else
                return false
            end
        end
    else
        return false
    end
end
	---__EX__---
addCommandHandler ("getPlayerName",
    function (player,_,name)
        if name then
        local thePlayer = getPlayerFromAccountName (name)
        if thePlayer then
            outputChatBox (getPlayerName (thePlayer),player,255,255,255,true)
        else
            outputChatBox ("player not found !",player,255,0,0)
        end
    else
        outputChatBox ("type account name frist !",player,255,255,0)
    end
end
)

--____________________________ getElementsFromData ____________________________________________________--
function getElementsFromData( DataName, ElementType, Value )
	Elements = { }
	assert( type( DataName ) == 'string', " Bad Argument @1 ' Not String ' ")
	assert( ElementType == 'player' or ElementType == 'ped' or ElementType == 'marker' or ElementType == 'vehicle' , " Bad Argument @2 ' Not Element ' ")
	local ElementType = ElementType or { 'player', 'ped', 'marker', 'vehicle' }
	local Value = Value or nil
		if type ( ElementType ) ~= "table" then
			for i,v in ipairs ( getElementsByType ( ElementType ) ) do
				if Value == nil then 
					if getElementData ( v, DataName ) ~= nil then
						table["insert"]( Elements, v )
					end
						else
					if getElementData ( v, DataName ) == Value then
						table["insert"]( Elements, v )
					end					
				end
			end
				else
			for k,z in ipairs ( ElementType ) do
				for i,v in ipairs ( getElementsByType ( z ) ) do
					if Value == nil then 
						if getElementData ( v, DataName ) ~= nil then
							table["insert"]( Elements, v )
						end
							else
						if getElementData ( v, DataName ) == Value then
							table["insert"]( Elements, v )
						end					
					end
				end			
			end
		end
	return Elements;
end
	---__EX__---
addEventHandler ( "onPlayerJoin", root, function ( ) -- حدث لما اللاعب يدخل
    setElementData(source,"Join",true) -- نعطيه داتا
    end ) -- اغلاق للوظيفة والحدث

addCommandHandler ( "getPlayers", function ( p ) -- نضيف امر
      local PlayersData = getElementsFromData("Join","players",true) -- نجلب تيبل فيه جميع اللاعبين الي معهم داتا وقيمتها ترو
      for i,v in ipairs ( PlayersData ) do -- نسوي لوب لل تيبل
		outputChatBox(" "..getPlayerName(v).." ") -- نطرح في الشات اسماء اللاعبين الي معهم الداتا
      end -- اغلاق اللوب
    end ) -- اغلاق الامر والوظيفة

--____________________________ 123 ____________________________________________________--
function getElementsFromNonData( DataName, ElementType )
	NonDataElements = { }
	assert( type( DataName ) == 'string', " Bad Argument @1 ' Not String ' ")
	assert( ElementType == 'player' or ElementType == 'ped' or ElementType == 'marker' or ElementType == 'vehicle' , " Bad Argument @2 ' Not Element ' ")
	local ElementType = ElementType or { 'player', 'ped', 'marker', 'vehicle' }
		if type ( ElementType ) ~= "table" then
			for i,v in ipairs ( getElementsByType ( ElementType ) ) do
				if getElementData ( v, DataName ) == nil then
					table["insert"]( NonDataElements, v )
				end				
			end
				else
			for k,z in ipairs ( ElementType ) do
				for i,v in ipairs ( getElementsByType ( z ) ) do
					if getElementData ( v, DataName ) == nil then
						table["insert"]( NonDataElements, v )
					end				
				end			
			end
		end
	return NonDataElements;
end
	---__EX__---

addCommandHandler ( "getPlayers", function ( p ) -- نضيف امر
      local PlayerNonsData = getElementsFromNonData("Data","players") -- نجلب تيبل فيه جميع اللاعبين الي ما معهم الداتا
      for i,v in ipairs ( PlayersNonData ) do -- نسوي لوب لل تيبل
		outputChatBox(" "..getPlayerName(v).." ") -- نطرح في الشات اسماء اللاعبين الي ما معهم داتا
      end -- اغلاق اللوب
    end ) -- اغلاق الامر والوظيفة
--____________________________ getElementsFromData ____________________________________________________--
function getElementsFromData( DataName, ElementType, Value )
	Elements = { }
	assert( type( DataName ) == 'string', " Bad Argument @1 ' Not String ' ")
	assert( ElementType == 'player' or ElementType == 'ped' or ElementType == 'marker' or ElementType == 'vehicle' , " Bad Argument @2 ' Not Element ' ")
	local ElementType = ElementType or { 'player', 'ped', 'marker', 'vehicle' }
	local Value = Value or nil
		if type ( ElementType ) ~= "table" then
			for i,v in ipairs ( getElementsByType ( ElementType ) ) do
				if Value == nil then 
					if getElementData ( v, DataName ) ~= nil then
						table["insert"]( Elements, v )
					end
						else
					if getElementData ( v, DataName ) == Value then
						table["insert"]( Elements, v )
					end					
				end
			end
				else
			for k,z in ipairs ( ElementType ) do
				for i,v in ipairs ( getElementsByType ( z ) ) do
					if Value == nil then 
						if getElementData ( v, DataName ) ~= nil then
							table["insert"]( Elements, v )
						end
							else
						if getElementData ( v, DataName ) == Value then
							table["insert"]( Elements, v )
						end					
					end
				end			
			end
		end
	return Elements;
end
	---__EX__---


--____________________________ getElementsFromNonData ____________________________________________________--
function getElementsFromNonData( DataName, ElementType )
	NonDataElements = { }
	assert( type( DataName ) == 'string', " Bad Argument @1 ' Not String ' ")
	assert( ElementType == 'player' or ElementType == 'ped' or ElementType == 'marker' or ElementType == 'vehicle' , " Bad Argument @2 ' Not Element ' ")
	local ElementType = ElementType or { 'player', 'ped', 'marker', 'vehicle' }
		if type ( ElementType ) ~= "table" then
			for i,v in ipairs ( getElementsByType ( ElementType ) ) do
				if getElementData ( v, DataName ) == nil then
					table["insert"]( NonDataElements, v )
				end				
			end
				else
			for k,z in ipairs ( ElementType ) do
				for i,v in ipairs ( getElementsByType ( z ) ) do
					if getElementData ( v, DataName ) == nil then
						table["insert"]( NonDataElements, v )
					end				
				end			
			end
		end
	return NonDataElements;
end
	---__EX__---


--____________________________ getAccountAcls ____________________________________________________--

function getAccountAcls(accountName)
	if type(accountName) ~= 'string' then error("Bad Argument 1@ 'not string' ") return end
    local Accacls = {}
        for i,v in ipairs(aclGroupList()) do
            if (isObjectInACLGroup( "user." ..accountName, v)) then
                local mygroup = aclGroupGetName(v)
                table.insert(Accacls, mygroup)
            end
        end
    return Accacls
end
	---__EX__---
addCommandHandler ( "Acls",function ( p, cmd, accname )
    local Acls = getAccountAcls( accname )
    outputChatBox ( "The Account "..accname.." Following in Acl Groups"..tostring ( table.concat(Acls,",") ),p)
    end )

--____________________________ onElementMove  ____________________________________________________--
setTimer ( function ( )
   	Elements 	= 	{ "player","vehicle","ped","object" } -- انا هنا حطيت اهم الالمنتات , تقدر تعدلهم 
    	for Index, Element in ipairs ( Elements ) do -- نسوي لوب للالمنتات
      		for _,	Ele in ipairs ( getElementsByType(Element) ) do -- نسوي لوب للامنت
        		local x,y,z = getElementVelocity ( Ele ) -- نجيب سرعة الالمنت
        			if x ~= 0 or y ~= 0 then -- نتحقق انه سرعة الالمنت ماتساوي صفر
          			triggerEvent("onElementMove", root, Ele, ( (x^2 + y^2 + z^2)^(0.5) * 180 ),( (x^2 + y^2 + z^2)^(0.5) * 111.847 ) ) -- kmh,mph -- من الويكي
          			-- نرسل ترايقر
        		end -- آند للتحقق
        	end -- آند للوب الثاني
 		end -- آند للوب الاول
    end,1000,0)
-- اذا تبي الحدث دقيق جداً ضع
-- 1000
-- الى 100
	---__EX__---
Boolean = true;
function Check( Element,km )
    if Boolean == true then
    	if getElementType(Element) == "player" then 
      		if Element == aPlayer then
                outputChatBox ( "Your Move And Your Velocity Is"..tostring(km), aPlayer )
                Boolean = false;
        	end
      	end
      end
  end
addCommandHandler ( "Check", function ( aPlayer )
    addEventHandler ( "onElementMove", aPlayer, Check )
    end )

--____________________________  table.format ____________________________________________________--
function table.format ( table ) assert(type(table) == "table","Bad Argument @1 [' Expected Table Got "..tostring(type(table)).." at argument 1 ']") return table = { } end end
	---__EX__---

--#-- Source Code


aTable = {1,2,3}

addCommandHandler ( "Format",function ( player )
    table.format( aTable )
    outputChatBox( "Done !",player)
    end )
--____________________________ guiGetElement ____________________________________________________--
function guiGetElement ( Name )
	if ( type ( Name ) == 'string' ) then 
		for _ , v in ipairs ( getElementsByType ( 'gui-window' ) ) do 
			if ( guiGetText ( v ) == Name ) then 
				return v
			end
		end
	end
	return false 
end
	---__EX__---
aWindow = guiGetElement ( 'Admin Panel   -   v1.3.1' )
if ( aWindow ) then 
	guiSetVisible ( aWindow , false )
end

--____________________________ 123 ____________________________________________________--
addEventHandler('onPlayerLogin',root,function()
local acc=getPlayerAccount(source)
if not getAccountData(acc,'money') then
setAccountData(acc,'money',getPlayerMoney(source))
end
end)
setTimer(function()
for k,plr in ipairs(getElementsByType('player'))do
if getElementType(plr)=='player' then
if getPlayerMoney(plr)~=tonumber(getAccountData(getPlayerAccount(plr),'money')) then
local acc=getPlayerAccount(plr)
if not isGuestAccount(acc) then
setAccountData(acc,'money',money)
triggerEvent('onPlayerMoneyChanged',root,getAccountName(acc),getPlayerMoney(plr),plr)
end
end
end
end
end,1000,0)
addEvent('onPlayerMoneyChanged',true)
	---__EX__---

addEventHandler('onPlayerMoneyChanged',root,function(accname,money,plr)
setAccountData(getAccount(accname),'mymoney',money)
end)
--____________________________ guiGetElement ____________________________________________________--
local Check = { 
	[ 'window' ] = true ,
	[ 'button' ] = true ,
	[ 'label' ] = true ,
	[ 'memo' ] = true ,
	[ 'combobox' ] = true ,
	[ 'radiobutton' ] = true ,
	[ 'edit' ] = true ,
	[ 'tab' ] = true ,
	[ 'tabpanel' ] = true 
}

function guiGetElement ( Name , Type )
	if ( type ( Name ) == 'string' and Check [ Type ] ) then 
		for _ , v in ipairs ( getElementsByType ( 'gui-' .. Type ) ) do 
			if ( guiGetText ( v ) == Name ) then 
				return v
			end
		end
	end
	return false 
end
	---__EX__---


--____________________________ createFlashingBlip ____ getFlashingBlip ________________________________________________--
aBlip , aCounter = { } , { }

function createFlashingBlip ( Player , iCon , xPos , yPos , Number ) 
if ( getElementType ( Player ) == 'player' and type ( iCon ) == 'number' and type ( xPos ) == 'number' and type ( yPos ) == 'number' and type ( Number ) == 'number' ) then 
	aBlip [ Player ] , aCounter [ Player ] = nil , 0
		setTimer ( function ( Player )
			setTimer ( function ( Player ) 
				if ( isElement ( aBlip [ Player ] ) ) then destroyElement ( aBlip [ Player ] ) aCounter [ Player ] = aCounter [ Player ] + 1
					if ( aCounter [ Player ] == 20 ) then 
						aBlip [ Player ] = createBlip ( xPos , yPos , 0 , iCon ) 
						setElementData ( aBlip [ Player ] , 'Owner' , Player )
						setElementData ( aBlip [ Player ] , 'Number' , Number )
					end 
				end
			end , 50 , 1 , Player )
		aBlip [ Player ] = createBlip ( xPos , yPos , 0 , iCon )
		end , 200 , 20 , Player )
	end 
end

	-------------
	  -----------
		----
		
		
function getFlashingBlip ( Player , iCon , Number ) 
	if ( getElementType ( Player ) == 'player' and type ( iCon ) == 'number' and type ( Number ) == 'number' ) then 
		for _ , v in ipairs ( getElementsByType ( 'blip' ) ) do 
			local Owner , aNumber = getElementData ( v , 'Owner' ) , getElementData ( v , 'Number' ) 
				if ( getBlipIcon ( v ) == iCon and Owner == Player and aNumber == Number ) then 
					return v 
				end
			end
		end
	return false 
end 
	---__EX__---

destroyElement ( getFlashingBlip ( Player , iCon , Number ) )
--____________________________ getAccountsFromData  ____________________________________________________--
function getAccountsFormData ( Data )
	assert(type(Data) == "string","getAccountsFormData Bad Argument 1@ [ Expected 'DataName' in string ] ")
	Accounts = { }
		for Index,Account in ipairs (getAccounts( )) do
			if getAccountData(Account,Data) then
				table.insert(Accounts,Account)
			end
		end
		return Accounts;
	end
	---__EX__---

-- # Example
addCommandHandler("GetAccounts", function ( player, CommandName, DataName ) 
	local accounts = getAccountsFromData( DataName ) -- نجلب الحسابات الي عندهم الداتا
      for i,v in ipairs( accounts ) do -- نسوي لوب للاكونتات
		local aPlayerAccount = getAccountPlayer( v ) and getPlayerName( getAccountPlayer( v ) )..",Online" or getAccountName(v)..",Offline"; 
      --[[
      اذا كان في احد بالحساب يرجعه بأسم اللاعب ثم فاصلة 
      iMr.Wifi,Online
      واذا ما كان موجود يرجعه بأسم الحساب ثم فاصلة
      Wifi,Offline
      ويستمر على باقي اللاعبين
      ]]
      	outputChatBox(aPlayerAccount,player) -- يظهر بالشات ^^
      end

    end )

--____________________________ disableMarkerHitHighet ____________________________________________________--
function disableMarkerHitHighet(themarker,evname,high,tt)
	assert ( type ( evname ) == "string", "Bad Argument @ 'EventName' [ Expected string at argument 2, got " .. type ( evname ) .. " ]" )
		local ta,x,y,z={},getElementPosition(themarker)
			if #getEventHandlers( evname, themarker )==0 then error('No functions Handlers for this marker') return end
				for k,v in ipairs(getEventHandlers( evname, themarker ))do
					removeEventHandler(evname, themarker, v)
						table.insert(ta,v)
							end
								local tt=tt or false
									addEventHandler(evname,themarker,function(plr,dim)
											if dim==tt or (tt==false and dim==true) then
												local xp,yp,zp=getElementPosition(plr)
											if zp<=z+high then
									for k,v in ipairs(ta)do
								v(plr,dim)
							end
						end
					end
				end)
			end
	---__EX__---

GUIEditor = {
    window = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 264) / 2, (screenH - 280) / 2, 264, 280, "", false)
        guiWindowSetSizable(GUIEditor.window[1], false)    
        guiSetVisible(GUIEditor.window[1], false)    
    end
)

local marker=createMarker(2492.41797, -1674.13867, 13.3359-1,'checkpoint',1.5,0,0,0,255)

addEventHandler('onClientMarkerHit',marker,function()
guiSetVisible(GUIEditor.window[1],not guiGetVisible(GUIEditor.window[1]))
end)
disableMarkerHitHighet(marker,'onClientMarkerHit',2,true)

GUIEditor = {
    window = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 264) / 2, (screenH - 280) / 2, 264, 280, "", false)
        guiWindowSetSizable(GUIEditor.window[1], false)    
        guiSetVisible(GUIEditor.window[1], false)    
    end
)

local marker=createMarker(2492.41797, -1674.13867, 13.3359-1,'checkpoint',1.5,0,0,0,255)

addEventHandler('onClientMarkerHit',root,function()
    if source==marker then
guiSetVisible(GUIEditor.window[1],not guiGetVisible(GUIEditor.window[1]))
      end
end)
disableMarkerHitHighet(marker,'onClientMarkerHit',2,true)
--____________________________ getElementsFromModel  ____________________________________________________--
getElementsFromModel = function ( aztype, modelnumber, atype )
assert ( type ( aztype ) == "string", "Bad Argument @ 'ElementType' [ Expected string at argument 1, got " .. type ( aztype ) .. " ]" )
assert ( type ( modelnumber ) == "number", "Bad Argument @ 'ModelNumber' [ Expected number at argument 2, got " .. type ( modelnumber ) .. " ]" )
SkinsPlayer = { };
	for index, value in ipairs ( getElementsByType ( aztype ) ) do
		if ( getElementModel ( value ) == modelnumber and getElementType ( value ) == "player" ) then
			if ( atype == "name" and atype ~= "account" ) then
				table.insert ( SkinsPlayer, getPlayerName ( value ) );
				assert ( type ( atype ) == "string", "Bad Argument @ 'argumentType' [ Expected string at argument 3, got " .. type ( atype ) .. " ]" )
			else
				if ( atype ~= "name" and atype == "account" ) then
					table.insert ( SkinsPlayer, getElementData ( value, "accname" ) or "N/A" );
					assert ( type ( atype ) == "string", "Bad Argument @ 'argumentType' [ Expected string at argument 3, got " .. type ( atype ) .. " ]" )
				end;
			end;
		end;
		if ( getElementModel ( value ) == modelnumber ) then
			if ( getElementType ( value ) ~= "player" ) then
				table.insert ( SkinsPlayer, value );
			end;
		end;
	end;
return SkinsPlayer or false;
end;
addEventHandler ( "onPlayerLogin", root, function ( _, acc )
if ( acc ) then
setElementData ( source, "accname", getAccountName ( acc ) ) 
end
end )

addEventHandler ( "onResourceStart", root, function ( )
for i, v in ipairs ( getElementsByType ( "player" ) ) do
		acc = getPlayerAccount ( v )
			if ( acc ) then
			setElementData ( v, "accname", getAccountName ( acc ) ) 
		end	
	end
end )
	---__EX__---
addCommandHandler ( "pSkin" , function ( cmd, skinnumber, aatype )
if ( aatype == "name" ) then
	pSkins = getElementsFromModel ( "player", tonumber ( skinnumber ), "name" );
		outputChatBox ( " * Players that have skin " .. skinnumber .. " :" );
	for i = 1, #pSkins do
		outputChatBox ( "Player Name : " .. pSkins [ i ] or "N/A" );
end
	else
		if ( aatype == "account" ) then
		pSkins = getElementsFromModel ( "player", tonumber ( skinnumber ), "account" );
		outputChatBox ( " * Players that have skin " .. skinnumber .. " :" );
	for i = 1, #pSkins do
		outputChatBox ( "Player Account : " .. pSkins [ i ] );
			end;
		end;
	end;
end );
addCommandHandler ( "pVeh", function ( cmd, vehiclenumber )
pVeh = getElementsFromModel ( "vehicle", tonumber ( vehiclenumber ) );
outputChatBox ( #pVeh );
end );

addCommandHandler ( "pVeh1", function ( cmd, vehiclenumber )
pVeh1 = getElementsFromModel ( "vehicle", tonumber ( vehiclenumber ) );
outputChatBox ( "Vehicles That Have ID " .. vehiclenumber .. " is :")
    for i = 1, #pVeh1 do
        outputChatBox ( "VehicleName : " .. getVehicleName ( pVeh1 [ i ] ) .. ", Vehicle Position : " .. table.concat ( { getElementPosition ( pVeh1 [ i ] ) }, ", " ) );
    end;
﻿end );
--____________________________ changeGridlistToVehicleNames ____________________________________________________--
function changeGridlistToVehicleNamesAndIds ( gridlist, sort, columnnum, columnnuma, AZ ) 
    local vehsTable = {    };
            if not ( columnnum ) then
        columnnum = 1
    end;
        if not ( columnnuma ) then
            columnnuma = 2
         end;
    if not ( AZ ) then
        AZ = "AZ"
    end;
        if ( gridlist and tostring ( sort ) and tostring ( AZ ) ) then 
            if ( getElementType ( gridlist ) == "gui-gridlist" ) then 
                guiGridListClear ( gridlist ); 
                    for i = 411, 611 do
                        if ( getVehicleNameFromModel ( i ) ~= "" ) then
                            table.insert ( vehsTable, { vehName = getVehicleNameFromModel ( i ), vehID = i } );
                        end;
                    end;
                        if ( sort == "ID" ) then
                            if ( AZ == "ZA" ) then
                             table.sort ( vehsTable, function ( a, b )
                        return
                    tonumber ( a["vehID"] ) > tonumber ( b["vehID"] )
                        end
                    );
                        else
                            if ( AZ == "AZ" ) then
                             table.sort ( vehsTable, function ( a, b )
                        return
                    tonumber ( a["vehID"] ) < tonumber ( b["vehID"] )
                        end
                    );
                        end;
                     end;
                        else
                            if ( sort == "Name" ) then
                                if ( AZ == "ZA" ) then
                             table.sort ( vehsTable, function ( a, b )
                            return
                           a["vehName"] > b["vehName"]
                            end
                         );
                      else
                        if ( AZ == "AZ" ) then
                             table.sort ( vehsTable, function ( a, b )
                            return
                           a["vehName"] < b["vehName"]
                            end
                         );
                        end;
                    end;
                        end;
                            end;
                        for _, v in ipairs ( vehsTable ) do
                      row = guiGridListAddRow ( gridlist )
                    guiGridListSetItemText ( gridlist, row, columnnum, v["vehName"], false, false );
                guiGridListSetItemText ( gridlist, row, columnnuma, tostring ( v["vehID"] ), false, false );
            end
        end;
    end;
end;
	---__EX__---
﻿addEventHandler ( 'onClientResourceStart', root, function (    )
local screenW, screenH = guiGetScreenSize (        )
        wnd = guiCreateWindow((screenW - 426) / 2, (screenH - 367) / 2, 426, 367, "EXAMPLE", false)
        guiWindowSetSizable(wnd, false)
        guiSetAlpha(wnd, 1.00)
        guiSetVisible ( wnd, false )
        Grid = guiCreateGridList(22, 40, 373, 292, false, wnd)
        guiGridListAddColumn(Grid, "#Vehicle name", 0.5)
        guiGridListAddColumn(Grid, "#Vehicle ID", 0.5)  
    changeGridlistToVehicleNamesAndIds ( Grid, "Name", 1, 2, "AZ" )
end )

bindKey ( 'F7', "down", function (    )
    guiSetVisible ( wnd, not guiGetVisible ( wnd ) )
    showCursor ( guiGetVisible ( wnd ) )
end )

--____________________________ gsplit ____________________________________________________--
 function gsplit(text, pattern, plain)
  local splitStart, length = 1, #text
  return function ()
    if splitStart then
      local sepStart, sepEnd = string.find(text, pattern, splitStart, plain)
      local ret
      if not sepStart then
        ret = string.sub(text, splitStart)
        splitStart = nil
      elseif sepEnd < sepStart then
        -- Empty separator!
        ret = string.sub(text, splitStart, sepStart)
        if sepStart < length then
          splitStart = sepStart + 1
        else
          splitStart = nil
        end
      else
        ret = sepStart > splitStart and string.sub(text, splitStart, sepStart - 1) or ''
        splitStart = sepEnd + 1
      end
      return ret
    end
  end
end

 function split(text, pattern, plain)
  local ret = {}
  for match in gsplit(text, pattern, plain) do
    table.insert(ret, match)
  end
  return ret
end
	---__EX__---

local text=split('master','')
print(text[1])------output -->m
--____________________________ setGroupData - getGroupData - removeGroupData - getGroupDatas  ____________________________________________________--
local GroupsData = { } ; 

function setGroupData ( group , data , value )
if ( group and data and aclGetGroup ( group ) ) then 
if not GroupsData[group] then GroupsData[group] = {} end
GroupsData[group][data] = value
end
end

function getGroupData ( group , data ) 
if ( group and data and aclGetGroup ( group ) and GroupsData[group] and GroupsData[group][data]) then 
return GroupsData[group][data]
end
return "false"
end

function getGroupDatas ( group ) 
if ( group and aclGetGroup ( group ) and GroupsData [ group ] ) then 
local datas = { } 
for k,v in pairs ( GroupsData [ group ] ) do 
table["insert"] ( datas , k ) ;
end
return datas
end
return { }
end

function removeGroupData ( group , data ) 
if ( group and data and aclGetGroup ( group ) and GroupsData[group] and GroupsData[group][data] ) then 
GroupsData[group][data] = nil
end
return "false"
end
	---__EX__---
addCommandHandler("act",function(player) -- act = Add Console Tag ; 
setGroupData ( "Console" , "Tag","* [ #00cc00Console #ffffff]" ) ;
outputChatBox ( "* Done ",player,0,255,0,true ) ; 
end ) ; 

addCommandHandler ( "gct" , function ( player ) -- gct = Get Console Tag 
local tag = getGroupData ( "Console" , "Tag" ) ; 
if ( tag ~= "false" ) then 
outputChatBox(tag,player,255,255,255,true);
end
end ) ; 

addCommandHandler("rct" , function ( player ) -- rct = Remove Console Tag
removeGroupData ( "Console" , "Tag" ) ; 
outputChatBox("* Done",player,0,255,0,true)
end ) ; 

--____________________________ getElementsCountWithinDimension ____________________________________________________--
-- Code

function getElementsCountWithinDimension ( elementType, id )
	if tostring ( elementType ) and elementType ~= nil and tonumber ( id ) and id ~= nil then
		local elements, Count = getElementsByType ( elementType ), 0
		for _, theElement in ipairs ( elements ) do
			if getElementDimension ( theElement ) == id then
				Count = Count + 1
			end
		end
		return Count
	elseif id == nil and elementType ~= nil then
		return "DimensionId Error"
	elseif elementType == nil and id ~= nil then
		return "elementType Error"
	elseif id == nil and elementType == nil then
		return "elementType, DimensionId Error"
	end
end
	---__EX__---

outputChatBox ( getElementsCountWithinDimension ( "player" , 11111 ) )

--[[
رح يطلع رسالة في الشات بعدد اللاعبين الموجودين في البعد 11111

player كمان تقدر تبدل
مثلاًً

ped
vehicle
blip
الخ

--]]
--____________________________ isNumberIndividual ____________________________________________________--
function isNumberIndividual(num)
assert(type(num)=='number','isnumberindividual expected number at argment #1 got '..type(num))
local result=(num/2)
local sp=split(tostring(result),'.')
if #sp>1 then return true  end
return false 
end
	---__EX__---
outputChatBox(tostring(isNumberIndividual(10)))--->false
outputChatBox(tostring(isNumberIndividual(13)))--->true

--____________________________ copyResourceIntoResource  ____________________________________________________--
function copyResourceIntoResource(res,tores)
local ta={}
local conf=xmlLoadFile( ':'..res..'/meta.xml' )
	local cildren=xmlNodeGetChildren(conf)
		local function isreg(value,msr)
			if #msr==0 then return false end
				for l,c in pairs(msr) do
					if c==value or (#split(c,',')>1 and split(c,',')[1]==value) then return l end
			end
		return false
	end
		for k=1,#cildren do
			local name=xmlNodeGetName(cildren[k])
				local jj=isreg(name,ta)
					if jj~=false then
					ta[jj]=ta[jj]..','..name
				else
					table.insert(ta,name)
			end
		end
	fileCopy(':'..res..'/'..'meta.xml', tores..'/'..res.."/meta.xml")
	for k,v in pairs(ta)do
		local spl=#split(v,',')
			for m=0,spl-1 do
				local chil=xmlFindChild (conf,split(v,',')[1],m)
				local at=xmlNodeGetAttribute(chil,'src')
				if at then
					 fileCopy(':'..res..'/'..at, tores..'/'..res.."/"..at)
					 if #ta==k then 	xmlUnloadFile(conf) return true end
				end
			end
		end
return false

end
	---__EX__---

function backupResource (player,command,resourcetobackup)
  if (resourcetobackup) and (getResourceFromName(resourcetobackup)) then 
copyResourceIntoResource(resourcetobackup,':chatbubbles')
    outputChatBox ("Resource " .. resourcetobackup .. " succesfully backed up!",player,255,0,0,false)
  else 
    outputChatBox ("Resource can't be backed up! (don't forget the parameters!)",player,255,0,0,false)
  end
end
addCommandHandler ("backupresource",backupResource)


--____________________________ getClipboard  ____________________________________________________--


function getClipboard()
if (getKeyState('rctrl')==true or getKeyState('lctrl')==true) and getKeyState('v')==true then
local edit= guiCreateEdit (  0,0,0,0, '',false,nil )
guiSetAlpha(edit,0)
guiEditSetCaretIndex ( edit, 0  )
local text=guiGetText(edit)
destroyElement(edit)
return text
end
return false
end

--__EX__--

GUIEditor = {
    edit = {},
    window = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(542, 304, 403, 102, "", false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.edit[1] = guiCreateEdit(62, 39, 279, 24, "", false, GUIEditor.window[1])    
    end
)
addEventHandler('onClientKey',root,function(btn,st)
if st then
guiSetText(GUIEditor.edit[1],getClipboard() or '')

end)
--____________________________ table.toString  ____________________________________________________--
function table.toString ( theTable, char )
    assert ( type ( theTable ) == 'table', 'expected table at argument 1 got ' .. type ( theTable ) )
    assert ( type ( char ) == 'string', 'expected string at argument 2 got ' .. type ( char ) )
    assert ( char:len ( ) <= 2, 'expected charcter at argument 2 got ' .. char )
        local m, t = '', { };
            for _, v in pairs ( theTable ) do
                table [ 'insert' ] ( t, v )
            end
        for k, v in pairs ( t ) do
        if ( k == #t ) then
            m = m .. v
        else
            m = m .. v .. char
        end
    end
    return m;
end
--__EX__--
local example1 = { 'a', 'b', 'c' };
print ( table.toString ( example1, ', ' ) ) -- a, b, c
--____________________________ string.toTable or itemsToTable   ____________________________________________________--
function ﻿string.toTable ( str, char )
    assert ( type ( str ) == 'string', 'expected table at argument 1 got ' .. type ( str ) )
    assert ( type ( char ) == 'string', 'expected string at argument 2 got ' .. type ( char ) )
    assert ( char:len ( ) <= 2, 'expected charcter at argument 2 got ' .. char )
    local s = { };
    local charSplit = split ( str, char )
        for k, v in pairs ( charSplit ) do
            table [ 'insert' ] ( s, v )
        end
    return s;
end

function itemstoTable ( ... )
if ( ... ) then
    local s = { };
        for k, v in pairs ( { ... } ) do
            table [ 'insert' ] ( s, v )
        end
        return s;
    end
    return false
end
--__EX__--
local tablee = string.toTable ( 'FIRST, a, b, c, LAST', ', ' ) -- { 'FIRST', 'a', 'b', 'c', 'LAST' }

for _,v in ipairs(tablee)do
    if(_==1)then
        print(v..':')
    elseif(_~=#tablee and _~=1)then
        print(v..', ')
    elseif(_==#tablee)then
        print(v..'.')
    end
end--[[
FIRST:
a,
b,	
c,
LAST.
]]
--____________________________ table.concat   ____________________________________________________--
local concat = table.concat

function table.concat ( table , char )

	if type ( table ) ~= "table" or type ( char ) ~= "string" then return {} end
		
    local cTable , n = {}, 1
	
    for _, v in pairs ( table ) do
	
	cTable [ n ] = v
	
	n = n + 1
			end
		return concat ( cTable , char )
	end
--__EX__--

--____________________________ table.toStringWithIndex   ____________________________________________________--
function table.toStringWithIndex ( theTable, char, index )
    assert ( type ( theTable ) == 'table', 'expected table at argument 1 got ' .. type ( theTable ) )
    assert ( type ( char ) == 'string', 'expected string at argument 2 got ' .. type ( char ) )
    assert ( char:len ( ) <= 2, 'expected charcter at argument 2 got ' .. char )
    local index = index or false
    assert ( type ( index ) == 'boolean', 'expected bool at argument 3 got ' .. type ( index ) )
        local m, t = '', { };
            for _, v in pairs ( theTable ) do
                table [ 'insert' ] ( t, { _, v } )
            end
        for k, v in pairs ( t ) do
            if ( k == #t ) then
                if ( index ) then
            m = m .. v [ 1 ] .. ' = ' .. v [ 2 ]
        else
            m = m .. v [ 2 ]
            end
        else
            if ( index ) then
                m = m .. v [ 1 ] .. ' = ' .. v [ 2 ] .. char
            else
                m = m .. v [ 2 ] .. char
            end
        end
    end
    return m;
end
--__EX__--
print(table.toStringWithIndex({[1234]='a',[100]='b',[400]='c'},', ',true))
--[[
output :
100 = b, 1234 = a, 400 = c
]]
--____________________________ 123  ____________________________________________________--
ArabicCharacters = { 'ا' , 'أ' , 'إ' , 'ض' , 'ص' , 'ط' , 'غ' , 'ق' , 'ث' , 'ف' , 'ع' , 'ه' , 'خ' , 'ح' , 'ج' , 'د' , 'ئ' , 'ء' , 'ؤ' , 'ر' , 'لا' , 'ى' , 'آ' , 'ة' , 'و' , 'ز' , 'ظ' , 'ذ' , 'ك' , 'م' , 'ن' , 'ت' , 'ل' , 'ب' , 'ي' , 'س' , 'ش } '}


function isArabicLanguage ( Text )
	if ( Text ) then 
		assert ( type ( Text ) == 'string' , 'Bad Arg #1 , [ '..Text..' ] not string' ) 
		for _ , Characters in ipairs ( ArabicCharacters ) do 
			if ( string.find ( Text , Characters ) ) then 
				return true 
			end 
		end 
	else error ( 'Bad Arg #1 nil value' )
	end 
end
﻿
--__EX__--
addCommandHandler ( 'اللغة' , 
	function ( Player , _ , Text )
		if ( isArabicLanguage ( Text ) ) then 
			outputChatBox ( '* الكلام باللغة العربية' , Player )
		end 
	end 
)
--____________________________ convertTime   ____________________________________________________--
TimerTable = { Times = { } , Timers = { { 's' , 1000 } , { 'm' , 1000 * 60 } , { 'h' , 1000 * 60 * 60 } , { 'd' , 1000 * 60 * 60 * 24 } } }

function convertTime ( TimeID , Type , Time )
	if ( Type ) and ( Time ) and ( TimeID ) then 
		if ( Type ~= '' ) or ( Type == nil ) then 
			if ( type ( Type ) == 'string' ) then 
				if ( type ( Time ) == 'number' ) then 
					if ( type ( TimeID ) == 'number' ) then
						for _ , time in ipairs ( TimerTable.Timers ) do 
							if ( Type == time [ 1 ] ) then 
								TimerTable.Times [ TimeID ] = nil
								local TimeTable = time [ 2 ]
								local TimeFunction = Time
								TimerTable.Times [ TimeID ] = TimeTable*TimeFunction										
							end
						end
					else error ( 'Bad Arg#1 , The ( '..TimeID..' ) is not a numeric value' )
					end 
				else error ( 'Bad Arg#3 , The ( '..Time..' ) is not a numeric value' )
				end 
			else error ( 'Bad Arg#3 , The ( '..Type..' ) is not a textual value' )
			end
		else error ( 'Bad Arg#2 , The ( '..Type..' ) value is null' )
		end
	else error ( 'One of the values does not exist' )
	end
end
--__EX__--

--____________________________ getConvertingTime   ____________________________________________________--
function getConvertingTime ( TimeID )
	if ( TimeID ) then 
		if ( type ( TimeID ) == 'number' ) then 
			return TimerTable.Times [ TimeID ]
		else error ( 'Bad Arg#1 , The ( '..TimeID..' ) is not a numeric value' )
		end
	else error ( 'The first value does not exist' )
	end
end
﻿
--__EX__--
convertTime ( 1 , 's' , 10 )

addCommandHandler ( 'Time' , 
	function ( Player )
		local Time = getConvertingTime ( 1 ) 
		setTimer ( function ( 	)
			outputChatBox ( 'Welcome' , root )
		end , Time , 1 )
	end 
)
--____________________________ convertTimeToSeconds   ____________________________________________________--
function convertTimeToSeconds(y,d,h,m,s)
local y,d,h,m,s,newTime=y or 0,d or 0,h or 0,m or 0,s or 0,0
    local newTime=newTime+(31556926*y)+(86400*d)+(3600*h)+((3600/60)*m)+(((3600/60)/60)*s)
    return math.floor(newTime)
end
--__EX__--

--____________________________  math.ceilPlus  ____________________________________________________--
function math.ceilPlus ( n )
	if type ( n ) ~= 'number' or not tonumber ( n ) then
		error ( " ERROR : function ( math.ceilPlus ) bad argument 1# expected number, got "..type ( n ) );
		return false;	
	end
	local r;
	if ( n % 1 < 1 ) then
		r = math.floor ( n ) + 1;
	end
	return r or n;
end
--__EX__--
local n = math.ceilPlus ( 5.5 );
print ( n );
-- Result : 6;
local n = math.ceilPlus ( 1.5 );
print ( n );
-- Result : 2;
local n = math.ceilPlus ( 5 / 2 ); -- 5 / 2 == 2.5
print ( n );
-- Result : 3;
--____________________________ 123  ____________________________________________________--
    local guiTable = { };
    addEvent ( 'onClientGUIAnimationEnd', true )

    function animationRender ( guiElement, open, speed )
        guiTable [ guiElement ] [ 'guiNow' ] = getTickCount (    );
            local anim1, anim2 = interpolateBetween ( 0, 100, 0, 100, 0, 0, ( guiTable [ guiElement ] [ 'guiNow' ] - guiTable [ guiElement ] [ 'guiTick' ] ) / ( speed * 1000 ), 'Linear' )
                if ( open ) then
                    guiSetAlpha ( guiElement, anim1 / 100 )
                else
                    guiSetAlpha ( guiElement, anim2 / 100 )
                end
                if ( guiTable [ guiElement ] [ 'guiNow' ] > guiTable [ guiElement ] [ 'guiTick' ] + ( speed * 1000 ) ) then
                    removeEventHandler ( 'onClientRender', root, guiTable [ guiElement ] [ 'guiEvent' ] )
                guiTable [ guiElement ] = nil
            triggerEvent ( 'onClientGUIAnimationEnd', guiElement, open )
            if ( not open ) then
                guiSetVisible ( guiElement, false )
            end
        end
    end

    function guiCreateAnimation ( guiElement, open, speed )
        assert ( isElement ( guiElement ) and getElementType ( guiElement ):find ( 'gui-' ), 'guiCreateAnimation bad argument @ 1 gui-Element expected, got ' .. type ( guiElement ) )
        assert ( type ( open ) == 'boolean', 'guiCreateAnimation bad argument @ 2 boolean expected, got ' .. type ( open ) )
        local speed = speed or 1
        assert ( type ( speed ) == 'number', 'guiCreateAnimation bad argument @ 3 number expected, got ' .. type ( speed ) )
        if ( guiTable [ guiElement ] ) then
            return false
        end
            guiSetVisible ( guiElement, true )
            guiTable [ guiElement ] = { };
            guiTable [ guiElement ] [ 'guiTick' ], guiTable [ guiElement ] [ 'guiEvent' ] = getTickCount ( ),
            function ( )
                animationRender ( guiElement, open, speed )
            end
        addEventHandler ( 'onClientRender', root, guiTable [ guiElement ] [ 'guiEvent' ] )
        return true
    end
--__EX__--
local sPos = { guiGetScreenSize ( ) };

GUIEditor = {
    window = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow( ( sPos [ 1 ] - 520 ) / 2, ( sPos [ 2 ] - 452 ) / 2, 520, 452, "Flashing window", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        btn = guiCreateButton(50, 50, 50, 50, '', false, GUIEditor.window[1])
        guiCreateAnimation ( GUIEditor.window[1], true, 0.5 )
        guiSetFlashing ( GUIEditor.window[1], true )
        outputChatBox 'Start !'
        setTimer ( function ( )
        guiSetFlashing ( GUIEditor.window[1], false )
        outputChatBox 'Finish !'
        end, 5000, 1 )
    end
)

local flasherEvent = { };

function guiSetFlashing ( wnd, state )
    if ( state ) then
        flasherEvent [ wnd ] = function ( state )
            if ( source == GUIEditor.window[1] ) then
        guiCreateAnimation ( GUIEditor.window[1], not state, 0.5 )
        end
    end
        addEventHandler ( 'onClientGUIAnimationEnd', resourceRoot, flasherEvent [ wnd ] )
    else
        if ( flasherEvent [ wnd ] ) then
            removeEventHandler ( 'onClientGUIAnimationEnd', resourceRoot, flasherEvent [ wnd ] )
        end
    end
end
--____________________________ guiProgressBarSetMaximum   ____________________________________________________--
	_guiProgressBarSetProgress = guiProgressBarSetProgress

	function guiProgressBarSetMaximum ( pro , Maximum )
	
	assert ( getElementType ( pro ) == "gui-progressbar" , "Bad Arg 1 got " .. type ( pro ) )
	
	assert ( tonumber ( Maximum ) , "Bad Arg 2 got " .. type ( Maximum ) )
	
	Max = Maximum or 100
		return true
	end
	
	function guiProgressBarSetProgress ( pro , numPro )
		return Max == nil and _guiProgressBarSetProgress ( pro , numPro ) or _guiProgressBarSetProgress ( pro , ( numPro * 100 ) / Max )
	end
--__EX__--
	local screenPos = { guiGetScreenSize (	) }

	myProgressBar = guiCreateProgressBar ( ( screenPos [ 1 ] - 411 ) / 2, ( screenPos [ 2 ] - 391 ) / 2, 411, 25, false )

	guiProgressBarSetMaximum ( myProgressBar , 1 )
	
	guiProgressBarSetProgress ( myProgressBar , 0.5 )
﻿---------------------
	local screenPos = { guiGetScreenSize (	) }

	myProgressBar = guiCreateProgressBar ( ( screenPos [ 1 ] - 411 ) / 2, ( screenPos [ 2 ] - 391 ) / 2, 411, 25, false )

	guiProgressBarSetMaximum ( myProgressBar , 1000 )
	
	guiProgressBarSetProgress ( myProgressBar , 500 )
--____________________________ guiEditSetOnlyNumbers  ____________________________________________________--
function guiEditSetOnlyNumbers ( edit, boolean )
	local function CheckNumbers ( ) 
		local currText = guiGetText( source ) 
		local newText = string.gsub( currText, '[^0-9]', '' ) 
		if newText ~= currText then 
			guiSetText( source, newText ) 
		end 
	end
	if edit and boolean then
		if getElementType ( edit ) == 'gui-edit' and type ( boolean ) == 'boolean' then
			if boolean == true then
					local CheckEventTrue = getEventHandlers( "onClientGUIChanged", edit )
					for i, v in ipairs( CheckEventTrue ) do
						if v == CheckNumbers then
                            removeEventHandler ( "onClientGUIChanged", edit, v )
							break;
                        end
                    end
      				addEventHandler ( "onClientGUIChanged", edit, CheckNumbers )
        			return true;
				else
					local CheckEventFalse = getEventHandlers( "onClientGUIChanged", edit )
					for i, v in ipairs( CheckEventFalse ) do
						if v == CheckNumbers then
							addEventHandler ( "onClientGUIChanged", edit, v )
							break;
						end
					end
					removeEventHandler ( "onClientGUIChanged", edit, CheckNumbers )
        			return true;
			end
    		else
			error ( "ERROR : bad argument ".. getElementType ( edit )  == 'gui-edit' and "2" or "1" .." excepted '".. getElementType ( edit )  == 'gui-edit' and "boolean" or "gui-edit" .."' got ".. getElementType ( edit )  == 'gui-edit' and type ( boolean ) or getElementType ( edit ) )
		return false;
    	end
  		else
		error ( "ERROR : bad argument ".. getElementType ( edit )  == 'gui-edit' and "2" or "1" .." excepted '".. getElementType ( edit )  == 'gui-edit' and "boolean" or "gui-edit" .."' got ".. getElementType ( edit )  == 'gui-edit' and type ( boolean ) or getElementType ( edit ) )
		return false;
  	end
end
--__EX__--
_edit = guiCreateEdit( ... ) 
guiEditSetOnlyNumbers ( _edit, true )
--____________________________ removeEventHandler  ____________________________________________________--

function removeEventHandler ( eventName, attachedTo, functionVar )
	if functionVar then
		return removeEventHandler ( eventName, attachedTo, functionVar )
			else
		if #getEventHandlers ( eventName, attachedTo ) == 1 then
			return removeEventHandler ( eventName, attachedTo, getEventHandlers ( eventName, attachedTo )[1] )
				else
			for index = 1, #getEventHandlers ( eventName, attachedTo ) do
				if index == #getEventHandlers ( eventName, attachedTo ) then
						return removeEventHandler ( eventName, attachedTo, getEventHandlers ( eventName, attachedTo )[index] )
					else
						if removeEventHandler ( eventName, attachedTo, getEventHandlers ( eventName, attachedTo )[index] ) then
							removeEventHandler ( eventName, attachedTo, getEventHandlers ( eventName, attachedTo )[index] )
								else
							return false
						end
				end
			end
		end
	end
end
--__EX__--
addEventHandler ( "onClientGUIClick", button,
	function ( )
		removeEventHandler ( "onClientGUIClick", button )
	end
)
--____________________________ convertNumberToString ____________________________________________________--
function convertNumberToString(num)
	if not num then
		error("ERROR : function convertNumberToString bad argument #1 expected number/string, got bool")
		return false
	end
	num = tostring(num)
	if string.len(num) >= 4 and string.len(num) < 7 then
		num = string.format("%.1f", tonumber(num)/1000).."K"	
	elseif string.len(num) >= 7 and string.len(num) < 10 then
		num = string.format("%.1f", tonumber(num)/10000000).."M"
	elseif string.len(num) >= 10 and string.len(num) < 13 then
		num = string.format("%.1f", tonumber(num)/1000000000).."B"
	elseif string.len(num) >= 13 then
		num = string.format("%.1f", tonumber(num)/1000000000000).."T"
	elseif string.len(num) < 4 then
		num = num
	else
		num = num
	end
	return num
end
--__EX__--
convertNumberToString(100) -- Result : 100
convertNumberToString(1) -- Result : 1
convertNumberToString(1000) -- Result : 1K
convertNumberToString(99999) -- Result : 99.99K
convertNumberToString(1000000000) -- Result : 1B
--____________________________ 123  ____________________________________________________--
function tobool(str)
	if not str and type(str) ~= "string" then
		error("ERROR : function tobool bad argument #1 expected string ( got "..type(str).." )")
		return
	end
	str = str:lower()
	if str == "true" then
		return true
	elseif str == "false" then
		return false
	else
		return nil
	end
end
--__EX__--

--____________________________ 123  ____________________________________________________--
function getTimeFixed(sec)
local hou=sec/3600
local min=(sec%3600)/60
local thesec=(sec%3600)%60
return tostring(split(tostring(hou),'.')[1]..":"..split(tostring(min),'.')[1]..":"..split(tostring(thesec),'.')[1])

end--__EX__--

--____________________________ guiComboBoxAddPlayers  ____________________________________________________--
function guiComboBoxAddPlayers( combo )
	if( getElementType( combo ) == "gui-combobox" ) then	
    	  guiComboBoxClear ( combo )
		  for _, players in ipairs(getElementsByType('player')) do
				guiComboBoxAddItem(combo, getPlayerName(players))
		  end 
      end
end--__EX__--
GUIEditor = {
    combobox = {}
}
local screenW, screenH = guiGetScreenSize()
GUIEditor.combobox[1] = guiCreateComboBox((screenW - 346) / 2, (screenH - 173) / 2, 346, 173, "", false)
guiSetVisible(GUIEditor.combobox[1], false)

bindKey("F3","down",
function()
if ( guiGetVisible(GUIEditor.combobox[1]) == false ) then
guiSetVisible(GUIEditor.combobox[1], true)
showCursor(true)
guiComboBoxAddPlayers( GUIEditor.combobox[1] )
else
guiSetVisible(GUIEditor.combobox[1], false)
showCursor(false)
end
end
)--____________________________ convertToAllScreens  ____________________________________________________--
function convertToAllScreens(x, y, w, h, resolutionX, resolutionY)
	if tonumber(x) and tonumber(y) and tonumber(w) and tonumber(h) and tonumber(resolutionX) and tonumber(resolutionY) then
		local screenW, screenH = guiGetScreenSize()
		local newX, newY, newW, newH = (x/resolutionX)*screenW, (y/resolutionY)*screenH, (w/resolutionX)*screenW, (h/resolutionY)*screenH
		return newX, newY, newW, newH
	end
	return false
end
--__EX__--
addEventHandler("onClientRender", root,
	function()
		local x, y, w, h = convertToAllScreens(383, 186, 515, 31, 1280, 800)
		dxDrawRectangle(x, y, w, h, tocolor(255, 255, 255, 125), false)
	end
)
--____________________________ fixGUISizeAndPosition  ____________________________________________________--
function fixGUISizeAndPosition(gui,screenx,screeny,relative )
  local relative =relative  or false
  local x,y=guiGetPosition(gui,relative)
  local w,h=guiGetSize(gui,relative)
  local scx,scy=guiGetScreenSize()
  local sx,sy=(scx/screenx),(scy/screeny)
  if guiSetPosition(gui,sx*x,sy*y,relative) and guiSetSize(gui,sx*w,sy*h,relative) then return true end
  return false
end
--__EX__--
local gui=guiCreateWindow(0,0,0,0,'tttt',false)
fixGUISizeAndPosition(gui,1366,768,false)
-------
fixGUISizeAndPosition(gui,1366,768)
--____________________________ 123  ____________________________________________________--


function getWeaponSlot(id)
local wp={
[0]={0,1},
[1]={2,3,4,5,6,7,8,9},
[2]={22,23,24},
[3]={25,26,27},
[4]={28,29,32},
[5]={30,31},
[6]={33,34},
[7]={35,36,37,38},
[8]={16,17,18,39},
[9]={41,42,43},
[10]={10,11,12,13,14,15},
[11]={44,45,46},
[12]={40}
}
for k,v in pairs(wp)do
	for s,l in ipairs(wp[k])do
		if tonumber(l)==tonumber(id) then
			return k
		end
	end
end
return false
end

function getPedWeapons(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=0,12 do
			local wep = getPedWeapon(ped,i)
			local ammo = getPedTotalAmmo ( ped, i ) 
			if wep and wep ~= 0 then
				table.insert(playerWeapons,{wep,ammo})
			end
		end
	else
		return false
	end
	return playerWeapons
end
--__EX__--

--____________________________ guiLabelAddEffect  ____________________________________________________--
function guiLabelAddEffect(label, effect)
	local nlab = {}
	local checkTimer = {}
	if label and getElementType(label) == "gui-label" then
		if effect and tostring(effect) and effect:len() > 3 then
			local position = { guiGetPosition(label, false) }
			local size = { guiGetSize(label, false) }
			if effect:lower() == "shadow" then
				nlab[1] = guiCreateLabel(position[1] + 1, position[2] + 1, size[1] + 1, size[2] + 1, guiGetText(label), false, getElementParent(label) and getElementParent(label) or nil)
				guiLabelSetColor(nlab[1], 0, 0, 0)
			elseif effect:lower() == "outline" then
				for i = 1, 4 do
					x, y, w, h = (i == 1 or i == 2 and 1 or -1), (i == 1 or i == 3 and 1 or -1), (i == 1 or i == 2 and 1 or -1), (i == 1 or i == 3 and 1 or -1)
					nlab[i] = guiCreateLabel(position[1] + x, position[2] + y, size[1] + w, size[2] + h, guiGetText(label), false, getElementParent(label) and getElementParent(label) or nil)
					guiLabelSetColor(nlab[i], 0, 0, 0)
				end
			end
		end
	end
	if #nlab > 0 then
		if label then
			if isTimer(checkTimer[label]) then killTimer(checkTimer[label]) end
			checkTimer[label] = setTimer(function()
				for _,nlabel in ipairs(nlab) do
					guiSetVisible(nlabel, guiGetVisible(label))
				end
				if not isElement(label) then
					killTimer(checkTimer[label])
					for i = 1, #nlab do
						destroyElement(nlab[i])
					end
				end
			end, 100, 0)
		end
		if #nlab == 1 then
			return nlab[1]
		elseif #nlab == 4 then
			return nlab[1], nlab[2], nlab[3], nlab[4]
		end
	else
		return false
	end
end
--__EX__--
addEventHandler("onClientResourceStart", resourceRoot,
    function()
      myLabel = guiCreateLabel(350, 100, 50, 50, "Hello World", false)
    end 
)

addCommandHandler("effect", 
    function()
      if myLabel then
         guiLabelAddEffect(myLabel, "shadow")
      end
    end 

--____________________________ dxDrawLiendText  ____________________________________________________--
function dxDrawLiendText(text, x, y, width, height, color, widthofline,colorofline,textcolor,textsize, postGUI )
local finalx=x+width
  local textcolor=textcolor or tocolor(255,255,255,255)
  local textsize=textsize or 1.3
  local colorofline=colorofline or tocolor(255,255,255,255)
  local finaly=y+height
  local widthofline=widthofline or 2
  dxDrawLine ( x, y, finalx, y, colorofline, widthofline, postGUI ) -- Top
	dxDrawLine ( x, y, x,finaly, colorofline, widthofline, postGUI ) -- Left
	dxDrawLine ( finalx, y, finalx,finaly, colorofline, widthofline, postGUI ) -- Right
	dxDrawLine ( x, finaly, finalx, finaly, colorofline, widthofline, postGUI ) -- Bottom
return dxDrawText(text,x,y,finalx,finaly,textcolor,textsize,"default",'left','top',true,false,postGUI)
end
--__EX__--

--____________________________ dxDrawLiendAndBackgroundText  ____________________________________________________--
function dxDrawLiendAndBackgroundText(text, x, y, width, height, color, widthofline,colorofbackground,colorofline,textcolor,textsize, postGUI )
local finalx=x+width
  local textcolor=textcolor or tocolor(255,255,255,255)
  local colorofbackground=colorofbackground or tocolor(0,0,0,150)
  local textsize=textsize or 1.3
  local colorofline=colorofline or tocolor(255,255,255,255)
  local finaly=y+height
  local widthofline=widthofline or 2
  dxDrawRectangle ( x, y, width,height, colorofbackground,postGUI) ---Background
  dxDrawLine ( x, y, finalx, y, colorofline, widthofline, postGUI ) -- Top
	dxDrawLine ( x, y, x,finaly, colorofline, widthofline, postGUI ) -- Left
	dxDrawLine ( finalx, y, finalx,finaly, colorofline, widthofline, postGUI ) -- Right
	dxDrawLine ( x, finaly, finalx, finaly, colorofline, widthofline, postGUI ) -- Bottom
return dxDrawText(text,x,y,finalx,finaly,textcolor,textsize,"default",'left','top',true,false,postGUI)
end
--__EX__--
--____________________________ guiMoveElement  ____________________________________________________--
local table_ = {} 
function guiMoveElement ( element, speed, x, y, type_ )
	local type_ = type_ or "Linear"
	if isElement ( element ) and tonumber ( speed ) and tonumber ( x ) and tonumber ( y ) and tostring ( type_ ) then
		if isElement ( getElementData ( element, "object" ) ) then
			local object = getElementData ( element, "object" )
			moveObject ( object, speed, x, y, -999, 0, 0, 0, type_ )
			local destroy = function ( old_object, old_gui )
				if isElement ( old_object ) then
					destroyElement ( old_object )
				end
				for i, gui_elements in ipairs ( table_ ) do
					if gui_elements[1] == old_gui then
						table.remove ( table_, i )
					end
				end
			end
			setTimer ( destroy, speed, 1, object, gui_element )
		else
			local p = { guiGetPosition ( element, false ) }
			local object = createObject ( 902, p[1], p[2], -999 )
			setElementData ( element, "object", object )
			setElementAlpha ( object, 0 )
			table.insert ( table_, (#table_)+1, { element, object } )
			guiMoveElement ( element, speed, x, y, type_ )
		end
	end
end
function r ()
	for i, gui_element in ipairs ( table_ ) do
		if isElement (gui_element[1]) and isElement (gui_element[2]) then
			local x, y = getElementPosition ( gui_element[2] )
			guiSetPosition ( gui_element[1], x, y, false )
		end
	end
end
addEventHandler ( "onClientRender", root, r )
--__EX__--
--____________________________ freezeTime  ____________________________________________________--
--@Server Side
function freezeTime(player,value,hour,min)
  if ( value == false ) then
    if ( getElementData(player,"WeatherTimer") == true ) then
      setElementData(player,"WeatherTimer") == false ) then
      end
    elseif ( value == true ) then
    setElementData(player,"WeatherTimer",true)
    local theWeather = setTimer(function(player,hour,min)
        triggerClientEvent(player,"SetTheTime",player,hour,min)
        end,1000,0)
    end
  end

--@Client Side
addEvent("SetTheTime",true);
addEventHandler("SetTheTime",root,function (hour,min)
    if ( getElementData(localPlayer,"WeatherTimer") == true ) then
    if ( tonumber(hour) ) then
    if ( tonumber(min) ) then
    setTime (hour,min)
        else
        outputDebugString ( "Useful function(freezeTime): argument 4 may be a number." )
        end
      else
      outputDebugString ( "Useful function(freezeTime): argument 3 may be a number." )
      end
   end
end
  )
--__EX__--
--____________________________ 123  ____________________________________________________--

local rValue = {};

function table.random(t, nP, stopIF, stopIFmsg)
assert(type(t)=='table', ' [table.random] table expected got '..type(t))
assert(type(nP)=='boolean', ' [table.random] boolean expected got '..type(nP))
    if not nP then
        return t[math.random(#t)]
    end
    local stopIF = (stopIF and type(stopIF) == 'number' and (stopIF <= 10 and stopIF >= 1)) and stopIF or 5
    local stopIFmsg = (stopIFmsg and (type(stopIFmsg) == 'string' and stopIFmsg) or '* [table.random], Error : timeout')
    local randomValue = math.random(#t)
        if randomValue ~= rValue[t] then
        rValue[t] = randomValue
        return t[randomValue]
    else
        local newRandomValue
        local randomValue1 = math.random(#t)
        local kCount = 0
            repeat
                kCount = kCount +1
                    if (kCount or 0) >= stopIF then
                    local rV = math.random(#t)
                    newRandomValue = t[rV]
                    rValue[t] = rV
                    error(stopIFmsg or 'ERROR')
                break
            end
                if randomValue ~= randomValue1 then
                    newRandomValue = t[randomValue1]
                    rValue[t] = randomValue1
                else
                    randomValue1 = math.random(#t)
                end
            until randomValue ~= randomValue1
        return newRandomValue or t[math.random(#t)]
    end
end
--__EX__--
local vv = {'hi1', 'wehw', 'wow', 'mm'};

addCommandHandler('noSP', function()
print(table.random(vv, false))
end)


addCommandHandler('SP', function()
print(table.random(vv, true))
end)
﻿
--____________________________ guiGridListAddWeapons  ____________________________________________________--
function guiGridListAddWeapons(gridlist, column)
	if( getElementType( gridlist ) == "gui-gridlist" ) then
	guiGridListClear(gridlist)
	for i=1,40 do	
	local row = guiGridListAddRow(gridlist)
	guiGridListSetItemText(gridlist, row, column, getWeaponNameFromID(i), false, true)
	end
  end 
end
--__EX__--
local screenW, screenH = guiGetScreenSize()
gridweapon = guiCreateGridList((screenW - 221) / 2, (screenH - 309) / 2, 221, 309, false)
guiGridListAddColumn(gridweapon, "#", 0.9)
guiSetVisible(gridweapon, false)

function guiGridListAddWeapons(gridlist, column)
	if( getElementType( gridlist ) == "gui-gridlist" ) then
	guiGridListClear(gridlist)
	for i=1,40 do	
	local row = guiGridListAddRow(gridlist)
	guiGridListSetItemText(gridlist, row, column, getWeaponNameFromID(i), false, true)
	end
  end 
end

bindKey("F2","down",
function( )
	if ( guiGetVisible(gridweapon) == false ) then
	guiSetVisible(gridweapon, true)
	showCursor(true)
	guiGridListAddWeapons(gridweapon, 1)
	else
	guiSetVisible(gridweapon, false)
	showCursor(false)
	end
end)

--____________________________ guiFadeElement  ____________________________________________________--
function guiFadeElement ( element, boolean, time, inOut )
	if isElement ( element ) ~= true or type ( boolean ) ~= "boolean" then return false end
	guiSetEnabled ( element, boolean )
	if type ( fadeTable ) ~= "table" then fadeTable = {} end
	if getElementData ( element, "real.alpha" ) == false then setElementData ( element, "real.alpha", ( ( guiGetAlpha ( element ) / 1 ) * 255 ) ) end
	if guiGetVisible ( element ) == false then guiSetAlpha ( element, 0 ) end
	local remove = function ( element ) if isTimer ( getElementData ( element, "gui.timer" ) ) then killTimer ( getElementData ( element, "gui.timer" ) ) end end
	remove ( element )
	local execute = function ( element, boolean, inOut )
		if boolean == false then
			guiSetAlpha ( element, ( ( ( guiGetAlpha ( element ) / 1 ) * 255 ) - ( inOut or 25 ) ) / 255 )
			if ( ( guiGetAlpha ( element ) / 1 ) * 255 ) <= 5 then
				remove ( element )
				guiSetAlpha ( element, 0 )
				guiSetVisible ( element, boolean )
			end
		elseif boolean == true then
			guiSetVisible ( element, boolean )
			guiSetAlpha ( element, ( ( ( guiGetAlpha ( element ) / 1 ) * 255 ) + ( inOut or 25 ) ) / 255 )
			if ( ( guiGetAlpha ( element ) / 1 ) * 255 ) >= tonumber ( getElementData ( element, "real.alpha" ) ) then
				remove ( element )
				guiSetAlpha ( element, getElementData ( element, "real.alpha" ) / 255 )
			end
		end
	end
	guiTimer = setTimer ( execute, ( time or 50 ), 0, element, boolean, inOut )
	setElementData ( element, "gui.timer", guiTimer )
end
--__EX__--

button = guiCreateButton(50, 50, 150, 50, "killerProject", false)

function test ()
	guiFadeElement ( button, not guiGetVisible ( b ) )
end
setTimer ( test, 1*1000, 0 )
--____________________________ guiGridListRemoveRowByText  ____________________________________________________--
function guiGridListRemoveRowByText(gridlist, text)
	if gridlist and type(gridlist) == "gui-gridlist" then
		if text and type(text) == "string" then
			if guiGridListGetRowCount(gridlist) > 0 and guiGridListGetColumnCount(gridlist) > 0 then
				for ir = 0, guiGridListGetRowCount(gridlist)-1 do
					for ic = 1, guiGridListGetColumnCount(gridlist) do
						if guiGridListGetItemText(gridlist, ir, ic) == text then
							return guiGridListRemoveRow(gridlist, ir)
						end
					end
				end
			end
		end
	end
	return false
end
--__EX__--


--____________________________ DownloadFile  ____________________________________________________--
	function DownloadFile ( Link , FileName )
	
	assert ( type ( Link ) == "string" , "Bad Argument At Argument #1 Link Moust String" )	
	
	assert ( type ( FileName ) == "string" , "Bad Argument At Argument #1 FileName Moust String" )	

	fetchRemote( Link ,
	
	function ( Result )

	if Result == "ERROR" then
	
	error ( "Can't Calling The Link" )
		return false
	end

	if fileExists ( FileName ) then 
	
	error ( "the file is already exists" )
		return false
	end
	
	local theFile = fileCreate ( FileName )
	
	if ( not theFile ) then
	
		return false
	end
	
	fileWrite ( theFile , Result ) 
	
	fileClose ( theFile )
	
	return true
	
		end
		)   	
	end
--__EX__--
DownloadFile ( "https://i.imgur.com/gdclMbe.png" , "mtaLogo.png" )	
﻿
DownloadFile ( "https://i.imgur.com/gdclMbe.png" , ":resourceName/mtaLogo.png" )	

--____________________________ multiLineForText  ____________________________________________________--
function multiLineForText(txt,maxForEachLine)
	if not( type(txt) == 'string' and type(maxForEachLine) == 'number' ) then
		return false
	end
	array = {}
	_txt = ''
	_count = 1
	if ( #txt >= maxForEachLine ) then
		for i=1,#txt do
			_txt = _txt..''..string.sub(txt,i,i)
			if ( i == maxForEachLine ) then
				array[#array+1] = _txt
				_txt = ''
				_count = _count+1
			elseif ( i == maxForEachLine*_count ) then
				array[#array+1] = _txt
				_txt = ''
				_count = _count+1
			else
				if ( i == #txt and _txt ~= '' ) then
				array[#array+1] = _txt
				end
			end
		end
	else
		array[#array+1] = txt
	end
	return array
end
--__EX__--

x = 'hihihihihihihihihihihiheyheyheyheyheyheyheyheyheyheyheyheyheyheyhey'
for i,v in ipairs(multiLineForText(x,4)) do
  outputChatBox(v) -- راح يطلع فكل رساله 4 حروف
  -- مثلا اول رساله بتكون hihi
end
--____________________________ StrMultiLine  ____________________________________________________--
	function StrMultiLine ( theStr , theNum )
	
	local FunCheck = ( assert ( type ( theStr ) == "string" , "error StrMultiLine arg 1 got " .. type ( theStr ) ) and assert ( type ( theNum ) == "number" , "error StrMultiLine arg 2 got " .. type ( theStr ) ) and theNum > #theStr and error ( "error StrMultiLine arg 2 num larger than string" ) ) 
	
		return split ( theStr : gsub ( ( "." ) : rep ( theNum ) , "%1ㅀ" ) : sub ( 1 , -1 ) , "ㅀ" )
	end
--__EX__--

print ( table.concat ( StrMultiLine ( "HiHeIsOr" , 2 ) ) )
--____________________________ getElementsOnPlayerScreen   ____________________________________________________--
function getElementsOnPlayerScreen(element)
	local elementTypes = {['player']=true, ['ped']=true, ['vehicle']=true, ['object']=true, ['pickup']=true};
	local element = ((type(element) == 'table' and element) or (element == 'all' and element))
	if element then
		if type(element) == 'string' then
			element = {}
			for value in pairs(elementTypes) do
				element[#element+1] = value;
			end
		else
			local elementsTable = {};
			for index = 1, #element do
				if elementTypes[element[index]] then
					elementsTable[#elementsTable+1] = element[index]
				end
			end
			element = elementsTable;
		end
		local elementsTable = {};
		local elements = {};
		for index = 1, #element do
			local element = getElementsByType(element[index])
			for key = 1, #element do
				elements[#elements+1] = element[key];
			end
		end
		for element = 1, #elements do
			if isElementOnScreen(elements[element]) and elements[element] ~= localPlayer then
				elementsTable[#elementsTable+1] = elements[element]
			end
		end
		return elementsTable
	end
end
--__EX__--

--#Client Side

addCommandHandler('warpVehicle', function()
	local vehicle = getNearestElementOnPlayerScreen(localPlayer, 'vehicle');
	if vehicle then
		triggerServerEvent('givePlayerVehicle.', localPlayer, vehicle)
	else
		outputChatBox('There\'s no vehicle on you screen', 255, 0, 0, true)
	end
end)

--#Server Side
addEvent('givePlayerVehicle.', true)
addEventHandler('givePlayerVehicle.', root, function(vehicle)
	if not isPedInVehicle(client) then
		warpPedIntoVehicle(client, vehicle)
	end
end)
--____________________________ getNearestElementOnPlayerScreen  ____________________________________________________--

function getNearestElementOnPlayerScreen(player, elementType)
	local player = (isElement(player) and getElementType(player) == 'player') and player
	local elementType = type(elementType) == 'string' and (elementType == 'all' and elementType or {elementType})
	if player and elementType then
		local element = getElementsOnPlayerScreen(elementType);
		local nearest
		local playerX, playerY, playerZ = getElementPosition(player)
		for index = 1, #element do
			if isElement(nearest) then
				local oldDistance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, getElementPosition(nearest))
				local newDistance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, getElementPosition(element[index]));
				if newDistance < oldDistance then
					nearest = element[index];
				end
			else
				nearest = element[index];
			end
		end
		return nearest
	end
end
--__EX__--


--____________________________ setTableToSql  ____________________________________________________--
executeSQLQuery ('CREATE TABLE IF NOT EXISTS Table_System (ID, myTable)')

function setTableToSql( id, theTable )
    local Results = executeSQLQuery("SELECT myTable FROM `Table_System` WHERE ID=?", id ) 
     if ( type ( Results ) == "table" and #Results == 0 or not Results ) then 
		executeSQLQuery ( "INSERT INTO `Table_System` ( ID, myTable ) VALUES(?, ?)",id , toJSON ( theTable ) )
    else 
        executeSQLQuery('UPDATE `Table_System` SET myTable =? WHERE ID =?',toJSON ( theTable ),id ) 
    end  
end
--__EX__--
Table = {
  {"I'm"},
  {"The"},
  {"King"},
 }
  addEventHandler( "onResourceStop",resourceRoot,
function()
setTableToSql( 1, Table)
end )

--____________________________ getTableFromSql  ____________________________________________________--
	function getTableFromSql ( id )
	  
	local aRow = executeSQLQuery( "SELECT myTable FROM `Table_System` WHERE ID=?",id )

	if ( type ( aRow ) == "table" and #aRow == 0 ) or not aRow then return {""} end	
	
		return fromJSON ( aRow [1] [ "myTable" ] )
	end
--__EX__--
TableT = {}

addEventHandler( "onResourceStart",resourceRoot,
function()
local table = getTableFromSql( 1 )
	if table then
		TableT = table
	end
end )

--____________________________ getPlayersInVehicles  ____________________________________________________--
function getPlayersInVehicles ( dimension )
	local players = { }
	if ( dimension ) then
		local dimension = tonumber ( dimension )
		if ( type ( dimension ) == "number" ) then
			for _, v in ipairs ( getElementsByType ( "player" ) ) do
				if ( getPedOccupiedVehicle ( v ) and getElementDimension ( v ) == dimension ) then
					table.insert ( players, v )
				end
			end
		else
			outputDebugString ( "Bad argument @ 'getPlayersInVehicles' [Expected number at argument 1, got " .. type ( dimension ) .. "]", 2 )
			return false
		end
	else
		outputDebugString ( "Bad argument @ 'getPlayersInVehicles' [Expected number at argument 1, got " .. type ( dimension ) .. "]", 2 )
		return false
	end
	return players
end	
--__EX__--
addCommandHandler ( "playersCount",
	function ( player, cmd, dim )
		local players = getPlayersInVehicles ( dim )
		outputChatBox(#players, player)
	end
)
--____________________________ 123  ____________________________________________________--
function isVehicleFire ( vehicle )
if ( vehicle and isElement ( vehicle ) and getElementType ( vehicle ) == "vehicle" ) then 
return ( math.floor ( getElementHealth ( vehicle ) ) <= 249 and true or false )
end
end
--__EX__--

addCommandHandler ( "checkCar" , function (  ) 
if ( getPedOccupiedVehicle ( localPlayer ) ) then 
outputChatBox("Vehicle Fire State : "..( isVehicleFire ( getPedOccupiedVehicle ( localPlayer ) ) and "Yes" or "No" ))
end
end ) 
--____________________________ guiGridListSetRowEnabled  ____________________________________________________--
function guiGridListSetRowEnabled(gridlist, row, column, bool)
	if not gridlist or getElementType(gridlist) ~= "gui-gridlist" or not tonumber(row) or not tonumber(column) then
		error(not gridlist and "error guiGridListSetRowEnabled expected element at argument #1 got ("..(type(gridlist) or getElementType(gridlist))..")" or not tonumber(row) and "error guiGridListSetRowEnabled expected row number at arg #1 got ("..type(row)..")" or not tonumber(column) and "error guiGridListSetRowEnabled expected column number at arg #1 got ("..type(column)..")")
		return false
	else
		local rowData = {guiGridListGetItemText(gridlist, row, column), guiGridListGetItemData(gridlist, row, column), {guiGridListGetItemColor(gridlist, row, column)}}
		guiGridListRemoveRow(gridlist, row)
		newRow = guiGridListInsertRowAfter(gridlist, row-1)
		guiGridListSetItemText(gridlist, newRow, column, not bool and "   "..rowData[1] or rowData, not bool, false)
		guiGridListSetItemColor(gridlist, newRow, column, rowData[3][1], rowData[3][2], rowData[3][3])
		guiGridListSetItemData(gridlist, newRow, column, rowData[2])
		return newRow
	end
end
--__EX__--


--____________________________ createObjectAttachedTo 	  ____________________________________________________--
	local elements = { [ "player" ] = true , [ "ped" ] = true , [ "vehicle" ] = true , [ "object" ] = true , [ "weapon" ] = true , [ "blip" ] = true , [ "effect" ] = true , [ "light" ] = true , [ "camera" ] = true , [ "pickup" ] = true , [ "searchlight" ] = true }

    function createObjectAttachedTo ( elementToAttachTo , objID , offx , offy , offz )
	
	local Check = not ( elementToAttachTo and isElement ( elementToAttachTo ) and elements [ getElementType ( elementToAttachTo ) ] ) and error ( "createObjectAttachedTo Bad Argument 1 got ".. ( not elementToAttachTo and "nil" or getElementType ( elementToAttachTo ) or "nil" ) ) or type ( objID ) ~= "number" and error ( "createObjectAttachedTo Bad Argument 2 got " .. type ( objID ) )
	
	local obj = createObject ( objID , getElementPosition ( elementToAttachTo ) )
	
	attachElements ( obj , elementToAttachTo , offx , offy , offz )
		return obj
	end
--__EX__--
--client : 
﻿

createObjectAttachedTo ( localPlayer , 1482 , offx , offy , offz )

--server :

createObjectAttachedTo ( getRandomPlayer ( ) , 1482 , offx , offy , offz )

--____________________________ getSmoothRGBColor   ____________________________________________________--
local colorChangeSpeed = 2;

addEventHandler('onClientResourceStart', resourceRoot, function()
    colorChangeSpeed = math.max(math.min(colorChangeSpeed, 2), .5)
    randomR, randomG, randomB = 0, 0, 0;
    levelNumber = math.random(3)
    startTick = getTickCount();
    addEventHandler('onClientRender', root, updateRGB)
end)

function updateRGB()
    local currentTick = getTickCount();
    local fadeIn, fadeOut = interpolateBetween(0, 255, 0, 255, 0, 0, (currentTick-startTick)/(colorChangeSpeed*1000), 'Linear')
    if levelNumber == 1 then
        randomR, randomG, randomB = fadeOut, fadeIn, 0
    elseif levelNumber == 2 then
        randomR, randomG, randomB = 0, fadeOut, fadeIn
    elseif levelNumber == 3 then
        randomR, randomG, randomB = fadeIn, 0, fadeOut
    end
    if currentTick > (startTick+(colorChangeSpeed*1000)) then
        levelNumber = math.max((levelNumber+1)%4, 1)
        startTick = getTickCount();
    end
end

function getSmoothRGBColor()
    return randomR, randomG, randomB;
end
--__EX__--

local sx, sy = guiGetScreenSize()

addEventHandler('onClientRender', root, function()
    dxDrawText(getPlayerName(localPlayer), 0, 0, sx, sy, tocolor(getSmoothRGBColor()), 2, 'default-bold', 'center', 'top')
end)
--____________________________ setSerialData   ____________________________________________________--
function setSerialData ( serial, key, value )
	if ( serial and key and value ) then
		local database = executeSQLQuery ( "CREATE TABLE IF NOT EXISTS `" .. serial .. "` ( key TEXT, value TEXT )" )
		local data = executeSQLQuery ( "SELECT value FROM `" .. serial .. "` WHERE key=?", tostring ( key ) )
		local result = false
		if ( #data == 1 ) then
			if ( data[1].value ~= value ) then
				executeSQLQuery ( "UPDATE `" .. serial .. "` SET value=? WHERE key=?", tostring ( value ), tostring ( key ) )
				result = true
			end
		else
			executeSQLQuery ( "INSERT INTO `" .. serial .. "` ( key, value ) VALUES ( ?, ? )", tostring ( key ), tostring ( value ) )
			result = true
		end
		return result
	end
endTime
--__EX__--


--____________________________ getSerialData  ____________________________________________________--
function getSerialData ( serial, key )
	if ( serial and key ) then
		local database = executeSQLQuery ( "CREATE TABLE IF NOT EXISTS `" .. serial .. "` ( key TEXT, value TEXT )" )
		local data = executeSQLQuery ( "SELECT value FROM `" .. serial .. "` WHERE key=?", tostring ( key ) )
		local result = false
		if ( #data == 1 ) then
			result = data[1].value
		end
		return result
	end
end
--__EX__--


--____________________________ removeSerialData	  ____________________________________________________--
function removeSerialData ( serial, key )
	if ( serial and key ) then
		local database = executeSQLQuery ( "CREATE TABLE IF NOT EXISTS `" .. serial .. "` ( key TEXT, value TEXT )" )
		local data = executeSQLQuery ( "SELECT value FROM `" .. serial .. "` WHERE key=?", tostring ( key ) )
		local result = false
		if ( #data == 1 ) then
			executeSQLQuery("DELETE FROM `" .. serial .. "` WHERE key=?", tostring ( key ) )
			result = true
		end
		return result
	end
end
--__EX__--


--____________________________ moveElement   ____________________________________________________--
	local elements = { [ "player" ] = true , [ "ped" ] = true , [ "vehicle" ] = true , [ "object" ] = true , [ "weapon" ] = true , [ "blip" ] = true , [ "effect" ] = true , [ "light" ] = true , [ "camera" ] = true , [ "pickup" ] = true , [ "searchlight" ] = true }
	
	function moveElement ( theElement , theTime , tx , ty , tz , moverx, movery, moverz, strEasingType, fEasingPeriod, fEasingAmplitude, fEasingOvershoot )

	local Check = not ( theElement and isElement ( theElement ) and elements [ getElementType ( theElement ) ] ) and error ( "moveElement Bad Argument 1 got ".. ( not theElement and "nil" or getElementType ( theElement ) or "nil" ) ) 
	
	local objMove = createObject ( 1906 , getElementPosition ( theElement ) )
	
	setElementAlpha ( objMove , 0 )
	
	attachElements ( theElement , objMove )
	
	moveObject ( objMove , theTime , tx , ty , tz , moverx, movery, moverz, strEasingType, fEasingPeriod, fEasingAmplitude, fEasingOvershoot )

	setTimer ( function (	) 

	if theElement and isElement ( theElement ) then
	
	detachElements ( theElement , objMove )
	
	end
	
	destroyElement ( objMove )
	
		end , theTime , 1 )
		return true
	end
--__EX__--
-- server

	addCommandHandler ( "BringVehicleAtMe" , 

	﻿function ( player )

	local randVeh = #getElementsByType ( "vehicle" ) > 0 and getElementsByType ( "vehicle" ) [ math.random ( 1 , #getElementsByType ( "vehicle" ) ) ] or false
	
	if not randVeh then return end
	
	moveElement ( randVeh , 500 , getElementPosition ( player ) )
	
	end
	)

--____________________________ removeSpecialCharacters   ____________________________________________________--
function removeSpecialCharacters(str)
    return type(str) == 'string' and ({str:gsub('[%(%)%.%%%+%-%*%?%[%^%$]', '%%%1')})[1] or false
end
--__EX__--
print(removeSpecialCharacters('Is it 20$ ?')) -- Is it 20%$ %?
﻿

--____________________________ sortGridlist  ____________________________________________________--
local Alphabet = {["a"] = 1, ["b"] = 2, ["c"] = 3, ["d"] = 4, ["e"] = 5, ["f"] = 6, ["g"] = 7, ["h"] = 8, ["i"] = 9, ["j"] = 10, ["k"] = 11, ["l"] = 12, ["m"] = 13, ["n"] = 14, ["o"] = 15, ["p"] = 16, ["q"] = 17, ["r"] = 18, ["s"] = 19, ["t"] = 20, ["u"] = 21, ["v"] = 22, ["w"] = 23, ["x"] = 24, ["y"] = 25, ["z"] = 26}
function sortGridlist(grid, stype)
    if grid and isElement(grid) and getElementType(grid) == "gui-gridlist" and type(stype) == "table" then
		local data = {}
        if #stype > 0 then
			local filter, from, column = stype[1] or "both", stype[2] or "text", stype[3] or 1
			local func = from == "data" and guiGridListGetItemData or guiGridListGetItemText
			local startIndex, row, cCount = 0, nil, guiGridListGetColumnCount(grid)
			for i = 0, guiGridListGetRowCount(grid)-1 do
				for j = 1, cCount do
					table.insert(data, {func(grid, i, column), guiGridListGetItemText(grid, i, j), guiGridListGetItemData(grid, i, j), {guiGridListGetItemColor(grid, i, j)}})
				end				
			end
			guiGridListClear(grid)
			if filter == "number" then
				table.sort(data, 
					function(a, b)
						return tonumber(a[1]) > tonumber(b[1])
					end
				)
			elseif filter == "string" then
				table.sort(data,
					function(a, b)
						local a, b = a[1]:sub(1, 1):lower(), b[1]:sub(1, 1):lower()
						return Alphabet[b] > Alphabet[a]
					end
				)
			elseif filter == "both" then
				table.sort(data, 
					function(a, b)
						if tonumber(a[1]) and tonumber(b[1]) then
							return tonumber(a[1]) > tonumber(b[1])
						elseif tonumber(a[1]) and not tonumber(b[1]) then
							return tonumber(a[1]) > tonumber(Alphabet[b[1]:sub(1, 1):lower()])
						elseif not tonumber(a[1]) and tonumber(b[1]) then
							return tonumber(Alphabet[a[1]:sub(1, 1):lower()]) > tonumber(b[1])
						else
							return Alphabet[b[1]:sub(1, 1):lower()] > Alphabet[a[1]:sub(1, 1):lower()]
						end
					end
				)
			end
			for _,value in ipairs(data) do
				startIndex = startIndex + 1
				if startIndex == 1 then
					row = guiGridListAddRow(grid)
				elseif startIndex >= cCount then
					startIndex = 1
					row = guiGridListAddRow(grid)
				end
				for i = 1, cCount do
					guiGridListSetItemText(grid, row, i, value[2], false, false)
					guiGridListSetItemData(grid, row, i, value[3])
					guiGridListSetItemColor(grid, row, i, value[4][1], value[4][2], value[4][3], value[4][4] or 255)
				end
			end
		end
	end
end
--__EX__--


--____________________________ 123  ____________________________________________________--
function getMaxStringForWidth(text,width,isinvers,scale,font)

	local scale=scale or 1.15
	
	local font=font or 'default-bold'
	
	local isinvers= isinvers or false
	
	local mystring=''
	
	local inverstable={}
	
	local num=0
		
	if text~=nil then
			
		local txtwidth=dxGetTextWidth( text,scale,font)
			
			if width>=txtwidth then
			
				return text,text
			
			end
						
		for v in text:gmatch('.') do
		

				if not isinvers then

				mystring=mystring..v
				
					local finalWidth=dxGetTextWidth( mystring,scale,font)
					
						if finalWidth>=width then
							
							mystring=mystring:gsub("[%z\1-\127\194-\244][\128-\191]*$", "")
							
							return mystring,text
							
						end
				
				else
				
					table.insert(inverstable,v)
				
				end
		end
		
				if isinvers then
 
					num=#inverstable
					
					while(num>=1) do
					
						mystring=inverstable[num]..mystring
						
						local finalWidth=dxGetTextWidth( mystring,scale,font)
					
						if finalWidth>=width then
														
							return mystring,text
							
						end
						
						num=num-1
					
					end
					
			return mystring,text
				
				
			
		end
		
	end
	
	return false,text
end
--__EX__--

print(getMaxStringForWidth('Hello Worled am fine',100,true))
--____________________________ getTextNumbersOfLines  ____________________________________________________--
function getTextNumbersOfLines(text,borderwidth,scale,font)
	
	local scale=scale or 1
	local font=font or 'default'

	if dxGetTextWidth(text,scale,font)>borderwidth then---if it's in new line then
		local mytext=''
		local numoflines=1
		for c in string.gmatch(text,"%w+") do

			mytext=mytext..' '..c
			local currentwidth=dxGetTextWidth(mytext,scale,font)
			
			if currentwidth>borderwidth then
			
				numoflines=numoflines+1
				mytext=c
		
			end
		end

		return numoflines
	
	
	end
	
return 1---else
end
--__EX__--
addEventHandler('onClientRender',root,function()

dxDrawText ( 'hello world this is just test text to check word warp calculate function ', 200,200, 300, 400, tocolor(255,255,255,255),1, "default", "left", "top", true,true, false)

end)

addCommandHandler('testheight',function()

print(getTextNumbersOfLines('hello world this is just test text to check word warp calculate function ',200,100,1,'default'))
print(dxGetFontHeight(1,'default'))

end)

--____________________________ dxDrawRoundedRectangle  ____________________________________________________--


function dxDrawRoundedRectangle(x,y,width,height,raduis,color,postgui)

dxDrawRectangle(x,y+raduis,width+1,height-(raduis*2),color,postgui)--horezantal rectangle
dxDrawRectangle(x+raduis,y,width-(raduis*2),height+1,color,postgui)--vertical rectangle

for k=180,270 do--left top
	local co=math.cos(math.rad(k))* raduis
	local si=math.sin(math.rad(k))* raduis
	dxDrawLine((x+raduis)+co,(y+raduis)+si,x+raduis,y+raduis,color,1,postgui)
end
for k=270,360 do--right top
	local co=math.cos(math.rad(k))* raduis
	local si=math.sin(math.rad(k))* raduis
	dxDrawLine((x+width-raduis)+co,(y+raduis)+si,x+width-raduis,y+raduis,color,1,postgui)
end

for k=90,180 do--left bottom
	local co=math.cos(math.rad(k))* raduis
	local si=math.sin(math.rad(k))* raduis
	dxDrawLine((x+raduis)+co,(y+height-raduis)+si,x+raduis,y+height-raduis,color,1,postgui)
end
local k=360
while(k<=(360+90))do
if k~= 360 then
	local co=math.cos(math.rad(k))* raduis
	local si=math.sin(math.rad(k))* raduis
	dxDrawLine((x-raduis+width)+co,(y+height-raduis)+si,x+width-raduis,y+height-raduis,color,1,postgui)
	
end
	k=k+1;
end

end
--__EX__--


--____________________________ CreateAttentionBox  ____________________________________________________--
CreateAttentionBox = function ( Window , Text , RedLabel , GreenLabel , BlueLabel , AlphaLabel , PropertyBox , AlphaBox , TimerSecond )
	assert ( Window , 'Bug @ #1 CreateAttentionBox ; No Window' )
	assert ( isElement ( Window ) , 'Bug @ #1 CreateAttentionBox ; This is not Element' )
	assert ( getElementType ( Window ) == 'gui-window' , 'Bug @ #1 CreateAttentionBox ; This is not gui window' )
	assert ( Text , 'Bug @ #2 CreateAttentionBox ; No Text !' )
	assert ( type ( Text ) == 'string' , 'Bug @ #2 CreateAttentionBox ; Not String' )
	local Table = { 
		RedLabel = RedLabel or 255
		, GreenLabel = GreenLabel or 255
		, BlueLabel = BlueLabel or 255
		, AlphaLabel = AlphaLabel or 255
		, PropertyBox = PropertyBox or 'tl:FFA30000 tr:FFA30000 bl:FFA30000 br:FFA30000' 
		, AlphaBox = AlphaBox or 255 
		, TimerSecond = TimerSecond or 4
	}
	Box = guiCreateStaticImage ( 10 , 19 , guiGetSize ( Window , false ) - 20 , 21 , ':guieditor/images/dot_white.png' , false , Window )
	guiSetProperty ( Box , 'ImageColours' , Table.PropertyBox ) 
	guiSetAlpha ( Box , Table.AlphaBox )
	guiSetProperty ( Box , 'AlwaysOnTop' , 'True' )
	Label = guiCreateLabel ( 10 , 0 , guiGetSize ( Window , false ) - 20 , 21 , Text , false , Box )
	guiLabelSetHorizontalAlign ( Label , 'center' , false ) 
	guiLabelSetVerticalAlign ( Label , 'center' )
	guiLabelSetColor ( Label , Table.RedLabel , Table.GreenLabel , Table.BlueLabel , Table.AlphaLabel )
	setTimer ( function ( Box , Label )
		destroyElement ( Label ) destroyElement ( Box )
	end , 1000 * Table.TimerSecond , 1 , Box , Label )
end 
--__EX__--


--____________________________ dxGetTextHeight  ____________________________________________________--
function dxGetTextHeight(text, scale, font)
    if type(text) == "string" then
        scale = type(scale) == "number" and scale or 1
        font = (type(font) == "string" or (isElement(font) and getElementType(font) == "dx-font")) and font or "default"
        local height = dxGetFontHeight(scale, font)
        return ((text:len()-text:gsub("\n", ""):len())*height)+height
    end
    return false
end
--__EX__--


--____________________________ dxDrawButton  ____________________________________________________--
function dxDrawButton(x, y, w, h, color, text)
	if isMouseInPosition(x, y, w, h) then
        dxDrawRectangle(x, y, w, h, tocolor(50, 50, 50, 255), false)
        dxDrawText(text, x, y, x+w, y+h, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	else
        dxDrawRectangle(x, y, w, h, color, false)
        dxDrawText(text, x, y, x+w, y+h, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	end
end
--__EX__--


--____________________________ dxDrawRoundedRectangle - dxDrawCutUpRectangle -dxDrawDxWindow - getMaxStringForWidth____________________________________________________--
function dxDrawRoundedRectangle(x,y,width,height,raduis,color,postgui)

dxDrawRectangle(x,y+raduis,width+1,height-(raduis*2),color,postgui)--horezantal rectangle
dxDrawRectangle(x+raduis,y,width-(raduis*2),height+1,color,postgui)--vertical rectangle

for k=180,270 do--left top
	local co=math.cos(math.rad(k))* raduis
	local si=math.sin(math.rad(k))* raduis
	dxDrawLine((x+raduis)+co,(y+raduis)+si,x+raduis,y+raduis,color,1,postgui)
end
for k=270,360 do--right top
	local co=math.cos(math.rad(k))* raduis
	local si=math.sin(math.rad(k))* raduis
	dxDrawLine((x+width-raduis)+co,(y+raduis)+si,x+width-raduis,y+raduis,color,1,postgui)
end

for k=90,180 do--left bottom
	local co=math.cos(math.rad(k))* raduis
	local si=math.sin(math.rad(k))* raduis
	dxDrawLine((x+raduis)+co,(y+height-raduis)+si,x+raduis,y+height-raduis,color,1,postgui)
end
local k=360
while(k<=(360+90))do
if k~= 360 then
	local co=math.cos(math.rad(k))* raduis
	local si=math.sin(math.rad(k))* raduis
	dxDrawLine((x-raduis+width)+co,(y+height-raduis)+si,x+width-raduis,y+height-raduis,color,1,postgui)
	
end
	k=k+1;
end

end

function dxDrawCutUpRectangle(x,y,width,height,color,postgui,topcolor,bordercolor)

dxDrawRectangle(x,y+(height*5/100),width,height-(height*5/100),color,postgui)--down
dxDrawRectangle(x+(width*6.5/100),y,width-(width*6.5/100),(height*5/100),topcolor,postgui)---top
dxDrawRectangle(x,y,(width*6.5/100),(height*5/100),bordercolor,postgui)---chip left
dxDrawRectangle(x+(width*93.5/100),y,(width*6.5/100),(height*5/100),bordercolor,postgui)---chip right
dxDrawLine(x,y+(height*5/100),x,y+(height),bordercolor,1,postgui)--left
dxDrawLine(x+(width)-1,y+(height*5/100),x+width-1,y+(height),bordercolor,1,postgui)--right
dxDrawLine(x,y+(height)-1,x+width,y+(height)-1,bordercolor,1,postgui)--bottom


end

function dxDrawRoundUpRectangle(x, y, width, height,topcolor, color,postgui)
local radius=(height*5/100)/2
   local width = width - (radius * 2)
   local height = height -( radius * 2)
  local  x = x + radius
  local  y = y + radius

        
        dxDrawCircle(x, y+radius, radius*2, 180, 270, topcolor, topcolor, 7,1,postgui)
        dxDrawCircle(x + width, y+radius, radius*2, 270, 360, topcolor, topcolor, 7,1,postgui)
		dxDrawRectangle(x, y-radius, width, radius*2, topcolor,postgui)
        dxDrawRectangle(x-(radius*2), y+radius, width+(radius*4), height+radius, color,postgui)
		

end

function dxDrawDxWindow(x, y, width, height,topcolor, color,bordercolor,postgui)

dxDrawRectangle(x,y,width,height,color,postgui)
dxDrawRectangle(x,y,width,height*5/100,topcolor,postgui)


dxDrawLine(x,y,x+width-1,y,bordercolor,1,postgui)--top top :D

dxDrawLine(x,y,x,y+height,bordercolor,1,postgui)--left  

dxDrawLine(x+width-1,y,x+width-1,y+height,bordercolor,1,postgui)--right  

dxDrawLine(x,y+height,x+width-1,y+height,bordercolor,1,postgui)--bottom  

end

function getMaxStringForWidth(text,width,isinvers,scale,font)

	local scale=scale or 1.15
	
	local font=font or 'default-bold'
	
	local isinvers= isinvers or false
	
	local mystring=''
	
	local inverstable={}
	
	local num=0
		
	if text~=nil then
			
		local txtwidth=dxGetTextWidth( text,scale,font)
			
			if width>=txtwidth then
			
				return text,text
			
			end
						
		for v in text:gmatch('.') do
		

				if not isinvers then

				mystring=mystring..v
				
					local finalWidth=dxGetTextWidth( mystring,scale,font)
					
						if finalWidth>=width then
							
							mystring=mystring:gsub("[%z\1-\127\194-\244][\128-\191]*$", "")
							
							return mystring,text
							
						end
				
				else
				
					table.insert(inverstable,v)
				
				end
		end
		
				if isinvers then
 
					num=#inverstable
					
					while(num>=1) do
					
						mystring=inverstable[num]..mystring
						
						local finalWidth=dxGetTextWidth( mystring,scale,font)
					
						if finalWidth>=width then
														
							return mystring,text
							
						end
						
						num=num-1
					
					end
					
			return mystring,text
				
				
			
		end
		
	end
	
	return false,text -- MASTER MTA DX
end
--__EX__--


--____________________________ onLocalPlayerStartsMoving - onLocalPlayerStopsMoving  ____________________________________________________--
addEvent("onLocalPlayerStartsMoving")
addEvent("onLocalPlayerStopsMoving")
local localPlayerMoving = false
local deadSpeed = 0.01
setTimer(function ()
    local vx, vy, vz = getElementVelocity(localPlayer)
    local speed = (vx^2 + vy^2 + vz^2)^0.5
    if not localPlayerMoving and speed > deadSpeed then -- if starts moving
        localPlayerMoving = true
        triggerEvent("onLocalPlayerStartsMoving", localPlayer)
    elseif localPlayerMoving and speed <= deadSpeed then -- if stops moving
        localPlayerMoving = false
        triggerEvent("onLocalPlayerStopsMoving", localPlayer)
    end
end, 8000, 0)



addEventHandler("onLocalPlayerStartsMoving", localPlayer, function()
-------------- هنأ تحط الحدث ألي تبيه يصير لمأ الأعب يبدأ الحركة 
end)
addEventHandler("onLocalPlayerStopsMoving", localPlayer, function()
----------- هنأ تحط الحدث الي تبيه يضهر لمأ الأعب يوقف عن الحركة
end)
--__EX__--


--____________________________ guiSwitch  ____________________________________________________--
function guiSwitch(x,y,bool,parent)
local gridlist = guiCreateGridList(x,y, 70, 33,false,parent)
local label = guiCreateLabel(0,0, 38, 30,"O", false,gridlist)
        guiSetFont(label, "default-small")
        guiSetProperty(label, "BackgroundEnabled", "True")
        guiSetProperty(label, "FrameEnabled", "True")
        guiLabelSetHorizontalAlign(label, "center", false)
        guiLabelSetVerticalAlign(label, "center") 
		guiLabelSetColor(label, 255, 0, 0)
addEventHandler("onClientGUIFocus", label, function()
    	if (bool) then	bool = true
		guiSetPosition ( label, 30, 0, false )
		guiLabelSetColor(label, 0, 255, 0)
		guiSetText(label, "|" )
		 else	 bool = false
		guiSetPosition (label, 1, 0, false )
	        guiLabelSetColor(label, 255, 0, 0)
		guiSetText(label, "O" )
		end end)
		addEventHandler("onClientGUIBlur",label,function() bool = true end,true)
		addEventHandler("onClientGUIBlur",label,function() bool = false end,false)
end
--__EX__--
addEventHandler ( "onClientResourceStart",root,
 function ()
 local myWindow = guiCreateWindow ( 0, 0.3, 0.2, 0.1, "Window", true )
 guiCreateLabel(0.1,0.3, 38, 30,"showChat", true,myWindow)
 Switch = guiSwitch(180, 20,true,myWindow) -- new element GUI
 end)

addEventHandler("onClientGUIClick",root,
function ()
	if ( not Switch == true and isChatVisible ) then
        showChat(false) 
        isChatVisible = false
    else
        showChat(true) 
        isChatVisible = true
    end
end
)

--____________________________ warpToPlayer  ____________________________________________________--
function warpToPlayer(thePlr,plrr)

	if getElementType(plrr) == "player" then
	
		if isPedInVehicle(plrr) then
		
			local veh = getPedOccupiedVehicle ( plrr )
			
				local maxp = getVehicleMaxPassengers ( veh )
				
					local passengers = getVehicleOccupants ( veh )
				
						if maxp > 1 and #passengers ~= maxp then
					
							warpPedIntoVehicle(thePlr,veh, #passengers+1)
							
					end
					
else
		
			local x,y,z = getElementPosition(plrr)
			
			setElementPosition(thePlr, x+1,y,z)
			
				end
		end
end
--__EX__--


--____________________________ dxDrawMaterial3D  ____________________________________________________--
	local images = dxCreateTexture("");
function dxDrawMaterial3D(x,y,z,w,h,Material,images,...)
		if Material == "Sphere" then
			local segAngle , radius = 360 / 30 , 0.5 ;
			local fX, fY, tX, tY; 
				for i = 1, 360 do 
				fX = x + math.cos( math.rad( segAngle * i ) ) * radius ;
				fY = y + math.sin( math.rad( segAngle * i ) ) * radius ;
				tX = x + math.cos( math.rad( segAngle * (i+7) ) ) * radius ;
				tY = y + math.sin( math.rad( segAngle * (i+7) ) ) * radius ;
				end
				w,h = 1 ;
			return  dxDrawMaterialLine3D(fX, fY, z+h, tX, tY, z+h, images,w,tocolor(0,0,0,100),false) or "Sphere" ;
		elseif Material == "Box" then
			local w2,h2 = math.floor(4* math.sin( h+ math.rad(100) ) ) ;
			return dxDrawMaterialLine3D(x,y,z, w2, h2, z, images, h,tocolor(0,0,0,100),false) or "Box" ;
		elseif Material == "Triangle" then
				t3 = 360/3 ;
				tX2 = x + math.cos( math.rad( t3 * (h+1) ) ) / w ;
				tY2 = y + math.sin( math.rad( t3 * (h+1) ) ) / w ;
				tZ2 = z + math.tan( math.rad( t3 * (h+1) ) ) / w ;
			return dxDrawMaterialLine3D(x,y,z, tX2, tY2, tZ2, images, h,tocolor(0,0,0,100),false) or "Triangle" ;
		end
end
--__EX__--

addEventHandler("onClientPreRender", root,
function()
dxDrawMaterial3D(0,0,5,5,5,"Sphere","logo.png")
end)
--____________________________ getPlayerInfo  ____________________________________________________--
function getPlayerInfo(thePlayer)
	if isElement(thePlayer) and getElementType(thePlayer) == "player" then
	local aName = getPlayerName(thePlayer)
	local aAcc = getPlayerAccount(thePlayer)
	if not isGuestAccount(aAcc) then
	aAccName = getAccountName(aAcc)
	else
	aAccName = "Guest"
	end
	local hisSerial = getPlayerSerial(thePlayer)
	local aIP = getPlayerIP(thePlayer)
	local hisMoney = getPlayerMoney(thePlayer)
	local hisTeam = getPlayerTeam(thePlayer) or false
	if hisTeam ~= false then
	hisTeamName = getTeamName(hisTeam)
	else
	hisTeamName = "N/A"
	end
	if isPedInVehicle(thePlayer) then
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
	hisVehicleName = getVehicleName(thePlayer)
	else
	hisVehicleName = "On Foot"
	end
	local hisHealth = getElementHealth(thePlayer)
	local hisArmor = getPedArmor(thePlayer)
	local hisDimension = getElementDimension(thePlayer)
	local hisInterior = getElementInterior(thePlayer)
	else
	error("Bad Argument At Argument #1 player not found")
	end
	return aName, aAccName, hisSerial, aIP, hisMoney, hisTeamName, hisVehicleName, hisHealth, hisArmor, hisDimension, hisInterior
end
--__EX__--
addCommandHandler("getmyinfo",
function(plr)
local name, accountname, serial, ip, money, team, vehicle, health, armor, dimension, interior = getPlayerInfo(plr)
outputChatBox("Your Name: "..name, plr,255,0,0,true)
outputChatBox("Your Account name: "..accountname, plr,255,0,0,true)
outputChatBox("Your Serial: "..serial, plr,255,0,0,true)
outputChatBox("Your IP: "..ip, plr,255,0,0,true)
outputChatBox("Your Money: "..money, plr,255,0,0,true)
outputChatBox("Your Team: "..team, plr,255,0,0,true)
outputChatBox("Your Vehicle: "..vehicle, plr,255,0,0,true)
outputChatBox("Your Health: "..health, plr,255,0,0,true)
outputChatBox("Your Armor: "..armor, plr,255,0,0,true)
outputChatBox("Your Dimension: "..dimension, plr,255,0,0,true)
outputChatBox("Your Interior: "..interior, plr,255,0,0,true)
end
)

--____________________________ getPlayerInfo _v2  ____________________________________________________--
function getPlayerInfo ( Player , Type )
	if ( isElement ( Player ) ) and ( getElementType ( Player ) == 'player' ) then
		local Table = {
			[ 'Name' ] = getPlayerName ( Player )
			, [ 'Serial' ] = getPlayerSerial ( Player )
			, [ 'Money' ] = getPlayerMoney ( Player )
			, [ 'TeamName' ] = getPlayerTeam ( Player ) and getTeamName ( getPlayerTeam ( Player ) ) or ''
		}
		if ( not Table [ Type ] ) then return false end 
		return Table [ Type ]
	end 
end
--__EX__--


--____________________________ 123  ____________________________________________________--
function setPedShootOn( ped , element )	
	if( not renderTimer ) then
		renderTimer = { };
	end
    local available_types = 
    {
    	[ 'vehicle' ] = true ,
    	[ 'ped' ] = true ,
    	[ 'player' ] = true ,
    };
	if( ( isElement( ped ) and getElementType( ped ) == "ped" ) and ( isElement( element ) and available_types[ getElementType( element ) ] ) ) then
		if( renderTimer[ ped ] and isTimer( renderTimer[ ped ] ) ) then
			killTimer( renderTimer[ ped ] );
			renderTimer[ ped ] = nil;
		end	    
    	renderTimer[ ped ] = setTimer(
    		function( myPed )
   				local px , py , pz = getElementPosition( myPed );
    			local posX , posY , posZ = getElementPosition( element );
    			local rotZ = -math.deg( math.atan2( posX - px , posY - py ) );
    			if( rotZ < 0 ) then
    				rotZ = rotZ + 360;
    			end
    			setElementRotation( myPed , 0 , 0 , rotZ , "default" , true );
    			setPedAimTarget( myPed , posX , posY , posZ );
    			setPedControlState( myPed , "fire" , not getPedControlState( ped , "fire" ) );				
   			end , 50 , 0 , ped
   		);		
   	end
    return false
end
--__EX__--
local myPed = createPed( 0 , getElementPosition( localPlayer ) );
setPedShootOn( myPed , localPlayer );
givePedWeapon( myPed , 31 , 5000 , true );

-- طبعا متنساش تحط السورس كود الاول :) --

--____________________________ getAccountAcls - hasAccountPermissionTo  ____________________________________________________--
function getAccountAcls(acc)
local acls=aclGroupList()
local ta={}
	for k,v in ipairs(acls)do
		if isObjectInACLGroup('user.'..acc,v) then
			ta[aclGroupGetName(v)]=aclGroupListACL(v)
		end
	end
	return ta
end
function hasAccountPermissionTo(acc,role)
local accacls=getAccountAcls(acc)
types={'general', 'function', 'resource','command'}
for a,b in ipairs(accacls)do
	for m=1,3 do
		for k,v in ipairs(aclListRights(b,types[m]))do
			if string.find(string.upper(v),string.upper(role)) then
				return true
			end
		end
	end
end
return false
end
--__EX__--


--____________________________ 123  ____________________________________________________--
function getNearsetElmFromXYZ( etype , x , y , z ) 
	local elements , positions , element = getElementsByType( etype ) , { } , { }
	if( ( not elements ) or ( #elements == 0 ) ) then
		return false
	end
	for index = 1 , #elements do
		positions[ index ] = getDistanceBetweenPoints3D( x , y , z , getElementPosition( elements[ index ] ) );
		element[ positions[ index ] ] = elements[ index ];
	end
	return element[ math.min( unpack( positions ) ) ];	
end

--__EX__--

addCommandHandler( "getNearsetVeh" , 
	function( plr )
		local nearstVehicle = getNearsetElmFromXYZ( "vehicle" , getElementPosition( plr ) );
		if( not nearstVehicle ) then
			return outputChatBox( "There\'s not vehicles" );
		end
		outputChatBox( "Name : " .. getVehicleName( nearstVehicle ) );
		outputChatBox( "Model : " .. getElementModel( nearstVehicle ) );
	end
)--____________________________ getPlayerInfo _v3  ____________________________________________________--
PLAYER_DATA = {
	"serial",
	"money",
	"team" = function(player)
		local team = getPlayerTeam(player)
		return team and getTeamName(team)
	end,
	"&level",
	"&clan",
	"name",
	"wantedLevel",
	"&kills",
	tag = function(player)
		return getPlayerName(player):match "^%b[]"
	end,
	-- u cann add more...
	
	-- x = getPlayerX
	-- &x = getElementData(player, x)
	-- x() = custom function
}

function getPlayerInfo(player)
	if isElement(player) and getElementType(player) == "player" then
		local data = []
		for k, v in pairs(PLAYER_DATA) do
			local pre = v:sub(1, 1) == "&"
			if pre then
				data[v:sub(2)] = getElementData(player, v)
			elseif type(v) == "function" then
				data[k] = v(player)
			else
				data[v] = _G["getPlayer"..v:gsub("^%a", string.upper)](player)
			end
		end
		return data
	end
end
--__EX__--


--____________________________ guiSetProgressBarRun   ____________________________________________________--
function guiSetProgressBarRun ( guiElement, ProgressBarCount, ProgressBarCountPlus ) 
         if not guiElement == "gui-progressbar"  or not ProgressBarCount or not ProgressBarCountPlus then 
        outputDebugString("Bad arugment @ guiSetProgressBarRun ",0,255,0,0) 
       return end 
        guiProgressBarSetProgress ( guiElement ,tonumber( ProgressBarCount ) ) 
        setTimer( 
            function ( ) 
            if not tonumber ( ProgressBarCount ) then return false end 
                ProgressBarCount = ProgressBarCount + ProgressBarCountPlus
            guiProgressBarSetProgress ( guiElement ,tonumber( ProgressBarCount ) ) 
        end , 1000 , ProgressBarCount  ) 
end 
--__EX__--
addEventHandler("onClientResourceStart", resourceRoot,
function()
	salh = guiCreateProgressBar(393, 533, 438, 65, false)   
	guiSetProgressBarRun(salh, 0, 10)
end
)

--____________________________ guiSetProgressBarRun _v2 MASTER  ____________________________________________________--
function guiSetProgressBarRun ( guiElement, ProgressBarCount, ProgressBarCountPlus,isdone ) 
         if not guiElement == "gui-progressbar"  or not ProgressBarCount or not ProgressBarCountPlus then 
        outputDebugString("Bad arugment @ guiSetProgressBarRun ",0,255,0,0) 
       return end 
   		if not isdone then
  			guiProgressBarSetProgress ( guiElement ,tonumber( ProgressBarCount ) ) 
    	end
  		if guiProgressBarGetProgress(guiElement)<100 then
  			guiProgressBarSetProgress ( guiElement ,tonumber( ProgressBarCount )+ProgressBarCountPlus ) 
    		guiSetProgressBarRun ( guiElement, ProgressBarCount, ProgressBarCountPlus,true ) 
  		end
  return true
       
end 
--____________________________ compareTables   ____________________________--	
function compareTables(tblToCompare, tblToCompareTo)
    if (type(tblToCompareTo)=="table") and (type(tblToCompare)=="table") then
        for k, v in pairs(tblToCompareTo) do
            if not (type(tblToCompare[k])=="nil") then
                if (type(v)=="table") then
                    if not (compareTables(tblToCompare[k], v)) then return false, "Tables not matched at key"..tostring(k) end
                else
                    if not (type(v)==type(tblToCompare[k])) then return false, "Values not matched at key"..tostring(k) end
                end
            else
                return false, "nil value"
            end
        end
        return true
    else
        return false
    end
end
--____________________________ converMoney   ____________________________--	
function converMoney(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
		if (k==0) then
			break
		end
	end
	return formatted
end
--____________________________ convertNumber   ____________________________--	
function convertNumber(number)  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if (k==0) then      
			break   
		end  
	end  
	return formatted
end
--____________________________ createIndexIfNil   ____________________________--	
function createIndexIfNil(t, i, v)
    if not (type(i)=="nil") then
        if (type(t[i])=="nil") then
            t[i] = v or {}
        end
    end
end
--____________________________ dxDrawBorder   ____________________________--	
function dxDrawBorder(x, y, w, h, t, color, postaGECI)
    dxDrawRectangle(x, y, t, h, color, postaGECI)--// Left
    dxDrawRectangle(x-t+w, t, h, color, postaGECI)--// Right

    dxDrawRectangle(x, y, w, t, color, postaGECI)--// Top
    dxDrawRectangle(x, y-t+h, w, t, color, postaGECI)--// Bottom
end

--// Vector
function dxDrawBorder(x, y, w, h, t, color, postaGECI)
    dxDrawRectangle(pos.x, pos.y, t, pos.y, color, postaGECI)--// Left
    dxDrawRectangle(x-t+pos.x, pos.y, t, pos.y, color, postaGECI)--// Right

    dxDrawRectangle(pos.x, pos.y, pos.x, t, color, postaGECI)--// Top
    dxDrawRectangle(pos.x, pos.y-t+pos.y, pos.x, t, color, postaGECI)--// Bottom
end
--____________________________ dxDrawRoundedBorder   ____________________________--	
function dxDrawRoundedBorder(x, y, w, h, borderColor, postGUI)
	if (x) and (y) and (w) and (h) then
		borderColor = borderColor or tocolor(255, 255, 255, 230)

		dxDrawRectangle(x - 1, y + 1, 1, h - 2, borderColor, postGUI) -- left
		dxDrawRectangle(x + w, y + 1, 1, h - 2, borderColor, postGUI)-- right
		dxDrawRectangle(x + 1, y - 1, w - 2, 1, borderColor, postGUI) -- top
		dxDrawRectangle(x + 1, y + h, w - 2, 1, borderColor, postGUI) -- bottom

		dxDrawRectangle(x, y, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x + w - 1, y, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x, y + h - 1, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x + w - 1, y + h - 1, 1, 1, borderColor, postGUI)
	end
end
--____________________________ dxDrawRoundedRectangle   ____________________________--
function dxDrawRoundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x) and (y) and (w) and (h) then
		borderColor = borderColor or tocolor(0, 0, 0, 200)
		bgColor = bgColor or borderColor
	
		--> Background
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		
		--> Border
		dxDrawRectangle(x - 1, y + 1, 1, h - 2, borderColor, postGUI)-- left
		dxDrawRectangle(x + w, y + 1, 1, h - 2, borderColor, postGUI)-- right
		dxDrawRectangle(x + 1, y - 1, w - 2, 1, borderColor, postGUI)-- top
		dxDrawRectangle(x + 1, y + h, w - 2, 1, borderColor, postGUI)-- bottom
		dxDrawRectangle(x, y, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x + w - 1, y, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x, y + h - 1, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x + w - 1, y + h - 1, 1, 1, borderColor, postGUI)
	end
end
--____________________________ dxGetTextHeight   ____________________________--
function dxGetTextHeight(text, fScale, font)
    if (text) and (fScale) and (font) then
        local fHeight = dxGetFontHeight(1, font)
        local h = fHeight
        for _, world in string.gmatch(text, "\n") do
            h = h+fHeight
        end
        return h, fHeight
    end
end
--____________________________ isCursorOnBox   ____________________________--
cx, cy = 0, 0
bCursorShown = false

function isCursorOnBox(x, y, w, h)
    if (bCursorShown) then   
        return (cx >= x and cx <= x+w and cy >= y and cy <= y+h)
    end	
    return false
end
--____________________________ getRotatationFromPoint   ____________________________--	
function getRotatationFromPoint(x1, y1, x2, y2)
    local t = -math.deg(math.atan2(x2-x1, y2-y1))
    return t<0 and t+360 or t
end
--____________________________ table.copy   ____________________________--	
function table.copy(orig)
    local copy = {}
    for orig_key, orig_value in pairs(orig) do
        copy[orig_key] = ((type(orig_value)=="table") and table.copy(orig_value)) or orig_value
    end
    return copy
end
--____________________________ worldBreak   ____________________________--
function worldBreak(text, fScale, font, w)
    local finalText = ""
    for k, world in pairs(split(text, string.byte(" "))) do
        if (dxGetTextWidth(removeHex(finalText..world), fScale, font)>=w) then
            finalText = finalText.."\n"..world
        else
            finalText = finalText.." "..world
        end
    end
    return finalText
end
--____________________________ worldBreak   ____________________________--	
    
function worldBreak(text, w, fontScale, font)
    local lastEnd, lastStart = 0, 0
    local currentEnd, currentStart
    local str = ""
    local currentWorld
    local sepFromLastWorld
    while true do
        currentStart, currentEnd = string.find(text, "%w+", lastEnd+1)
        if not (currentStart) then break end
        sepFromLastWorld = string.sub(text, lastEnd+1, currentStart-1)
        currentWorld = string.sub(text, currentStart, currentEnd)
        
        if (dxGetTextWidth(str, fontScale, font)<w) then
          str = str..sepFromLastWorld..currentWorld
        else
          str = str.."\n"..currentWorld
          print("Break at", currentStart)
        end
        lastEnd, lastStart = currentEnd, currentStart
    end
    return str
end
	
--____________________________ compareTables   ____________________________--	
function compareTables(tblToCompare, tblToCompareTo)
    if (type(tblToCompareTo)=="table") and (type(tblToCompare)=="table") then
        for k, v in pairs(tblToCompareTo) do
            if not (type(tblToCompare[k])=="nil") then
                if (type(v)=="table") then
                    if not (compareTables(tblToCompare[k], v)) then return false, "Tables not matched at key"..tostring(k) end
                else
                    if not (type(v)==type(tblToCompare[k])) then return false, "Values not matched at key"..tostring(k) end
                end
            else
                return false, "nil value"
            end
        end
        return true
    else
        return false
    end
end
