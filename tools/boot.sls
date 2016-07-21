/etc/rc.local:
  file.append:
    - text: /etc/init.d/agent.py  -d -s 72000 -m 10.117.74.247
    - unless: grep 'agent.py' /etc/rc.local
