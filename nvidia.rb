Facter.add('mas_nvidia_models') do
        setcode do
                Facter::Util::Resolution.exec('lspci | grep VGA | cut -d: -f3; echo')
        end
end


Facter.add('mas_nvidia_driver_version') do
                setcode do
                        #!/usr/bin/ruby
                                mas_nvidia_driver_version = %x[modinfo nvidia | egrep '^version:' | cut -d: -f2 | tr -d ' ']
                #                puts "#{nvidia_driver_version}"                   # <-- Print, with embedded newline, the value of nvidia_driver_version
                end  # end setcode
end

Facter.add('mas_nvidia_installed') do
                setcode do
                        #!/usr/bin/ruby
                          if ! File.exists?('/usr/lib64/libGLX_nvidia.so.0')
                                    mas_nvidia_installed = "VOID"
                          elsif  system('/usr/bin/rpm -q --quiet nvidia-x11-drv')
                                    mas_nvidia_installed = "RPM"
                          else
                                    mas_nvidia_installed = "RUN"
                          end
                end  # end setcode
end

