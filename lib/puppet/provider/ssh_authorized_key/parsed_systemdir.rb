Puppet::Type.type(:ssh_authorized_key).provide(
  :parsed_systemdir,
  :parent => :parsed,
  :default_target => ''
) do
  desc "Parse and generate authorized_keys files for SSH (in `/etc/ssh/authorized_keys/` directory)"

  confine :exists => '/etc/ssh/authorized_keys'

  # Is there any cleaner way to inherit from :parsed? Without those text_line and record_line calls...
  text_line :comment, :match => /^#/
  text_line :blank, :match => /^\s+/

  record_line :parsed_systemdir,
    :fields   => %w{options type key name},
    :optional => %w{options},
    :rts => /^\s+/,
    :match    => /^(?:(.+) )?(ssh-dss|ssh-rsa|ecdsa-sha2-nistp256|ecdsa-sha2-nistp384|ecdsa-sha2-nistp521) ([^ ]+) ?(.*)$/,
    :post_parse => proc { |h|
      h[:name] = "" if h[:name] == :absent
      h[:options] ||= [:absent]
      h[:options] = Puppet::Type::Ssh_authorized_key::ProviderParsed.parse_options(h[:options]) if h[:options].is_a? String
    },
    :pre_gen => proc { |h|
      h[:options] = [] if h[:options].include?(:absent)
      h[:options] = h[:options].join(',')
    }

  record_line :key_v1,
    :fields   => %w{options bits exponent modulus name},
    :optional => %w{options},
    :rts      => /^\s+/,
    :match    => /^(?:(.+) )?(\d+) (\d+) (\d+)(?: (.+))?$/

  # Hijack code execution to monkey patch out type object
  def self.prefetch(record)
    record.each do |k,rec|

      # Set new target parameter in /etc/ssh/authorized_keys/ directory
      class <<rec.parameters[:target]
        def should
          return super if defined?(@should) and @should[0] != :absent

          return nil unless user = resource[:user]

          return "/etc/ssh/authorized_keys/#{user}"
        end
      end

    end
    super
  end

  def file_gid
    raise Puppet::Error, "User '#{@resource.should(:user)}' does not exist" unless uid = Puppet::Util.uid(@resource.should(:user))
    Etc.getpwnam(@resource.should(:user)).gid
  end

  def flush
    user   = @resource.should(:user)
    target = @resource.should(:target)

    if target =~ Regexp.new('^/etc/ssh/authorized_keys/') then
      # Create target file with proper permissions and group
      # Skip superclass flush and instead call one from grandparent class
      raise Puppet::Error, "Cannot write SSH authorized keys without user"    unless user
      raise Puppet::Error, "User '#{user}' does not exist" unless uid = Puppet::Util.uid(user)

      f = File.new(target, mode="w+", 0640)
      f.chown(0, file_gid)
      f.close

      self.class.superclass.superclass.instance_method(:flush).bind(self).call
    else
      super
    end
  end

end

