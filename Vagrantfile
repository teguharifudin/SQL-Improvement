# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "mysql-test"
  
  # Network configuration
  config.vm.network "private_network", ip: "192.168.33.10"
  
  # VM configuration
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "mysql-test"
  end
  
  # Sync folder
  config.vm.synced_folder "scripts/", "/vagrant/scripts"
  
  # Provision script
  config.vm.provision "shell", inline: <<-SHELL
    # Update system
    apt-get update
    apt-get upgrade -y
    
    # Install MySQL
    export DEBIAN_FRONTEND=noninteractive
    apt-get install -y mysql-server
    
    # Configure MySQL for external connections
    sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
    
    # Secure MySQL setup
    mysql -e "CREATE USER IF NOT EXISTS 'vagrant'@'%' IDENTIFIED BY 'vagrant';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%';"
    mysql -e "FLUSH PRIVILEGES;"
    
    # Create MySQL config file for vagrant user
    cat > /home/vagrant/.my.cnf << EOF
[mysql]
user=vagrant
password=vagrant

[client]
user=vagrant
password=vagrant
EOF
    
    # Set proper ownership and permissions
    chown vagrant:vagrant /home/vagrant/.my.cnf
    chmod 600 /home/vagrant/.my.cnf
    
    # Restart MySQL
    systemctl restart mysql
  SHELL
end
