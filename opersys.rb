Facter.add('os_brand') do
        setcode do
                Facter::Util::Resolution.exec('cat /etc/system-release-cpe | cut -d: -f3')
        end
end

Facter.add('os_product') do
        setcode do
                Facter::Util::Resolution.exec('cat /etc/system-release-cpe | cut -d: -f7')
        end
end

Facter.add('os_revision') do
        setcode do
                Facter::Util::Resolution.exec('cat /etc/system-release-cpe | cut -d: -f5 | cut -b1')
        end
end

Facter.add('os_role') do
        setcode do

            #!/usr/bin/ruby


            # hos = "marsvf4g1vdi799"  # <-- can be used to test CASE Statement
            # hos = system ( "stty -echo;/bin/hostname; stty echo" ) # <-- Should be used at work; set variable to response of system call 'hostname'
            hos = %x[/bin/hostname]





            case hos
               when /lfs/i                            # <-- Compare hostname against string match of "lfs" case-insensitive
                  #  puts "Must be an LFS server"
                  os_role = "LFS"                      # <-- Set os_role to value of "LFS"
               when /rpa/i, /qpa/i                  # <-- Compare hostname against string matches of "rpa" or "qpa" case-insensitive
                  #  puts "Must be an IPA server."
                  os_role = "IPA"                    # <-- Set os_role to value of "IPA"
               when /cap/i                                # <-- Compare hostname against string match of "cap" case-insensitive
                  #  puts "Must be a CAPsule."
                  os_role = "CAP"                  # <-- Set os_role to value of "CAP"
               when /glv/i, /vdi/i, /g1v/i, /vda/i      # <-- Compare hostname against string matches of "glv", "vdi", "g1v" or "vda"
                  #  puts "Must be a VDI server."
                  os_role = "VDA"                        # <-- Set os_role to value of "VDI"
               else                                           # <-- Nothing matched above, so do this instead
                  #  puts "Perhaps a desktop or workstation machine."
                  os_role = "DTP"                          # <-- Set os_role to value of "not_vda"
            end
            #                                                                                                                                                                                                                                
            #puts "#{os_role}"                   # <-- Print, with embedded newline, the value of os_role

        end  # end setcode
end
