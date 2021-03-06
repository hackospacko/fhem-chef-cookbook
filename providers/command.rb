#
#
# we talk to FHEM via telnet now instead of messing up the config file directly:

require 'net/telnet'

action :send do
  send(@new_resource.name)
end

def send (command)
  fhem = Net::Telnet.new('Host' => 'localhost', 'Port' => 7072) #, 'Prompt' => 'fhem> ')
  begin
    fhem.cmd("\n#{command}\n")
  rescue Timeout::Error => e
      Chef::Log.warn("Could not talk to FHEM process via telnet: #{e.message}")
  end
  # TODO: check for success?
  fhem.close
end
