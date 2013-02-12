require 'spec_helper'
# Ubuntu specific tests
describe 'ssh::client' do
    let (:node){ 'localhost.localdomain' }
    let (:facts) {{  :osfamily => 'debian', :operatingsystem => 'ubuntu' }}

    ### Tests specific to ubuntu/debian
    describe 'it should include ssh::client' do
        it { should include_class('ssh::client') }
    end
    describe 'it should include ssh::params' do
        it { should include_class('ssh::params') }
    end
    describe 'it should contain package' do
        it { should contain_package('openssh-client').with_ensure('latest') }
    end
    describe 'it should make the /etc/ssh directory' do
        it { should contain_file('/etc/ssh/ssh_known_hosts') }
    end
    #describe 'it should have resource that purges' do
    #    it { should contain_sshkey('sshkey').with( 'purge' => 'true') }
    #end
end
