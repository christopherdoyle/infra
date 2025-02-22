# Ente Self-Hosted

## Configuration

Create a `museum.yaml` file in this directory based off of `museum-example.yaml` and fill this with you secrets (relevant ones).

## How to administrate

From the server:

```bash
sudo docker exec -it ente_cli /bin/sh
```

You should be entered into the ente_cli container, and you can now run:

```bash
./ente-cli
```

Initially, add a user to the CLI using the credentials of an account already created in the self-hosted instance.
For example:

```bash
/ # ./ente-cli account add
Enter app type (default: photos):
Use default app type: photos
Enter export directory: /data
Enter email address: xxx@example.com
Enter password:
Please wait authenticating...
Enter TOTP: 012345
Account added successfully
run `ente export` to initiate export of your account data$
```

Now use `./ente-cli account list` to get the account id of your account (you could also use SQL to look this up in the postgres container).
Add that account id to `museum.yaml` as an admin.
Then push the ansible config again, and get back into the admin cli.
The account added should be an admin, and you can update the limits:

```bash
/ # ./ente-cli admin update-subscription -u xxx@example.com --no-limit False
```
