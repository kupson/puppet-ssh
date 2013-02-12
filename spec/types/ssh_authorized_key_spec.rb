require 'puppet'                                                                                                                                                                                                                               
require 'puppet/type/ssh_authorized_key'
describe Puppet::Type.type(:ssh_authorized_key) do 

    let(:ssh_resource){ Puppet::Type::Ssh_authorized_key.new({   
            :key => 'AAAAAAAAAAAAA',
            :type => 'rsa',
            :name => 'the key comment',
            :user => 'thedummyuser',
            :provider => 'parsed_systemdir',
            }) 
    }  
    let(:provider) {
        Puppet::Type.type(:ssh_authorized_key).provider(:parsed_systemdir).new(ssh_resource)
    }  

    it 'moz_ssh_authorized_key should have correct name' do 
        ssh_resource[:name].should == 'the key comment'
    end

    it 'moz_ssh_authorized_key should have correct user' do 
        ssh_resource[:user].should == 'thedummyuser'
    end

    ### This is totally broken
    #it 'moz_ssh_authorized_key should have correct user' do 
    #    ssh_resource[:provider].should.contain_file('/etc/ssh/authorized_keys') == true
    #end
    

end
