Facter.add("dns_ip_6") do
  setcode do
    os = Facter.value('kernel')
    case os
    when /Linux/
      hostname = `hostname -f`
    else
      hostname = `hostname`
    end
    host_output = `host #{hostname}`
    v6_entries = []
    host_output.each do |line|
      v6_entries << line if line =~ /.*IPv6.*/
    end
    v6_addrs = []
    v6_entries.each do |entry|
      v6_addrs << entry.split(" ")[-1]
    end
    v6_addrs
  end
end