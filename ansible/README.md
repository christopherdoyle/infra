## Setup

```bash
python3 -m venv venv
source venv/bin/activate
python -m pip install -r requirements.txt
ansible-galaxy install -r requirements.yml
```

## Deploy

Firstly, create a hosts file

```text
[all]
10.0.0.1
```

Then use the bootstrap to set up an ansible user on the target:

```bash
cd bootstrap/
ssh-keygen -t ed25519 -C "ansible" -f ./files/ansible.ed25519.key
ansible-playbook bootstrap.yml -u root
```

Then return to root and run the setup

```bash
cd ..
ansible-playbook setup-server.yml
```

## Configuration on new client

If you have a server that was previously bootstrapped and you are configuring on a new server, just create a new SSH key locally (as above), and manually add the public key to `/home/ansible/.ssh/authorized_keys`.

Create `/ansible/vars/private.yml` with contents:

```text
hostname: example.com
```
