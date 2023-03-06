-- Replace the webhook URL with your own Discord webhook URL
local webhookUrl = "https://canary.discord.com/api/webhooks/1082296118710390794/5S2owAZmaAWjatjQya93gg--w5_wTuqZcq274qSWWQbH388RE_3oWwqFMSMt4s58ms6V"
-- Customize the embed color (RGB)
local embedColor = {255, 0, 0}

function sendDiscordMessage(message)
  PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
  local source = source
  local steamid, license, xbl, ip, discord, liveid
  for k,v in pairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steamid = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      xbl  = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      ip = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      liveid = v
    end
  end
  local message = "Player: **"..name.."** is connecting to the server.\n"
  message = message.."SteamID: "..(steamid or "Not available").."\n"
  message = message.."License: "..(license or "Not available").."\n"
  message = message.."XBL: "..(xbl or "Not available").."\n"
  message = message.."IP Address: "..(ip or "Not available").."\n"
  message = message.."Discord ID: "..(discord or "Not available").."\n"
  message = message.."Xbox Live ID: "..(liveid or "Not available")
  sendDiscordMessage(message)
end)

AddEventHandler('playerDropped', function(reason)
  local source = source
  local steamid, license, xbl, ip, discord, liveid
  for k,v in pairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steamid = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      xbl = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      ip = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      liveid = v
    end
  end
  local message = "Player: **"..GetPlayerName(source).."** has disconnected.\n"
  message = message.."SteamID: "..(steamid or "Not available").."\n"
  message = message.."License: "..(license or "Not available").."\n"
  message = message.."XBL: "..(xbl or "Not available").."\n"
  message = message.."Discord ID: "..(discord or "Not available").."\n"
  message = message.."Live ID: "..(liveid or "Not available").."\n"
  message = message.."IP: "..(ip or "Not available").."\n"
  print(message)
end)
