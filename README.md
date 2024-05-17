# GamifyCoding™
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.11212164.svg)](https://doi.org/10.5281/zenodo.11212164) [![Project Status: Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](https://www.repostatus.org/badges/latest/inactive.svg)](https://www.repostatus.org/#inactive) [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A full-stack mobile-friendly web platform where users can solve C programming challenges to gain points and move up the leaderboard, competing with other players. Was created as part of an experiment that researched the impact of users having access to a global leaderboard vs. a more limited league-based one.

# How it works
Users are split into 2 groups:
- One where users can access a global leaderboard with scores of all other players in this "global" group.
- And one where users can only access a league-based leaderboard with the scores of other players in their league as well as the score thresholds to either get promoted or demoted to the next or previous league, respectively.

Only sign-ups with pre-authorized emails are allowed within the platform and admins can expand & modify this pre-authorized email list. This list includes information regarding the group that a user with a given email will be assigned to upon sign-up. After sign-up, a user's group cannot be changed.

Placement challenges to obtain an initial leaderboard position as well as normal daily-released challenges can be configured within the platform as an admin. Users have to first complete the placement challenges in order to have access to the normal daily-released ones and, by default, will be notified daily by email (@ 12PM) about all the challenges available for completion for a given day.

Each of these challenges can have 1 of 4 different types supported by the platform:

- Single Choice (select the single correct answer)
- Multiple Choice (select all correct answers)
- Connect The Blocks (select correct pairings between options in 2 groups)
- Code Analysis/Output (read through the C code presented in a read-only VSCode editor and answer the open questions, matched through admin-configured regular expressions for determining correctness)

Users who don't complete a normal daily-released challenge on a given day (by midnight) will have a "decay" mechanism applied resulting in them getting the lowest possible score for it. This operation occurs @ 1AM everyday and is not limited to just the previous day's challenges but all past challenges.

# Production Deployment
To deploy this platform in a production environment ready for user onboarding, follow these steps:

1. Obtain a VPS server instance with a static IPv4 address running the Ubuntu 22.04 LTS OS. Ensure that outbound traffic on port 25 is permitted for correct email functionality.
2. Register a domain (refered to further as <domain_name>) to be used for the platform.
3. Add the following DNS records for the domain (TTL can be higher in production or lower in development, the 900 seconds provided value is just an example):
    - A Record:
    Name: <domain_name> (or "@" depending on DNS provider)
    Value: <VPS_server_ipv4_address>
    TTL: 900 seconds
    - A Record:
    Name: socket.<domain_name>
    Value: <VPS_server_ipv4_address>
    TTL: 900 seconds
    - A Record:
    Name: postgres.<domain_name>
    Value: <VPS_server_ipv4_address>
    TTL: 900 seconds
    - A Record:
    Name: mongo.<domain_name>
    Value: <VPS_server_ipv4_address>
    TTL: 900 seconds
    - CNAME Record:
    Name: www
    Value: <domain_name>
    TTL: 900 seconds
    - A Record:
    Name: mail.<domain_name>
    Value: <VPS_server_ipv4_address>
    TTL: 900 seconds
    - MX Record:
    Name: <domain_name> (or "@" depending on DNS provider)
    Priority: 0
    Value: mail.<domain_name>
    TTL: 900 seconds
    - Records to increase trust-factor of mail server (lower probability of rejected outbound emails):
        - TXT Record (SPF Record):
        Value: v=spf1 ip4:<VPS_server_ipv4_address> -all
        - TXT Record (DKIM Record):
        Name: <Generate_on_the_mail_server_in_later_step (details: https://poste.io/doc/configuring-dns)>
        Value: <Generate_on_the_mail_server_in_later_step (details: https://poste.io/doc/configuring-dns)>
        - TXT Record (DMARC Record):
        Name: _dmarc
        Value: v=DMARC1; p=none; rua=mailto:admin@<domain_name>
4. Create a Sentry.io account and a new organization named "gamifycoding" for error reporting in production:
    - Within the organization create 2 new projects:
        - One named "rails-backend" with RAILS as the platform.
        - Another named "realtime-backend" with EXPRESS as the platform.
    For both projects, navigate to settings and save the DSN Client Keys (will be used in step 8).
5. Install VSCode on your local machine if not already installed.
6. If your local machine is running Windows OS, install WSL so that subsequent operations can be executed in a UNIX-based environment.
7. Open VSCode with a valid SSH-agent & SSH-key config (and with WSL if on Windows: [GUIDE](https://code.visualstudio.com/docs/remote/wsl#_opening-a-terminal-in-wsl)), open the terminal and do the following:
    - Install Ruby version 3.1.2 and Bundler if not already installed.
    - Navigate to the desired location for cloning the project:
    ```bash
    cd <path_to_top_level_directory>
    ```
    - Clone this Git mono-repo including the backend submodules:
    ```bash
    # HTTPS
    git clone --recurse-submodules https://github.com/uos-darwin23-gamify/gamify-coding.git
    # SSH
    git clone --recurse-submodules git@github.com:uos-darwin23-gamify/gamify-coding.git
    ```
    - Create a master.key for symmetric encryption/decryption of credentials:
    ```bash
    cd gamify-coding/rails-backend/config
    touch master.key
    nano master.key
    # Enter a random sequence of alpha-numeric characters (the longer the better) - Save this value, will be used in another step (abbr. <master_key>)>
    # And save (Ctrl+X -> Y -> Enter)
    ```
    - Install Gems from Gemfile
    ```bash
    bundle
    ```
    - Set rails-backend credentials:
    ```bash
    # Remove existing credentials
    rm credentials.yml.enc

    # And create new ones
    EDITOR="code --wait" rails credentials:edit

    # A new tab in VSCode should open, in this tab overwrite the existing content with the following:
    secret_key_base: <random sequence of alpha-numeric characters (the longer the better)>
    devise_jwt_secret_key: <random sequence of alpha-numeric characters (the longer the better)>
    socket_server_api_key: <random sequence of alpha-numeric characters (the longer the better) - Save this value, will be used in the next step (<socket_server_api_key>)>

    # Save the new file (e.g. Ctrl+S) and close the tab - the terminal should be again free after this operation
    ```
    - Set realtime-backend credentials:
        - Open the file *gamify-coding/realtime-backend/ecosystem.config.js* in VSCode and replace <socket_server_api_key> with the value from the previous step and save (this key is used for authenticated communication between the 2 backends):
            ```bash
            SOCKET_SERVER_API_KEY: <socket_server_api_key>
            ```
8. SSH into the VPS server as a user with root-level access (typically "root") and run these commands one by one:
    - Declare SWAP memory:
        - Check how much memory is currently available (>= 4GB RAM+SWAP is recommended for optimal platform performance):
            ```bash
            free -h
            ```
        - Check current available disk space:
            ```bash
            df -h
            ```
        - And then (example with extra 2GB of SWAP space to be allocated - adjust according to the above recommendation):
            ```bash
            sudo fallocate -l 2G /swapfile
            sudo chmod 600 /swapfile
            sudo mkswap /swapfile
            sudo swapon /swapfile
            ```
        - Make the SWAP allocation persistent across reboots:
            ```bash
            sudo nano /etc/fstab
            # Add this line at the bottom:
            /swapfile none swap sw 0 0
            # And save (Ctrl+X -> Y -> Enter)
            ```
        - Verify correct SWAP allocation:
            ```bash
            swapon --show
            df -h
            free -h
            ```
    - Install Dokku (a container management system that auto-builds the backends based on the Dockerfiles):
        ```bash
        wget -NP . https://dokku.com/install/v0.32.3/bootstrap.sh
        sudo DOKKU_TAG=v0.32.3 bash bootstrap.sh
        sudo reboot now
        (SSH connection should now be closed)
        ```
    - After successful VPS reboot (usually takes a while) SSH back into the server as a root-level user and add a public SSH key to Dokku to be used for deployments:
        ```bash
        # Verify that the intended <username> is not already taken:
        dokku ssh-keys:list
        # Check if <username> is not in the list under the NAME parameter, then run:
        echo "<public_ssh_key_for_deployment>" | dokku ssh-keys:add <username>

        # For example:
        echo "ssh-ed25519 AAAAC3Nza... user@DESKTOP" | dokku ssh-keys:add admin
        ```
    - Create Dokku apps on server:
        ```bash
        dokku apps:create rails-backend
        dokku apps:create realtime-backend
        dokku apps:create postgres-admin
        dokku apps:create mongo-admin
        ```
    - Clear global domain:
        ```bash
        dokku domains:clear-global
        ```
    - Set domains & sub-domains:
        ```bash
        dokku domains:set rails-backend <domain_name> www.<domain_name>
        dokku domains:set realtime-backend socket.<domain_name>
        dokku domains:set postgres-admin postgres.<domain_name>
        dokku domains:set mongo-admin mongo.<domain_name>
        ```
    - Set port mappings:
        ```bash
        dokku ports:set rails-backend http:80:3000
        dokku ports:set realtime-backend http:80:4000
        dokku ports:set postgres-admin http:80:80
        dokku ports:set mongo-admin http:80:8081
        ```
    - Set environment variables (uses values from previous steps):
        ```bash
        dokku config:set rails-backend RAILS_LOG_LEVEL=warn RAILS_MASTER_KEY=<master_key> SENTRY_DSN=<sentry_io_rails_backend_dsn_key> EMAIL_ADDRESS=no-reply@<domain_name> EMAIL_PASSWORD=<generate_password_for_no_reply_email_account> SERVER_DOMAIN=<domain_name> MAIL_SERVER_ADDRESS=mail.<domain_name>

        dokku config:set realtime-backend SENTRY_DSN=<sentry_io_realtime_backend_dsn_key>

        dokku config:set postgres-admin PGADMIN_DEFAULT_EMAIL=admin@<domain_name> PGADMIN_DEFAULT_PASSWORD=<generate_password_for_postgres_web_gui> PGADMIN_DISABLE_POSTFIX=True PGADMIN_CONFIG_MAIL_SERVER=\"mail.<domain_name>\" PGADMIN_CONFIG_MAIL_PORT=465 PGADMIN_CONFIG_MAIL_USE_SSL=True PGADMIN_CONFIG_MAIL_USERNAME=\"no-reply@<domain_name>\" PGADMIN_CONFIG_MAIL_PASSWORD=\"<prevously_generated_password_for_no_reply_email_account>\" PGADMIN_CONFIG_MAIL_FROM=\"No\ Reply\ -\ GamifyCoding\\u2122\ \<no-reply@<domain_name>\>\"

        dokku config:set mongo-admin ME_CONFIG_BASICAUTH_USERNAME=admin@<domain_name> ME_CONFIG_BASICAUTH_PASSWORD=<generate_password_for_mongo_web_gui> ME_CONFIG_OPTIONS_EDITORTHEME=the-matrix ME_CONFIG_SITE_COOKIESECRET=<generate_random_long_alphanumeric_character_sequence> ME_CONFIG_SITE_SESSIONSECRET=<generate_another_random_long_alphanumeric_character_sequence> ME_CONFIG_MONGODB_ENABLE_ADMIN=false
        ```
    - Install Dokku plugins:
        ```bash
        sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
        sudo dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo
        sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
        sudo dokku plugin:install https://github.com/d1ceward/dokku-posteio.git
        ```
    - Configure mail server:
        ```bash
        dokku posteio:set-domain mail.<domain_name>
        dokku posteio:start
        ```
        - And then open a new incognito/private browser window and directly navigate to http://mail.<domain_name> (use HTTP not HTTPS, important!):
            - Leave Mailserver hostname as default.
            - Set Admin email: admin@<domain_name>
            - Set Password as desired (these two be changed later on).
            - Click "Submit", then in the same tab, navigate to this URL:
            http://mail.<domain_name>/admin/settings/#certificate
            - Click "issue free letsencrypt.org certificate".
            - Select "Enabled" and save changes.
            - Wait for new certificate to be issued and then navigate back to the terminal and run this command:
                ```bash
                dokku posteio:toggle-ssl
                ```
            - After browser tab refresh, mail server admin dashboard should now redirect from HTTP to HTTPS.
            - Read through https://poste.io/ and the open admin dashboard UI for further config options. You can generate the aforementioned DKIM TXT record and update the relevant DNS record entry for increased mail-server trust-factor.
            - In the open admin dashboard UI create a new email account "no-reply@<domain_name>" with password set to the previously generated value: <generate_password_for_no_reply_email_account>
            - For this new email account set incoming/inbound emails to be ignored and then save. 
    - Enable HTTPS for rest of apps:
        ```bash
        dokku letsencrypt:set rails-backend email <your_email_address>
        dokku letsencrypt:enable rails-backend
        dokku letsencrypt:set realtime-backend email <your_email_address>
        dokku letsencrypt:enable realtime-backend
        dokku letsencrypt:set postgres-admin email <your_email_address>
        dokku letsencrypt:enable postgres-admin
        dokku letsencrypt:set mongo-admin email <your_email_address>
        dokku letsencrypt:enable mongo-admin
        ```
    - Add auto-renew cron-job to re-generate certificates every 3 months:
        ```bash
        dokku letsencrypt:cron-job --add
        ```
    - Create database services:
        ```bash
        dokku postgres:create postgres-database
        dokku mongo:create mongo-database
        ```
    - Link database services to main rails-backend app:
        ```bash
        dokku postgres:link postgres-database rails-backend -a "POSTGRES_DATABASE_URL"
        dokku mongo:link mongo-database rails-backend -a "MONGO_DATABASE_URL"
        dokku mongo:link mongo-database mongo-admin -a "ME_CONFIG_MONGODB_URL"
        ```
    - Deploy front-end GUIs for the 2 databases:
        ```bash
        dokku git:from-image postgres-admin dpage/pgadmin4
        dokku git:from-image mongo-admin mongo-express
        ```
    - Deploy the 2 back-ends:
        ```bash
        # Assuming the earlier <public_ssh_key_for_deployment> is configured to be used by Git on your local machine
        # Open a new terminal in VSCode
        cd <path_to_top_level_directory>/realtime-backend
        git init --initial-branch=main
        git add .
        git commit -m "<your_commit_message>"
        git remote add dokku dokku@<domain_name>:realtime-backend
        git push dokku main

        # Wait for realtime-backend to deploy, then:
        cd ../rails-backend
        git add .
        git init --initial-branch=main
        git commit -m "<your_commit_message>"
        git remote add dokku dokku@<domain_name>:rails-backend
        git push dokku main

        # Wait for rails-backend to deploy, then navigate back to the terminal with the SSH server connection and seed the databases:
        dokku ps:stop rails-backend
        dokku run rails-backend bundle exec rake db:seed
        dokku ps:start rails-backend
        ```
    - Navigate to <domain_name> in a new browser tab, then:
        - Create a new account with:
            - Email set to admin@<domain_name>
            - A strong password
        - Once created, go back to the terminal with the SSH server connection and run:
            ```bash
            dokku postgres:connect postgres-database

            # And in the database shell run this update query as a single command (you can copy-paste):
            UPDATE Users
            SET user_type=1
            WHERE email='admin@<domain_name>';
            ```
        - Refresh the browser tab with <domain_name> opened. If the URL switches from <domain_name>/app to <domain_name>/admin and the admin dashboard is visible, your account now has admin permissions on the platform.
    - In the SSH server connection terminal:
        ```bash
        dokku postgres:info postgres-database

        # And save the printed ip address (abbr. <local_postgres_db_ip_address>)
        # And password (abbr. <local_postgres_db_password>)

        # Example output of command with above information location highlighted:

        =====> postgres-database postgres service information
        Config dir:          /var/lib/dokku/services/postgres/postgres-database/data
        Config options:                               
        Data dir:            /var/lib/dokku/services/postgres/postgres-database/data
        Dsn:                 postgres:// postgres:<local_postgres_db_password>@dokku-postgres-postgres-database:5432/ postgres_database
        Exposed ports:       -                        
        Id:                  8990a51709df214d29535588ab201c0260d388fa13693f3f82e26244df01455f
        Internal ip:         <local_postgres_db_ip_address>               
        Initial network:                              
        Links:               rails-backend            
        Post create network:                          
        Post start network:                           
        Service root:        /var/lib/dokku/services/postgres/postgres-database
        Status:              running                  
        Version:             postgres:16.2
        ```
    - Navigate to postgres.<domain_name> in a new browser tab, then login with:
        - Email: admin@<domain_name>
        - Password: earlier generated password <generate_password_for_postgres_web_gui>
    - Create a new server connection (Object -> Register -> Server…), use these values in the *Connection* tab:
        - host name/address: <local_postgres_db_ip_address> (from previous step)
        - port: 5432
        - maintenance database: postgres_database
        - username: postgres
        - kerberos authentication: false
        - password: <local_postgres_db_password> (from previous step)
        - save password: true
        - role: postgres
        - service: leave blank
9. Congratulations, the production deployment is now finished! You can now add new users to "Pre-Authorized Emails" with groups set to one of the two options and create new challenges in the "Challenge Editor", all available in the admin dashboard. These are all the relevant links:
    - <domain_name> (main platform URL)
    - mail.<domain_name>/admin (mail server admin UI)
    - mail.<domain_name>/webmail (mail server standard UI for sending/reading emails)
    - postgres.<domain_name> (web UI for managing postgres DB data):
        - Use admin@<domain_name> and <generate_password_for_postgres_web_gui> for logging in.
    - mongo.<domain_name> (web UI for managing mongo DB data):
        - Use admin@<domain_name> and <generate_password_for_mongo_web_gui> for logging in.
### Additional information:
- To import/export database backups:
    - SSH into the server with root-level access and run these commands:
        ```bash
        # Export
        dokku mongo:export mongo-database > <file_name>.dump
        dokku postgres:export postgres-database > <file_name>.dump

        # Import
        dokku mongo:import mongo-database < <file_name>.dump
        dokku postgres:import postgres-database < <file_name>.dump
        ```
- To set up daily local database backups (example below is set for 2am backup time):
    - SSH into the server with root-level access and run these commands:
        ```bash
        crontab -e

        # Add these 2 lines at the bottom:
        0 2 * * *  cd /root && mkdir -p $(date "+\%Y-\%m-\%d") && cd $(date "+\%Y-\%m-\%d") && dokku mongo:export mongo-database > mongo-database.dump

        0 2 * * *  cd /root && mkdir -p $(date "+\%Y-\%m-\%d") && cd $(date "+\%Y-\%m-\%d") && dokku postgres:export postgres-database > postgres-database.dump

        # And save (Ctrl+X -> Y -> Enter)
        ```
    - These backups from a given day can be downloaded onto your local machine (after 2am) with:
        ```bash
        # Assuming "root" root-level user on server, change if required
        scp root@<domain_name>:~/YYYY-MM-DD/* .
        ```
- To clear all data from the databases (use with caution!) and/or re-seed data e.g. to start a new experiment/competition:
    - SSH into the server with root-level access and run these commands:
        ```bash
        dokku ps:stop rails-backend

        # To clear all postgres DB data run:
        dokku run rails-backend bundle exec rake DISABLE_DATABASE_ENVIRONMENT_CHECK=1 db:drop
        dokku run rails-backend bundle exec rake db:create
        dokku run rails-backend bundle exec rake db:migrate

        # To clear all mongo DB data run:
        dokku run rails-backend bundle exec rake mongo:drop

        # Only if you want to re-seed the databases:
        dokku run rails-backend bundle exec rake db:seed

        dokku ps:start rails-backend
        ```
        Note: The previously mentioned steps for creating an admin account for the platform have to be performed again and are only possible if the above re-seed command was also executed!