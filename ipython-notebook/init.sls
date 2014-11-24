{% from "ipython-notebook/map.jinja" import ipython_notebook as ip with context %}

include:
  - anaconda

/home/{{ ip.user }}/.ipython/profile_{{ ip.profile }}/ipython_config.py:
  file.managed:
    - user: {{ ip.user }}
    - group: {{ ip.group }}
    - template: jinja
    - context:
      ip: {{ ip.host }}
      port: {{ ip.port }}
      cert: {{ ip.cert }}
    - source: salt://ipython-notebook/ipython_config.py
    - mode: 0755
    - require: 
      - user: {{ ip.user }}

