ngx.header.a = "1"
ngx.header.b = {"2", "3"}
ngx.say("a" .. "b", "<br/>")
ngx.print("c", "d", "<br/>")
return ngx.exit(200)
