local function close_db(db)
  if not db then
    return
  end
  db:close()
end

local mysql = require("resty.mysql")

local db, err = mysql:new()
if not db then
  ngx.say("Error occured when new mysql: ", err)
  return
end

db:set_timeout(1000)

local props = {
  host = "192.168.0.23",
  port = 3306,
  database = "test",
  user = "root",
  password = "123456"
}

local res, err, errno, sqlstate = db:connect(props)

if not res then
  ngx.say("Error occured while connecting: ", err, ", errno: ", errno, ", sqlstate: ", sqlstate)
  return close_db(db)
end




}
