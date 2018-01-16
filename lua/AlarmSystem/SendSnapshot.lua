--[[
%% properties
%% events
%% globals
--]]


-- Legende der ID's der Webkameras

-- 578 - Eingangstüre
-- 613 - Einfahrt
-- 614 - Carport
-- 615 - Schopf
-- 616 - Kellereingang
-- 617 - Spielwiese
-- 618 - Pool
-- 619 - Garteneingang

-- 590 - Keller

local handyName = 'Ghosts-iPhone'; -- Name des Handys (Pushover)
local cameraID = {578,613,614,615,616,617}; -- ID's der Webkameras
local AlarmStatus = fibaro:getGlobalValue("AlarmStatus");


-- scene should only run once at the same time
if (fibaro:countScenes() > 1) then
   fibaro:abort();
end

-- function to write colored text into log
Debug = function ( color, message )
  fibaro:debug(string.format('<%s style="color:%s;">%s', "span", color, message, "span"))
end

-- function to send message over 'pushover' service
function sendPushover(message)

 local device = "Ghosts-iPhone"; 
 local prio = "0";
 local sound = "intermission";
 local title = "Snapshot";
 local requestBody = '&html=1&device='..device ..'&priority=' ..prio ..'&sound=' ..sound ..'&title=' ..title ..'&message=' ..message;
 fibaro:setGlobal("pushoverBody", requestBody);
  
end

Debug('aqua','Szene wurde gestartet!');

Debug("orange","Snapshots werden erstellt...");
for i=1, #cameraID do
   fibaro:call(cameraID[i], "sendPhotoToEmail", "ghost@rogerwyss.ch");
end
Debug("yellow","Snapshots gesendet");

sendPushover('\xf0\x9f\x93\xb8 Snapshots wurden gesendet');
Debug('yellow','sendPush');


Debug('aqua', "Szene wurde erfolgreich beendet\n");

