aarkhang_infra
==============
[![Build Status](https://travis-ci.com/Otus-DevOps-2018-09/aarkhang_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2018-09/aarkhang_infra)

Otus DevOps 2018-09 Infrastructure repository.

Домашнее задание #6    Terraform-1
----------------------------------

### Основное ДЗ
1. Удалены ключи пользователя appuser из метаданных прокта
2. Установлена Terraform
3. Создана конфигурация Terraform для запуска 1 экземпляра ВМ из образа reddit-base в GCP
   - Публичный ключ пользователя appuser добавлен к метаданным экземпляра
   - Добавлено правило файрволла и тег для него
   - Добавлены провижинеры для развёртывания и запуска тестового приложения
   - Добавлен приватный ключ для подключения провижинера по SSH
4. Конфигурационный файл параметризован с помощью входных переменных
5. Отформатированы конфигурационные файлы
6. Проверена работа приложения


### Задание со *
Добавить ssh-ключи к метаданным проекта можно 2 способами:
   - С помощью ресурса [google_compute_project_metadata](https://www.terraform.io/docs/providers/google/r/compute_project_metadata.html)
```
resource "google_compute_project_metadata" "ssh_keys" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key2_path)}"
  }
}
```
   - С помощью ресурса [google_compute_project_metadata_item](https://www.terraform.io/docs/providers/google/r/compute_project_metadata_item.html)
```
resource "google_compute_project_metadata_item" "ssh_keys" {
  key   = "ssh-keys"
  value = "appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key2_path)}"
}
```
С помощью **одного** ресурса можно добавить несколько ключей, разделяя их символом "\n", а при использовании синтаксиса ${file(var.public_key_path)} разделитель можно опустить, т.к. он имеется внутри файла с публичным ключом.

Ключи, указанные в конфигурации terraform, перезапишут любые другие ssh-ключи, утановленные вручную и удалят все ключи, не указанные в конфигурации.


Домашнее задание #5    Packer base
----------------------

### Шаблоны

Созданы и параметризованы шаблоны для сборки **Packer**-ом образов ВМ

* ubuntu16.json: cемейство reddit-base (базовая установка Ruby и МоngoDB) 

* immutable.json: cемейство reddit-full (строится на основе базового) 


### Сборка


Для сборки base-образа применяется команда
```sh
$ packer build -var-file=variables.json  ubuntu16.json
```

Для автоматизации сборки full-образа создан скрипт build-reddit-full.sh
```sh
#!/bin/sh
set -e

IMAGE=`gcloud compute images list --format="value(name)"  --filter="name:reddit-base"  --sort-by="~name" --limit=1`

echo Using last base image: $IMAGE

packer validate -var-file=variables-immutable.json -var "source_image=$IMAGE" immutable.json
packer build -var-file=variables-immutable.json -var "source_image=$IMAGE" immutable.json
```

### Запуск


Для автоматизации запуска образа ВМ создан скрипт create-reddit-vm.sh
```sh
#!/bin/sh

IMAGE=`gcloud compute images list --format="value(name)"  --filter="name:reddit-full"  --sort-by="~name" --limit=1`

echo Using last image: $IMAGE

gcloud compute instances create reddit-app \
  --image $IMAGE \
  --machine-type=g1-small \
  --tags "puma-server" \
  --zone "europe-west1-b"
```


Домашнее задание #4
----------------------

### Данные для подключения
```
testapp_IP = 35.228.70.71
testapp_port = 9292
```

#### Команда создания инстанса
```sh
$ gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=install_reddit.sh
```

#### Команда создания правила брандмауэра
```sh
$ gcloud compute --project=infra-219311 firewall-rules \
     create  default-puma-server \
   --direction=INGRESS --priority=1000 --network=default \
   --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 \
   --target-tags=puma-server
```


Домашнее задание #3
----------------------

### Адреса ВМ в GCP
```
bastion_IP = 35.228.177.152
someinternalhost_IP = 10.166.0.3
```

#### Подключение к *someinternalhost* одной командой
```sh
$ ssh -i ~/.ssh/appuser -tA appuser@35.228.177.152 ssh 10.166.0.3
```

#### Подключение к *someinternalhost* по алиасу
Добавляем в файл ~/.ssh/config следующие строчки
```
Host someinternalhost
 HostName 10.166.0.3
 IdentityFile= ~/.ssh/appuser
 User appuser
 ProxyCommand ssh appuser@35.228.177.152 -W %h:%p
```
Если версия клиента OpenSSH >= 7.3 вместо **ProxyCommand** можно использовать

```
ProxyJump appuser@35.228.177.152
```
Теперь можно подключиться командой
```sh
$ ssh someinternalhost
```

#### Подключение к *someinternalhost* через *OpenVPN*
```sh
$ sudo openvpn cloud-bastion.ovpn 
```
Вводим имя пользователя и пароль, установленный при настройке Pritunl. Подключаемся в другом окне терминала: 

```sh
$ ssh -i ~/.ssh/appuser appuser@10.166.0.3

```
