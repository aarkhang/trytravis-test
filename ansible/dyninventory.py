#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  dyinventory.py - dynamic inventory script
#  https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html#developing-inventory-scripts
#
import subprocess
import sys
import json

# global dictionary with IP-addresses
hostvars = {}

def make_group(basename):
    """Функция принимает базовое имя, возвращает список найденных инстансов 
    и добавляет их IP-адреса в словарь hostvars"""
    group = []
    gcil = 'gcloud compute instances list --format="value(name,networkInterfaces[].accessConfigs[0].natIP)" --filter="name:%s"'
    p = subprocess.Popen( gcil % basename, shell=True, stdout=subprocess.PIPE)
    for line in p.stdout:
        name, addr = line.split()
        hostvars[name] = { "ansible_host" : addr}
        group.append(name)
    return group    
    
        
def main(args):
    if len(args) != 2 or args[1] != "--list":
        sys.stderr.write("Usage: python %s --list\n" % args[0])
        return 1
    """ Создание динамического inventory"""
    app = make_group("reddit-app")
    db  = make_group("reddit-db")
    appvars = {}
    dbvars  = { "ansible_python_interpreter": "/usr/bin/python3" }
    
    inventory = \
    {   "app":   { "hosts": app, "vars" : appvars },
        "db":    { "hosts": db,  "vars" : dbvars },
        "_meta": { "hostvars": hostvars }
    }
 
    json.dump( inventory, sys.stdout, indent=4 )
    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
