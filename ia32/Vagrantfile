Vagrant.configure(2) do |config|
  config.vm.box = 'hashicorp/precise32'
  config.vm.provision :shell, privileged: false, path: 'provision'
  config.vm.provider "virtualbox" do |v|
    v.customize [
      'modifyvm', :id,
      '--cpus',   1,
      '--memory', 128,
    ]
  end
end
