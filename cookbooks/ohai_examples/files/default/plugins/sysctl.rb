Ohai.plugin(:Sysctl) do
  require 'mixlib/shellout'
  provides "sysctl" #node attibute that we key off of. Path to attribute

  collect_data(:default) do
    sysctl Mash.new
    #sysctl[:settings] = {:kernel => []. :vm => [], :fs => [], :dev => [], :net => [], :abi => [], :crypto => []}
    setting = shell_out("sysctl -A")
    setting.stdout.each_line do |line|
      fullkey, value = line.split("=").map {|i| i.strip} #conversion process
      sysctl[fullkey] = value
    end
  end
end
