servers=[
    {
        :hostname => "master",
        :ip => "10.69.0.2",
        :box => "Dougs71/CentOS-7.6.1810-Minimal",
        :memory => 2048,
        :cpus => 2,
        :role => "master"
    },
    {
        :hostname => "node1",
        :ip => "10.69.0.3",
        :box => "Dougs71/CentOS-7.6.1810-Minimal",
        :memory => 2048,
        :cpus => 2,
        :role => "node"
    },
    {
        :hostname => "node2",
        :ip => "10.69.0.4",
        :box => "Dougs71/CentOS-7.6.1810-Minimal",
        :memory => 2048,
        :cpus => 2,
        :role => "node",
    }
]

Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.box_check_update = false
  config.vm.box = "Dougs71/CentOS-7.6.1810-Minimal"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.ssh.insert_key = false
  config.ssh.private_key_path = ['provision/vagrant']

  config.vm.define "control" do |control|
    control.vm.hostname = "control"

    config.vm.provider "virtualbox" do |vb|
      vb.name = "control"
      vb.memory = "512"
      vb.cpus = "1"
    end

    control.vm.network "private_network", ip: "10.69.0.1"
    control.vm.provision "shell", path: "provision/control.sh", privileged: false
  end

  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]

      node.vm.provider "virtualbox" do |vb|
        vb.memory = machine[:memory]
        vb.cpus = machine[:cpus]
        vb.name = machine[:hostname]
      end

      case machine[:role]
      when "master"
        node.vm.provision "shell", path: "provision/master.sh", privileged: false
      when "node"
        node.vm.provision "shell", path: "provision/node.sh", privileged: false
      end
    end
  end

  config.vm.provision "shell", path: "provision/common.sh", privileged: false
end