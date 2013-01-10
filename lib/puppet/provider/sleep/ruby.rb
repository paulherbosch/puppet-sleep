
require 'puppet/util'
require 'puppet/util/suidmanager'
Puppet::Type.type(:sleep).provide(:ruby) do

  confine :feature => :posix

  def bedtime=(snoretime = resource[:bedtime])
    check = false
    if resource[:wakeupfor] == :false
      sleep(snoretime)
    else
      tested = false
      until tested
#        tested = super(['/bin/sh', '-c', resource[:wakeupfor]], check)
        sleep(resource[:dozetime])
        command = "/bin/sh -c '#{resource[:wakeupfor]}'"
        output = Puppet::Util.execute(command, :failonfail => false, :combine => true) #, :uid => new_uid, :gid => new_gid)
        debug("#{$CHILD_STATUS} #{output}")
        tested = true if $CHILD_STATUS == 0
      end
    end
    
  end

end
