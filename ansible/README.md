## Setup

```bash
python3 -m venv venv
source venv/bin/activate
python -m pip install -r requirements.txt
ansible-galaxy install -r requirements.yml
```

## Deploy

Firstly, use the bootstrap to set up an ansible user on the target:

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
