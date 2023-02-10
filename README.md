# rs-deploy

This deploys Retrospring to a server using the power of Ansible.

## Usage

1. Clone the `rs_secrets` repo somewhere

2. Create a inventory file like this:
```ini
[retrospring]
retrospring-host ansible_user=root

[retrospringnew:children]
retrospringnew_web
retrospringnew_sidekiq

[retrospringnew_web]
retrospring-web-[001:002].int.do.infra.retrospring.net

[retrospringnew_sidekiq]
retrospring-sidekiq-001.int.do.infra.retrospring.net

[retrospringnew:vars]
ansible_user=justask
ansible_ssh_common_args='-A -o ProxyCommand="ssh -W %h:%p -q justask@retrospring-bastion.do.infra.retrospring.net"'

[retrospringnew_web:vars]
rs_role=web

[retrospringnew_sidekiq:vars]
rs_role=sidekiq
```

3. Run the playbook (adapt `rs_secrets_path` to your needs, and make sure a
container image for your version already exists):
```
ansible-playbook ./default.yml -i inventory -e rs_secrets_path=../rs_secrets -e rs_version=2023.XXXX.X
```
