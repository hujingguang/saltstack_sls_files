{%set nodejs_dir="/webdata/opt/local/nodejs" %}

install_dependence_pkg:
  pkg.installed:
    - pkgs:
      - xz
      - libstdc++.i686
      - gcc
      - gcc-c++
      - glibc.i686

upload_bar:
  file.managed:
    - name: /root/node-v4.2.4-linux-x86.tar.xz
    - source: salt://nodejs/files/node-v4.2.4-linux-x86.tar.xz
    - unless: test -e /root/node-v4.2.4-linux-x86.tar.xz

uncompress_bar:
  cmd.run:
    - name: cd /root && tar -xf node-v4.2.4-linux-x86.tar.xz && mkdir -p {{nodejs_dir}} &&  mv node-v4.2.4-linux-x86/*   {{nodejs_dir}}/
    - unless: test -e {{nodejs_dir}}/bin/node
    - required:
      - file: upload_bar

append_path:
  file.append:
    - name: /etc/profile
    - text: PATH=.:$PATH:{{nodejs_dir}}/bin
    - unless: egrep node /etc/profile




install_forever:
  cmd.run:
    - name: cd {{nodejs_dir}} && ./bin/npm install forever 
    - unless: test -e {{nodejs_dir}}/bin/forever
    - required:
      - cmd: uncompress_bar


cp_forever:
  cmd.run: 
    - name: cd {{nodejs_dir}} && mv node_modules/forever ./lib/ && cp ./lib/forever/bin/forever ./bin/
    - unless: test -e {{nodejs_dir}}/bin/forever
     
  

