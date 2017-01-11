# Installation

1. Install ansible 2.0+
   http://docs.ansible.com/ansible/intro_installation.html

2. Install debops tools
   https://docs.debops.org/en/latest/debops/docs/installation.html

3. Install dependant roles
   ```
   ansible-galaxy install -r requirements.yml
   ```

4. **Important**: Fix role bugs, see *Known issues*

5. Setup hosts in `inventory/hosts`, as well as `group_vars` and `host_vars`. If you want to test this playbook on docker, see `docker/*` for example configuration.

6. Run playbook
   ```
   # Create docker containers if you are going to run this playbook on docker
   $ docker-compose -f docker/docker-compose-test.yml up -d

   # Run ansible playbook
   $ ansible-playbook site.yml
   ```

# Variables
- `inventory/hosts`
    - Manage hosts here, don't change the group name
- `inventory/group_vars/*`
    - `app.yml` - Defines application variables.
    - `databases.yml` - Overwrites variables from `roles/debops.mariadb_server` for `databases` group.
    - `database_clients.yml` - Overwrites variables from `roles/debops.mariadb` for `database_clients` group.
    - `web_servers.yml` - Overwrites variables from `roles/debops.php` and `roles/debops.nginx` for `web_servers` group
- `inventory/host_vars/*`
    - Specify host specfic variables.

# File locations
- Document root of the virtual host
    - `{{ nginx_www }}/sites/{{ nginx_server_shop['name']['0'] }}/public` which is equivalent to `/srv/www/sites/shop/public`.
      You may want to configure variables in `inventory/group_vars/web_servers.yml` as your need.
- MySQL passwords
    - Stored in local directory `secret/`

# Known issues

debops.php
- https://github.com/debops/ansible-php/issues/22

  Fix: remove `--no-generate ` from `roles/debops.php/files/script/php-filter-packages.sh`

- https://github.com/debops/ansible-php/issues/24

  Have been fixed in `site.yml`

debops.mariadb_server
- https://github.com/debops/ansible-mariadb_server/issues/38

  Fix: Replace `mariadb_server_backup` with `mariadb_server__backup`

- https://github.com/debops/ansible-mariadb_server/issues/39

  If you got the same issue, try replace `roles/debops.mariadb_server/tasks/secure_installation.yml` with this one:

  https://github.com/beata/ansible-mariadb_server/blob/feature/fix-change-root-pwd/tasks/secure_installation.yml
