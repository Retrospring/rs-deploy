# rs-deploy

This deploys Retrospring to a server using the power of Ansible.

## Usage

1. Create a inventory file like this:
```toml
[retrospring]
retrospring-host ansible_user=root
```
2. Run the playbook:
```
ansible-playbook ./default.yml -i inventory -e rs_version=2023.XXXX.X
```
