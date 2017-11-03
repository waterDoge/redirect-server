local mappings = ngx.shared.redirect_mapping

for k, v in pairs(mappings:get_keys(0)) do
    ngx.say(v, " --> ", mappings:get(v), "<br/>")
end
ngx.exit(200) 
