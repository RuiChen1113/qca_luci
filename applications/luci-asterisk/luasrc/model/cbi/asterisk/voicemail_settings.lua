--[[
LuCI - Lua Configuration Interface

Copyright 2009 Jo-Philipp Wich <xm@subsignal.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

require "luci.sys.zoneinfo"


cbimap = Map("asterisk", "Voicemail - Common Settings")

voicegeneral = cbimap:section(TypedSection, "voicegeneral",
	"General Voicemail Options", "Common settings for all mailboxes are " ..
	"defined here. Most of them are optional. The storage format should " ..
	"never be changed once set.")

voicegeneral.anonymous = true
voicegeneral.addremove = false

format = voicegeneral:option(ListValue, "Storage format")
format:value("wav49")
format:value("gsm")
format:value("wav")

voicegeneral:option(Flag, "sendvoicemail", "Enable sending of emails")
voicegeneral:option(Flag, "attach", "Attach voice messages to emails")
voicegeneral:option(Value, "serveremail", "Used email sender address")
voicegeneral:option(Value, "emaildateformat", "Date format used in emails").optional = true
voicegeneral:option(Value, "maxlogins", "Max. failed login attempts").optional = true
voicegeneral:option(Value, "maxmsg", "Max. allowed messages per mailbox").optional = true
voicegeneral:option(Value, "minmessage", "Min. number of seconds for voicemail").optional = true
voicegeneral:option(Value, "maxmessage", "Max. number of seconds for voicemail").optional = true
voicegeneral:option(Value, "maxsilence", "Seconds of silence until stop recording").optional = true
voicegeneral:option(Value, "maxgreet", "Max. number of seconds for greetings").optional = true
voicegeneral:option(Value, "skipms", "Milliseconds to skip for rew./ff.").optional = true
voicegeneral:option(Value, "silencethreshold", "Threshold to detect silence").optional = true


voicezone = cbimap:section(TypedSection, "voicezone", "Time Zones",
	"Time zones define how dates and times are expressen when used in " ..
	"an voice mails. Refer to the asterisk manual for placeholder values.")

voicezone.addremove = true
voicezone.sectionhead = "Name"
voicezone.template = "cbi/tblsection"

tz = voicezone:option(ListValue, "zone", "Location")
for _, z in ipairs(luci.sys.zoneinfo.TZ) do tz:value(z[1]) end

voicezone:option(Value, "message", "Date Format")


return cbimap
