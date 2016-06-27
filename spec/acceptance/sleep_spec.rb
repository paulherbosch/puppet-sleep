require 'spec_helper_acceptance'

describe 'sleep' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include sleep 
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    sleep { 5: }

    sleep { "sleep until /etc/passwd exists":
      bedtime       => 5,
      wakeupfor     => 'test -f /etc/passwd',
      dozetime      => '1',
      failontimeout => true,
    }

    # describe port(22) do
    #   it { is_expected.to be_listening }
    # end

    # describe service('sshd') do
    #   it { is_expected.to be_enabled }
    #   it { is_expected.to be_running }
    # end
  end

end
