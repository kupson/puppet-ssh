require 'spec_helper'

describe 'localhost.localdomain' do
    let (:node) { 'localhost.localdomain' }
    let (:facts) {{ :osfamily => 'debian', :operatingsystem => 'ubuntu' }}

    describe 'it should contain the dummy user' do
        it { should contain_user('thedummyuser') }
    end

    describe 'it should make the /etc/ssh/ssh_known_hosts file' do
        it { should contain_file('/etc/ssh/ssh_known_hosts') }
    end

    describe 'it should make the /etc/ssh directory' do
        it { should contain_file('/etc/ssh/authorized_keys') }
    end

    describe 'it should make the /etc/ssh/authorized_keys directory' do
        it { should contain_file('/etc/ssh/authorized_keys') }
    end

    describe 'it should contain an authorized_key_file for the dummy user' do
        it { should contain_ssh_authorized_key('thedummyuser@localhost.localdomain') }
    end

    describe 'it should contain an authorized_key_file for root' do
        it { should contain_ssh_authorized_key('root@localhost.localdomain') }
    end
end
