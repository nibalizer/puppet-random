#
# This fact prints a comma separated list of mdraid devices
#
# It requires thes raidtype fact from the puppet website
#
# (c) 2013 Spencer Krum 
# Released under Apache2
Facter.add("raid_devices") do
  confine :kernel => :linux
  confine :raidtype => :software
  setcode do
    lines_of_raid = []
    raid_devices = []
    txt = File.read("/proc/mdstat")
    txt.each_line do |line|
      lines_of_raid << line if line.match( /active/ )
    end
    lines_of_raid.each do |line|
      line =~ /(md\d+)\s: active/
      raid_devices +=  $~.captures
    end
    raid_devices.join(",")
  end 
end

