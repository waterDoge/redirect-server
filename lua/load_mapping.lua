local function close_db(db)
  if not db then
    return
  end
  db:close()
end
local mapping = ngx.shared.redirect_mapping
local mysql = require "resty.mysql"

local db, err = mysql:new()
if not db then
  ngx.log(ngx.ERR, "Error occured when new mysql: ", err)
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
  ngx.log(ngx.ERR, "Error occured while connecting: ", err, ", errno: ", errno, ", sqlstate: ", sqlstate)
  return close_db(db)
end
-- To avoid SQLi, use ngx.quote_sql_str(ch_param)
local select_sql = "select k, v from url_mapping"
local res, err, errno, sqlstate = db:qurey(select_sql)
if not res then
    ngx.log(ngx.ERR, "Error occured while connecting: ", err, ", errno: ", errno, ", sqlstate: ", sqlstate)
    return close_db(db)
end

for i, row in ipairs(res) do
  mapping:safe_add(row.k, row.v)
end


