Ansible Role: db
================

[![Build Status](https://travis-ci.com/aarkhang/test-ansible-role.svg?branch=master)](https://travis-ci.com/aarkhang/test-ansible-role)

A sample Ansible Role that installs MongoDB 3.6 on Ubuntu 16.04

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

    mongo_port: 27017
    mongo_bind_ip: 127.0.0.1
    env: local

A description of the settable variables for this role should go here, including
any variables that are in defaults/main.yml, vars/main.yml, and any variables
that can/should be set via parameters to the role. Any variables that are read
from other roles and/or the global scope (ie. hostvars, group vars, etc.) should
be mentioned here as well.

Dependencies
------------

None.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: aarkhang.db, x: 42 }

License
-------

MIT / BSD

Author Information
------------------

This role was created as homework for [Otus DevOps 2018-09 Infrastructure repository](https://github.com/Otus-DevOps-2018-09/aarkhang_infra).
