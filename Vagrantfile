Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-16.04"
    config.vm.hostname = "adempiere-devbox-390"

    config.ssh.insert_key = true
    config.vm.synced_folder '.', '/vagrant', disabled: true

    config.vm.provider :virtualbox do |vb|
        # Display the VirtualBox GUI when booting the machine
        vb.gui = true

        # Set the VirtualBox VM name equal to the hostname
        # vb.name = config.vm.hostname.to_s

        # Use VBoxManage to customize the VM. For example to change memory:
        vb.customize ["modifyvm", :id, "--name", config.vm.hostname.to_s]
        vb.customize ["modifyvm", :id, "--memory", "8192"]
        vb.customize ["modifyvm", :id, "--vram", 128]
        vb.customize ["modifyvm", :id, "--cpus", 4]
        vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]

        # Disable Remote Desktop Server
        vb.customize ["modifyvm", :id, "--vrde", "off"]

        # If using an SSD on the machine running the VM, uncomment the below
        vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "0", "--nonrotational", "on"]
    end

    # Initial run script, executed as ROOT user
    config.vm.provision :shell, :path => "scripts/setup.sh"
end
