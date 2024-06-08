1. Create a user in IAM for terraform and login to aws cli with it.

2. Run terraform init to download aws drivers

3. Create a .env file with content:
```
    export TF_VAR_db_password={YOUR_DB_PASSWORD}
```

4. Load all environment variables from .env by running:

    `source ./.env`

5. Run terraform apply