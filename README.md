# rs-deploy

This deploys Retrospring to a server using the power of Ansible.

## Usage

1. Clone the `rs_secrets` repo somewhere

2. Run the playbook (adapt `rs_secrets_path` to your needs, and make sure a
container image for your version already exists):
```
ansible-playbook ./default.yml -i inventory -e rs_secrets_path=../rs_secrets -e rs_version=2023.XXXX.X
```
