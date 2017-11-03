local mapping = ngx.shared.redirect_mapping
local path = ngx.var[1] --path
local method = ngx.req.get_method()

if method == "GET" then
    if type(mapping:get(path)) == "string" then
        ngx.redirect(mapping:get(path), 302)
    else
        ngx.say("No mapping found, path : ", path)
        ngx.exit(404)
    end
elseif method == "DELETE" then 
    local success, err, forcible = mapping:delete(path)
    if success then
        ngx.say("deleted:", path)
        ngx.exit(200)
    else
        ngx.say("err: ", err)
        ngx.exit(507)
    end  
elseif method == "PUT" then 
    ngx.req.read_body()
    local target = ngx.req.get_body_data()
    if string.match(target,"^https?://[%w%-]+%..+") then
        local success, err = mapping:safe_add(path, target)
        if success then
            ngx.say("ok")
            ngx.exit(200)
        else
            ngx.say("err: ", err, "<br/>") 
            ngx.say(path, "==>", mapping:get(path), "<br/>")
            ngx.exit(409)
        end
    else
        ngx.say("Not a valid url: ", target)
        ngx.exit(400)
    end
else
    ngx.exit(405)
end
