local var = ngx.var
ngx.say("ngx.var.a : ", var.a, "<br/>")
ngx.say("ngx.var.b : ", var.b, "<br/>")
ngx.say("ngx.var[2] : ", var[2], "<br/>")
ngx.var.b = 2;
ngx.say("<br/>")

local function ngx_say_pairs(p) 
    for k, v in pairs(p) do
        if type(v) == "table" then
            ngx.say(k, " : ", table.concat(v, ", "), "<br/>");
        else
            ngx.say(k, " : ", v, "<br/>")
        end
    end
end
local headers = ngx.req.get_headers()
ngx.say("headers begin","<br/>")
ngx.say("Host : ", headers["Host"], "<br/>")
ngx.say("user-agent : ", headers.user_agent, "<br/>")
--[=[for k,v in pairs(headers) do
    if type(v) == "table" then
        ngx.say(k, " : ", table.concat(v, ", "), "<br/>");
    else
        ngx.say(k, " : ", v, "<br/>")
    end
end]=]
ngx_say_pairs(headers)
ngx.say("headers end<br/><br/>")

ngx.say("args<br/>");
local uri_args = ngx.req.get_uri_args()
--[=[for k, v in pairs(uri_args) do
    if type(v) == "table" then
        ngx,say(k .. " : ", table.concat(v, ", "), "<br/>");
]=]
ngx_say_pairs(uri_args)
ngx.say("uri args end <br/><br/>post args begin <br/>")
ngx.req.read_body()
ngx_say_pairs(ngx.req.get_post_args())
ngx.say("post args end<br/><br/>")
ngx.say("http version : ", ngx.req.http_version(), "<br/>")
ngx.say("request method : ", ngx.req.get_method(), "<br/>")
ngx.say("raw header : ", ngx.req.raw_header(), "<br/>")
ngx.say("body : ", ngx.req.get_body_data(), "<br/>")

