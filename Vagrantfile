Vagrant::Config.run do |config|
  config.vm.box = "squeeze64"
  config.vm.customize do |vm| 
    vm.memory_size = 512
  end
  # config.vm.boot_mode = :gui
  # config.vm.network "33.33.33.10"
  

  Vagrant::Config.run do |config|
    config.vm.network("33.33.33.10")
  end


  #config.vm.forward_port "http", 9292, 9292
  #config.vm.forward_port "SIP",  5060, 5060, :protocol => :udp
  #(10000..10002).each do |port|
  #  config.vm.forward_port "RTP-#{port}",  port, port, :protocol => :udp
  #end


  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "java"
    chef.add_recipe "sipp"
    chef.add_recipe "asterisk"
    chef.add_recipe "rvm"
    chef.json.merge!( 
      :rvm => {
        # replace this with the correct URL when the issue with RVM is solved
        :system_installer_url => "https://github.com/wayneeseguin/rvm/raw/1.3.0/contrib/install-system-wide",
        :version => "1.3.0",
        :default_ruby => "system",
        :rubies => ["jruby-1.6.0"],
        :global_gems => [
              { :name => "bundler" },
              { :name => "mizuno" },
        ],
      },
      :java => {
        :install_flavor => "sun"
      } 
    )
  end
end
