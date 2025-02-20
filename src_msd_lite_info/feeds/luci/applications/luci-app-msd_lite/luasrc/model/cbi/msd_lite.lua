require("luci.sys")

m = Map("msd_lite")
m.title = translate("msd_lite")
m.description = translate("msd_lite is a UDP-to-HTTP multicast traffic relay daemon, here you can configure the settings.")

m:section(SimpleSection).template  = "msd_lite/msdlite_status"

s = m:section(TypedSection, "msd_lite")
s.addremove = false
s.anonymous = false

enable=s:option(Flag, "enable", translate("Enabled"))
enable.rmempty = false

port=s:option(Value, "port", translate("Port"))
port.datatype = "port"
port.default = "1234"
port.rmempty = false

source=s:option(Value, "source", translate("Source Interface"))
source.datatype = "network"
source.default = "wan.1234"
source.rmempty = false

threads=s:option(Value, "threads", translate("Max CPU threads"))
threads.datatype = "range(0, 8)"
threads.default = "0"
threads.rmempty = false
threads.description = translate("0 = auto")

log_file=s:option(Value, "log_file", translate("Log file"))
log_file.datatype = "string"
log_file.default = "/dev/null"
log_file.rmempty = false

local apply= luci.http.formvalue("cbi.apply")
if apply then
		io.popen("/etc/init.d/msd_lite restart")
end

return m
