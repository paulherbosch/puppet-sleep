Puppet::Type.newtype(:sleep) do

  @doc = <<-EOS
    This type provides the capability to manage sleep
  EOS

  newparam(:name) do
    isnamevar
    desc "how long to sleep for"
  end

  newproperty(:bedtime) do
    desc "how long to sleep for"
    munge do |snore|
      Integer(snore)
    end
    validate do |zzzz|
      fail("sleepy time isn't an integer") unless zzzz =~ /^\d+$/
    end
    defaultto { @resource[:name] }

    def insync?(is)
      false
    end
    def retrieve
      :absent
    end
  end

  newparam(:wakeupfor) do
    desc "what to wake up for - a shell test for example"
    defaultto { :false }
  end

  newparam(:dozetime) do
    desc "where wakeupfor set, optional parameter to determine how often to run the test"
    defaultto { 10 }
  end

end
