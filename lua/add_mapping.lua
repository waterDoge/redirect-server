local mappings = ngx.shared.redirect_mapping
ngx.req.read_body()
local args = ngx.req.get_post_args()
local k = ngx.req.var[0]
local v = args['v']
ngx.say(k,v)
if k and v and mappings:safe_add(k,v) then
    ngx.exit(200)
else
    ngx.say("already exists: ", mappings:get(k))
    ngx.exit(400)
end
ngx.exit(200)
