## Start Infra using terraform

1. Create a user in IAM for terraform and login to aws cli with it.

2. Run terraform init to download aws drivers

3. Create a .env file with content:
```
    export TF_VAR_db_password={YOUR_DB_PASSWORD}
```

4. Load all environment variables from .env by running:

    `source ./.env`

5. Run terraform apply

## Access private db through jump server

1. Set up port forwarding:
```
ssh -i <key> -L <localport>:<db_endpoint>:<db_port> ubuntu@<ec2_public_ip> -N

e.g.
ssh -i test.pem -L 5431:postgres-identifier.cte4wmqi2z89.us-east-1.rds.amazonaws.com:5432 ubuntu@107.20.125.132 -N
```

2. Run postgres from local host
```
psql --host=localhost --port=<localport> --username=<db_username> --dbname=<db_name>

e.g.
psql --host=localhost --port=5431 --username=yousha --dbname=postgres
```

3. Run commands e.g.
```
\dt

SELECT * FROM "Course";
```