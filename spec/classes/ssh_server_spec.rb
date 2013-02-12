require 'spec_helper'
# Ubuntu specific tests
describe 'ssh::server' do
    let (:node){ 'localhost.localdomain' }
    let (:facts) {{  :osfamily => 'Debian', :operatingsystem => 'ubuntu' }}

    ### Tests specific to ubuntu/debian
    describe 'it should include ssh::server' do
        it { should include_class('ssh::server') }
    end
    describe 'it should include ssh::params' do
        it { should include_class('ssh::params') }
    end
    describe 'it should contain package' do
        it { should contain_package('openssh-server').with_ensure('latest') }
    end
    describe 'it should make the /etc/ssh directory' do
        it { should contain_file('/etc/ssh/authorized_keys') }
    end
    describe 'it should have a service that starts at boot' do
        it { should contain_service('ssh').with('ensure' => 'running') }
    end
end

# Redhat specific tests
describe 'ssh::server' do
    let (:node){ 'localhost.localdomain' }
    let (:facts) {{  :operatingsystem => 'redhat' }}

    ### Tests specific to ubuntu/debian
    describe 'it should include ssh::server' do
        it { should include_class('ssh::server') }
    end
    describe 'it should include ssh::params' do
        it { should include_class('ssh::params') }
    end
    describe 'it should contain package' do
        it { should contain_package('openssh-server').with_ensure('latest') }
    end
    describe 'it should make the /etc/ssh directory' do
        it { should contain_file('/etc/ssh/authorized_keys') }
    end
    describe 'it should have a service that starts at boot' do
        it { should contain_service('sshd').with('ensure' => 'running') }
    end
end
