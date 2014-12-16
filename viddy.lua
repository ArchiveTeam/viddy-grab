dofile("urlcode.lua")
dofile("table_show.lua")
JSON = (loadfile "JSON.lua")()

local url_count = 0
local tries = 0
local item_type = os.getenv('item_type')
local item_value = os.getenv('item_value')
local item_url1 = os.getenv('item_url1')
local item_url2 = os.getenv('item_url2')
local item_url3 = os.getenv('item_url3')

local downloaded = {}
local addedtolist = {}

-- exclude all the following urls:
-- ep1c:
downloaded["http://ep1c.com/static/css/vagroundedstd.css?v=goodbye1"] = true
downloaded["http://ep1c.com/static/css/epic.css?v=goodbye1"] = true
downloaded["http://ep1c.com/static/img/favicon.ico"] = true
downloaded["http://ep1c.com/static/js/jquery.zclip.js?v=goodbye1"] = true
downloaded["http://ep1c.com/static/js/epic.js?v=goodbye1"] = true
downloaded["http://ep1c.com/static/css/VAGRoundedStd-Light.otf"] = true
downloaded["http://ep1c.com/static/css/VAGRoundedStd-Thin.otf"] = true
downloaded["http://ep1c.com/static/css/VAGRoundedStd-Bold.otf"] = true
downloaded["http://ep1c.com/static/img/copied.png"] = true
downloaded["http://ep1c.com/static/img/app-store.png"] = true
downloaded["http://ep1c.com/static/img/epic-logo.png"] = true
downloaded["http://ep1c.com/static/img/home-phone.png"] = true
downloaded["http://ep1c.com/static/img/download.png"] = true
downloaded["http://ep1c.com/static/img/dropbox.png"] = true
downloaded["http://ep1c.com/static/img/processing.gif"] = true
downloaded["http://www.viddy.com/content/contact"] = true
downloaded["http://www.viddy.com/legal/terms"] = true
downloaded["http://www.viddy.com/static/img/santa-monica.jpg"] = true
downloaded["http://www.viddy.com/legal/privacy"] = true
-- viddy:
downloaded["http://awspy-c15m.viddy-assets.com/static/img/favicon2.ico"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/144x144.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/114x114.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/72x72.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/57x57.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/320x460.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/640x920.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/640x1096.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/768x1004.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/748x1024.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/748x1024.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/1536x2008.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/1496x2048.png"] = true
downloaded["http://www.viddy.com/static/css/font/vagroundedstd.css?v=goodbye"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/min/base.css?v=goodbye"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/min/mid.css?v=goodbye"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/min/large.css?v=goodbye"] = true
downloaded["http://www.viddy.com/resources/index?v=goodbye&lang=None.js"] = true
downloaded["http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/js/extra/json2.js?v=goodbye%3E%3C/script%3E%3C![endif]--%3E%0A%09%3Clink%20href="] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/js/extra/html5shiv.js?v=goodbye"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/mobile-icons/144x144-ms.png"] = true
downloaded["http://www.viddy.com/static/css/font/VAGRoundedStd-Light.otf"] = true
downloaded["http://www.viddy.com/static/css/font/VAGRoundedStd-Thin.otf"] = true
downloaded["http://www.viddy.com/static/css/font/VAGRoundedStd-Bold.otf"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/loading.gif"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/home-phone.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/video-loading-background.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/white-heart.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/comment.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/play.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/black-heart.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/red-heart.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/white-dots.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/black-dots.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/jagged-edge.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/jagged-edge-up.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/no-flash.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/facebook-logo.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/twitter-logo.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/push-off.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/email-off.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/push-on.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/email-on.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/check-off.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/check-on.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/toggle-off.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/toggle-on.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/download.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/dropbox.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/processing.gif"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/postroll-overlay.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/img/postroll-phone.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/appstore-badge.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/googleplay-badge.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/postroll-phone.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/css/img/postroll-overlay.png"] = true
downloaded["http://awspy-c15m.viddy-assets.com/static/js/extra/json2.js?v=goodbye%3E%3C/script%3E%3C![endif]--%3E%0A%09%3Clink%20href="] = true

load_json_file = function(file)
  if file then
    local f = io.open(file)
    local data = f:read("*all")
    f:close()
    return JSON:decode(data)
  else
    return nil
  end
end

read_file = function(file)
  if file then
    local f = assert(io.open(file))
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

wget.callbacks.lookup_host = function(host)
  if host == "www.viddy.com" or host == "viddy.com" then
    return "54.88.216.245"
  end
end

wget.callbacks.download_child_p = function(urlpos, parent, depth, start_url_parsed, iri, verdict, reason)
  local url = urlpos["url"]["url"]
  local html = urlpos["link_expect_html"]
  local parenturl = parent["url"]
  local html = nil
  
  if downloaded[url] == true or addedtolist[url] == true then
    return false
  end
  
  if string.match(url, "https://") then
    newurl = string.gsub(url, "https://", "http://")
  elseif string.match(url, "http://") then
    newurl = url
  end
  
  if item_type == "ep1cvideo2" and (downloaded[newurl] ~= true or addedtolist[newurl] ~= true) then
    if string.match(url, "viddy%.com/[^/]+/[0-9a-zA-Z]+")
      or string.match(url, "cdn%.ep1c%.com")
      or string.match(url, "ep1c%.com/static/swf/")
      or string.match(url, "viddy%.com/[^/]+/[vm]/[0-9a-zA-Z]+")
      or string.match(url, "ep1c%.com/e/")
      or string.match(url, "ep1c%.com/v/")
      or string.match(url, "ep1c%.com/video/")
      or string.match(url, "viddy%.it")
      or string.match(url, "ep1c%.com/[0-9a-zA-Z]+[^/]") then
      if not (string.match(url, "%-medium") or string.match(url, "%-low")) then
        if string.match(url, "https://") then
          newurl = string.gsub(url, "https://", "http://")
          addedtolist[newurl] = true
          return true
        elseif string.match(url, "http://") then
          addedtolist[url] = true
          return true
        end
      else
        return false
      end
    else
      return false
    end
  end
  
  if (item_type == "viddyvideo2" or item_type == "viddyvideo3") and (downloaded[newurl] ~= true or addedtolist[newurl] ~= true) then
    if (item_type == "viddyvideo2" and string.match(url, "viddy%.com/media/"..item_url2))
      or (item_type == "viddyvideo2" and string.match(url, "viddy%.com/video/"..item_url2))
      or (item_type == "viddyvideo3" and string.match(url, "viddy%.com/"..item_url1.."/[vm]/"..item_url3))
      or string.match(url, "viddy%.it")
      or string.match(url, "viddy%.com/[^/]+/v/")
      or string.match(url, "viddy%.com/[^/]+/m/")
      or string.match(url, "use%.typekit%.com")
      or string.match(url, "p%.typekit%.com")
      or string.match(url, "viddy%-assets%.com")
      or string.match(url, "cdn%.viddy%.com")
      or string.match(url, "livepassdl%.conviva%.com")
      or string.match(url, "api%.mixpanel%.com")
      or string.match(url, "gwa%.lphbs%.com")
      or string.match(url, "gwc%.lphbs%.com")
      or string.match(url, "gwd%.lphbs%.com")
      or string.match(url, "cdn%.mxpnl%.com")
      or string.match(url, "/resources/")
      or string.match(url, "/images/")
      or string.match(url, "/v1/")
      or string.match(url, "/static/")
      or string.match(url, "/media/")
      or string.match(url, "/video/")
      or string.match(url, "/ajax/") then
      if not (string.match(url, "%-medium") or string.match(url, "%-low")) then
        if string.match(url, "https://") then
          newurl = string.gsub(url, "https://", "http://")
          addedtolist[newurl] = true
          return true
        elseif string.match(url, "http://") then
          addedtolist[url] = true
          return true
        end
      else
        return false
      end
    else
      return false
    end
  end
  
end


wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  local html = nil
  
--  if string.match(url, "%-high") and string.match(url, "%.mp4") then
--    local newurl = string.gsub(url, "%-high", "-medium")
--    if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
--      table.insert(urls, { url=newurl })
--      addedtolist[newurl] = true
--    end
--  end
  
--  if string.match(url, "%-medium") and string.match(url, "%.mp4") then
--    local newurl = string.gsub(url, "%-medium", "-low")
--    if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
--      table.insert(urls, { url=newurl })
--      addedtolist[newurl] = true
--    end
--  end
  
--  if string.match(url, "%-low") and string.match(url, "%.mp4") then
--    local newurl = string.gsub(url, "%-low", "-high")
--    if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
--      table.insert(urls, { url=newurl })
--      addedtolist[newurl] = true
--    end
--  end
  if item_type == 'user' then
    if string.match(url, "http://www.viddy.com/v1/users/") and not string.match(url, "http://www.viddy.com/v1/users/[^/]+/") then
      html = read_file(file)
      for customurl in string.gmatch(html, '"(http[s]?://[^"]+)"') do
        if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
          table.insert(urls, { url=customurl })
          addedtolist[customurl] = true
        end
      end
    end
  end
  
  if item_type == "ep1cvideo2" then
    if string.match(url, "http[s]?://www%.ep1c%.com/video/.+[^/]")
      or string.match(url, "http[s]?://www%.ep1c%.com/v/.+[^/]")
      or string.match(url, "http[s]?://www%.ep1c%.com/e/.+[^/]")
      or string.match(url, "http[s]?://ep1c%.com/v/.+[^/]")
      or string.match(url, "http[s]?://ep1c%.com/e/.+[^/]")
      or string.match(url, "http[s]?://ep1c%.com/video/.+[^/]")then
      
      html = read_file(file)
      
      for customurl in string.gmatch(html, '"(http[s]?://[^"]+)"') do
        if string.match(customurl, "viddy%.com/[^/]+/[0-9a-zA-Z]+")
          or string.match(customurl, "cdn%.ep1c%.com")
          or string.match(customurl, "ep1c%.com/static/swf/")
          or string.match(customurl, "viddy%.com/[^/]+/[vm]/[0-9a-zA-Z]+")
          or string.match(customurl, "ep1c%.com/e/")
          or string.match(customurl, "viddy%.it")
          or string.match(customurl, "ep1c%.com/[0-9a-zA-Z]+[^/]") then
          if string.match(customurl, "%-medium") and string.match(customurl, "%.mp4") then
            local newurl = string.gsub(customurl, "%-medium", "-high")
            if string.match(newurl, "https://") then
              local newnewurl = string.gsub(newurl, "https://", "http://")
              if downloaded[newnewurl] ~= true and addedtolist[newnewurl] ~= true then
                table.insert(urls, { url=newurl })
                addedtolist[newnewurl] = true
              end
            elseif string.match(newurl, "http://") then
              if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
                table.insert(urls, { url=newurl })
                addedtolist[newurl] = true
              end
            end
          elseif string.match(customurl, "%-low") and string.match(customurl, "%.mp4") then
            local newurl = string.gsub(customurl, "%-low", "-high")
            if string.match(newurl, "https://") then
              local newnewurl = string.gsub(newurl, "https://", "http://")
              if downloaded[newnewurl] ~= true and addedtolist[newnewurl] ~= true then
                table.insert(urls, { url=newurl })
                addedtolist[newnewurl] = true
              end
            elseif string.match(newurl, "http://") then
              if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
                table.insert(urls, { url=newurl })
                addedtolist[newurl] = true
              end
            end
          elseif string.match(customurl, "/www%.viddy%.it/") then
            local newurl = string.gsub(customurl, "/www%.viddy%.it", "/viddy.it")
            if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
              table.insert(urls, { url=newurl })
              addedtolist[newurl] = true
            end
          elseif not (string.match(customurl, "%-low") and string.match(customurl, "%-medium") and string.match(customurl, "http[s]?://www%.viddy%.it/")) then
            if string.match(customurl, "https://") then
              local newcustomurl = string.gsub(customurl, "https://", "http://")
              if downloaded[newcustomurl] ~= true and addedtolist[newcustomurl] ~= true then
                table.insert(urls, { url=newcustomurl })
                addedtolist[customurl] = true
              end
            elseif string.match(customurl, "http://") then
              if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
                table.insert(urls, { url=customurl })
                addedtolist[customurl] = true
              end
            end
          end
        end
      end
    end
  end
  
  
  if item_type == "viddyvideo2" or item_type == "viddyvideo3" then
    if (string.match(url, "%.com/media/")
      or string.match(url, "%.com/video/")
      or string.match(url, "%.com/[^/]+/m/")
      or string.match(url, "%.com/[^/]+/v/"))
      and not (string.match(url, "http[s]?://cdn%.viddy%.com/")
      or string.match(url, item_url2.."/comments")
      or string.match(url, item_url2.."/likes")
      or string.match(url, item_url2.."/tags")) then
      
      html = read_file(file)
      
      io.stdout:write("Url "..url.." is being checked for extracting links.  \n")
      io.stdout:flush()
      
      if string.match(url, "viddy%.com/media/") then
        local newurl = string.gsub(url, "viddy%.com/media/", "viddy.com/video/")
        if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
          table.insert(urls, { url=newurl })
          addedtolist[newurl] = true
        end
      end
      
      if string.match(url, "viddy%.com/video/") then
        local newurl = string.gsub(url, "viddy%.com/video/", "viddy.com/media/")
        if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
          table.insert(urls, { url=newurl })
          addedtolist[newurl] = true
        end
      end
      
      if string.match(url, "viddy.com/[^/]+/m/") then
        local newurl = string.gsub(url, "/m/", "/v/")
        if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
          table.insert(urls, { url=newurl })
          addedtolist[newurl] = true
        end
      end
      
      if string.match(url, "viddy.com/[^/]+/v/") then
        local newurl = string.gsub(url, "/v/", "/m/")
        if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
          table.insert(urls, { url=newurl })
          addedtolist[newurl] = true
        end
      end
      
      for customurl in string.gmatch(html, '"(http[s]?://[^"]+)"') do
        if string.match(customurl, "viddy%.it")
          or string.match(customurl, "viddy%.com/[^/]+/v/")
          or string.match(customurl, "viddy%.com/[^/]+/m/")
          or string.match(customurl, "use%.typekit%.com")
          or string.match(customurl, "p%.typekit%.com")
          or string.match(customurl, "viddy%-assets%.com")
          or string.match(customurl, "cdn%.viddy%.com")
          or string.match(customurl, "livepassdl%.conviva%.com")
          or string.match(customurl, "api%.mixpanel%.com")
          or string.match(customurl, "gwa%.lphbs%.com")
          or string.match(customurl, "gwc%.lphbs%.com")
          or string.match(customurl, "gwd%.lphbs%.com")
          or string.match(customurl, "cdn%.mxpnl%.com")
          or string.match(customurl, "/resources/")
          or string.match(customurl, "/images/")
          or string.match(customurl, "/v1/")
          or string.match(customurl, "/static/")
          or string.match(customurl, "/media/")
          or string.match(customurl, "/video/")
          or string.match(customurl, "/ajax/") then
          if string.match(customurl, "%-medium") and string.match(customurl, "%.mp4") then
            local newurl = string.gsub(customurl, "%-medium", "-high")
            if string.match(newurl, "https://") then
              local newnewurl = string.gsub(newurl, "https://", "http://")
              if downloaded[newnewurl] ~= true and addedtolist[newnewurl] ~= true then
                table.insert(urls, { url=newurl })
                addedtolist[newnewurl] = true
              end
            elseif string.match(newurl, "http://") then
              if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
                table.insert(urls, { url=newurl })
                addedtolist[newurl] = true
              end
            end
          elseif string.match(customurl, "%-low") and string.match(customurl, "%.mp4") then
            local newurl = string.gsub(customurl, "%-low", "-high")
            if string.match(newurl, "https://") then
              local newnewurl = string.gsub(newurl, "https://", "http://")
              if downloaded[newnewurl] ~= true and addedtolist[newnewurl] ~= true then
                table.insert(urls, { url=newurl })
                addedtolist[newnewurl] = true
              end
            elseif string.match(newurl, "http://") then
              if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
                table.insert(urls, { url=newurl })
                addedtolist[newurl] = true
              end
            end
          elseif string.match(customurl, "/www%.viddy%.it/") then
            local newurl = string.gsub(customurl, "/www%.viddy%.it", "/viddy.it")
            if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
              table.insert(urls, { url=newurl })
              addedtolist[newurl] = true
            end
          elseif not (string.match(customurl, "%-low") and string.match(customurl, "%-medium") and string.match(customurl, "http[s]?://www%.viddy%.it/")) then
            if string.match(customurl, "https://") then
              local newcustomurl = string.gsub(customurl, "https://", "http://")
              if downloaded[newcustomurl] ~= true and addedtolist[newcustomurl] ~= true then
                table.insert(urls, { url=newcustomurl })
                addedtolist[customurl] = true
              end
            elseif string.match(customurl, "http://") then
              if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
                table.insert(urls, { url=customurl })
                addedtolist[customurl] = true
              end
            end
          end
        end
      end
      for customurlnf in string.gmatch(html, '"//([^"]+)"') do
        if string.match(customurlnf, "viddy%.it")
          or string.match(customurlnf, "viddy%.com/[^/]+/v/")
          or string.match(customurlnf, "viddy%.com/[^/]+/m/")
          or string.match(customurlnf, "use%.typekit%.com")
          or string.match(customurlnf, "p%.typekit%.com")
          or string.match(customurlnf, "viddy%-assets%.com")
          or string.match(customurlnf, "cdn%.viddy%.com")
          or string.match(customurlnf, "livepassdl%.conviva%.com")
          or string.match(customurlnf, "api%.mixpanel%.com")
          or string.match(customurlnf, "gwa%.lphbs%.com")
          or string.match(customurlnf, "gwc%.lphbs%.com")
          or string.match(customurlnf, "gwd%.lphbs%.com")
          or string.match(customurlnf, "cdn%.mxpnl%.com")
          or string.match(customurlnf, "/resources/")
          or string.match(customurlnf, "/images/")
          or string.match(customurlnf, "/v1/")
          or string.match(customurlnf, "/static/")
          or string.match(customurlnf, "/media/")
          or string.match(customurlnf, "/video/")
          or string.match(customurlnf, "/ajax/") then
          local base = "http://"
          local customurl = base..customurlnf
          if string.match(customurl, "%-medium") and string.match(customurl, "%.mp4") then
            local newurl = string.gsub(customurl, "%-medium", "-high")
            if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
              table.insert(urls, { url=newurl })
              addedtolist[newurl] = true
            end
          elseif string.match(customurl, "%-low") and string.match(customurl, "%.mp4") then
            local newurl = string.gsub(customurl, "%-low", "-high")
            if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
              table.insert(urls, { url=newurl })
              addedtolist[newurl] = true
            end
          elseif string.match(customurl, "/www%.viddy%.it/") then
            local newurl = string.gsub(customurl, "/www%.viddy%.it", "/viddy.it")
            if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
              table.insert(urls, { url=newurl })
              addedtolist[newurl] = true
            end
          elseif not (string.match(customurl, "%-low") and string.match(customurl, "%-medium") and string.match(customurl, "http[s]?://www%.viddy%.it/")) then
            if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
              table.insert(urls, { url=customurl })
              addedtolist[customurl] = true
            end
          end
        end
      end
      for customurlnf in string.gmatch(html, '"(/[^/][^"]+)"') do
        if string.match(customurlnf, "/[^/]+/v/")
          or string.match(customurlnf, "/[^/]+/m/")
          or string.match(customurlnf, "/resources/")
          or string.match(customurlnf, "/images/")
          or string.match(customurlnf, "/v1/")
          or string.match(customurlnf, "/static/")
          or string.match(customurlnf, "/media/")
          or string.match(customurlnf, "/video/")
          or string.match(customurlnf, "/ajax/") then
          local base = "http://www.viddy.com"
          local customurl = base..customurlnf
          if string.match(customurl, "%-medium") and string.match(customurl, "%.mp4") then
            local newurl = string.gsub(customurl, "%-medium", "-high")
            if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif string.match(customurl, "%-low") and string.match(customurl, "%.mp4") then
            local newurl = string.gsub(customurl, "%-low", "-high")
          if downloaded[newurl] ~= true and addedtolist[newurl] ~= true then
              table.insert(urls, { url=newurl })
            end
          elseif not (string.match(customurl, "%-low") and string.match(customurl, "%-medium")) then
            if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
              table.insert(urls, { url=customurl })
              addedtolist[customurl] = true
            end
          end
        end
      end
    end
  end
  
  return urls
end
  

wget.callbacks.httploop_result = function(url, err, http_stat)
  -- NEW for 2014: Slightly more verbose messages because people keep
  -- complaining that it's not moving or not working
  local status_code = http_stat["statcode"]
  
  url_count = url_count + 1
  io.stdout:write(url_count .. "=" .. status_code .. " " .. url["url"] .. ".  \n")
  io.stdout:flush()
  
  if (status_code >= 200 and status_code <= 399) or status_code == 403 then
    if string.match(url["url"], "https://") then
      local newurl = string.gsub(url["url"], "https://", "http://")
      downloaded[newurl] = true
    else
      downloaded[url["url"]] = true
    end
  end
  
  if item_type == 'user' and status_code == 302 then
    return wget.actions.EXIT
  elseif string.match(url["url"], "http[s]://viddy%.it/") or string.match(url["url"], "http[s]?://www%.viddy%.it/") then
    return wget.actions.EXIT
  elseif status_code >= 500 or
    (status_code >= 400 and status_code ~= 404 and status_code ~= 403) then
    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 1")

    tries = tries + 1

    if tries >= 20 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  elseif status_code == 0 then
    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")

    tries = tries + 1

    if tries >= 10 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  end

  tries = 0

  -- We're okay; sleep a bit (if we have to) and continue
  -- local sleep_time = 0.1 * (math.random(75, 1000) / 100.0)
  local sleep_time = 0

  --  if string.match(url["host"], "cdn") or string.match(url["host"], "media") then
  --    -- We should be able to go fast on images since that's what a web browser does
  --    sleep_time = 0
  --  end

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end
