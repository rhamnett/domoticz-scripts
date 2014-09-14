logging = true
d = otherdevices
device = ""
for i, v in pairs(devicechanged) do
  if (#device == 0 or #i < #device) then device = i end
end
if (logging) then print("Triggered by " .. device .. " now " .. d[device]) end


t1 = os.time()
s = otherdevices_lastupdate['Garage door sensor']
-- returns a date time like 2013-07-11 17:23:12

year = string.sub(s, 1, 4)
month = string.sub(s, 6, 7)
day = string.sub(s, 9, 10)
hour = string.sub(s, 12, 13)
minutes = string.sub(s, 15, 16)
seconds = string.sub(s, 18, 19)

commandArray = {}

t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
difference = (os.difftime (t1, t2))
if (otherdevices['Garage door sensor'] == 'Open' and difference > 600 and difference < 630) then
   commandArray['SendNotification']='Door alert#The garage door has been open for more than 10 minutes!'
end 

return commandArray
