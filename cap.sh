#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

project_name=$1
project_path="./${project_name}"
ansible_cfg="${project_path}/ansible.cfg"
inventory_file="${project_path}/inventory.ini"
playbooks_dir="${project_path}/playbooks"
roles_dir="${project_path}/roles"
adhoc_script="${project_path}/adhoc.sh"

# Create project directory
mkdir -p "${project_path}"

# Create Ansible configuration file
cat <<EOF > "${ansible_cfg}"
# Ansible Configuration File for ${project_name}
# Replace the necessary values according to your setup

[defaults]
inventory = ./inventory.ini
roles_path = ./roles
EOF

# Create inventory file
cat <<EOF > "${inventory_file}"
# Ansible Inventory File for ${project_name}
# Add your server information here
# Example: target_server ansible_host=your_server_ip ansible_user=your_ssh_user

[target_server]
EOF

# Create playbooks directory
mkdir -p "${playbooks_dir}"

# Create example playbook
cat <<EOF > "${playbooks_dir}/example_playbook.yml"
---
- name: Example Playbook
  hosts: target_server
  tasks:
    - name: Print Hello
      debug:
        msg: "Hello, Ansible!"
EOF

# Create roles directory
mkdir -p "${roles_dir}"

# Initialize an example role
ansible-galaxy init "${roles_dir}/example_role"

# Create adhoc.sh script
cat <<EOF > "${adhoc_script}"
#!/bin/bash

# Ad-hoc command script for ${project_name}
# Customize and run ad-hoc commands as needed

# Example: Run a simple ping command
ansible target_server -m ping
EOF

# Make adhoc.sh executable
chmod +x "${adhoc_script}"

# Initialize Git repository
git init "${project_path}"
echo "*.retry" >> "${project_path}/.gitignore"
echo "*.log" >> "${project_path}/.gitignore"

echo "Ansible project '${project_name}' created successfully at '${project_path}'."
