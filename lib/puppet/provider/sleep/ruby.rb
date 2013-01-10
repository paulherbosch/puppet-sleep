require 'puppet/util'
Puppet::Type.type(:sleep).provide(:ruby) do

  confine :feature => :posix

  def bedtime=(snoretime = resource[:bedtime])
    check = false
    if resource[:wakeupfor] == :false
      sleep(snoretime)
    else
      starttime = Time.now.to_i
      tested = false
      until tested
        sleep(resource[:dozetime])
        command = "/bin/sh -c '#{resource[:wakeupfor]}'"
        output = Puppet::Util.execute(command, :failonfail => false, :combine => true)
        debug("The test returned: #{$CHILD_STATUS} #{output}")
        tested = true if $CHILD_STATUS == 0
        debug("Tested is: #{tested}")
        tested = true if Time.now.to_i > ( starttime + snoretime ) and snoretime > 0
        debug("Tested is: #{tested} calculated from #{starttime + snoretime} vs #{Time.now.to_i}")
        debug("Been running for #{Time.now._to_i - starttime} seconds")
      end
    end
    
  end

end
