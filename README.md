aarkhang_infra
==============
Otus DevOps 2018-09 Infrastructure repository.

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
