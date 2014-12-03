{% from "ipython-notebook/map.jinja" import ipython_notebook as ip with context %}

include:
  - anaconda

{% for user, config in ip.users.iteritems() %}

/home/{{ user }}/notebooks:
  file.directory:
    - user: {{ user }}
    - group: {{ config.group }}
    - mode: 0755

/home/{{ user }}/.ipython/profile_{{ config.profile }}/ipython_notebook_config.py:
  file.append:
    - user: {{ user }}
    - group: {{ config.group }}
    - template: jinja
    - context:
      ip: {{ config.host }}
      port: {{ config.port }}
      hashed_pass: {{ config.hashed_pass }}
    - source: salt://ipython-notebook/ipython_config.py
    - mode: 0755
    - makedirs: True

/home/{{ user }}/anaconda/bin/conda update -y ipython:
  cmd.run:
    - user: {{ user }}
    - group: {{ config.group }}

/etc/init/ipython.{{ user }}.conf:
  file.managed:
    - user: root
    - group: root
    - template: jinja
    - context:
      notebook_dir: /home/{{ user }}/notebooks
      ipython_dir: /home/{{ user }}/.ipython
      profile: {{ config.profile }}
      user: {{ user }}
    - source: salt://ipython-notebook/init.conf
    - mode: 0755

ipython.{{ user }}:
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - file: /home/{{ user }}/.ipython/profile_{{ config.profile }}/ipython_config.py

{% endfor %}
