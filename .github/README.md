# _Docker Image for BlizzCMS_

This repository provides you an easy deployment of BlizzCMS in a few steps without the need to install the packages for PHP, web server and any other server software on your local machine.

[![Version](https://img.shields.io/github/v/release/WoW-CMS/Docker-BlizzCMS?color=green&style=for-the-badge&logo=github)](https://github.com/WoW-CMS/Docker-BlizzCMS/releases)

### 📋 Pre-requirements

```
You only need to have Docker installed and running.
```

## 📦 Deployment

```sh

git clone https://github.com/WoW-CMS/Docker-BlizzCMS.git docker
cd docker
docker build -t docker .
docker run -d -p 3306:3310 --name name-container docker
```

To connect to your docker is really easy.

```sh

docker exec -it name-container /bin/bash  

```

## 🛠️ Built with

* [Docker](https://www.docker.com)

## ✒️ Authors & Contributors

* [WoW-CMS Developers and Contributors](https://github.com/WoW-CMS/Docker-BlizzCMS/graphs/contributors)

## 🔗 Important Links

* [Website](https://wow-cms.com)
* [Our Discord](https://discord.wow-cms.com)

## 📄 License

This project is licensed under the [MIT License](../LICENSE).
