# Docker Registry

## Usage

- `docker run --entrypoint htpasswd httpd:2 -Bbn myuser mypassword > registry-config/htpasswd`
- `docker-compose up -d`
- `docker login localhost:10102`:
  - user: `myuser`
  - password: `mypassword`
- Open [localhost:8080](http://localhost:8080)
- `bash ./populate.sh`

# Acknowledgements

- [github.com/Joxit/docker-registry-ui](https://github.com/Joxit/docker-registry-ui)
