/etc/daemon.conf:
  file.managed:
    - source: salt://tools/files/daemon.conf
    - mode: 600
