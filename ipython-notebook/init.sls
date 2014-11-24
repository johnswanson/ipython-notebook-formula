{% from "ipython-notebook/map.jinja" import ipython_notebook as ip with context %}

include:
  - anaconda

{% for user, config in ip.users.iteritems() %}

/home/{{ user }}/.ipython:
  file.directory:
    - user: {{ user }}
    - group: {{ config.group }}
    - mode: 0755

/home/{{ user }}/.ipython/profile_{{ config.profile }}:
  file.directory:
    - user: {{ user }}
    - group: {{ config.group }}
    - mode: 0755
    - require:
      - file: /home/{{ user }}/.ipython

/home/{{ user }}/.ipython/profile_{{ config.profile }}/ipython_config.py:
  file.managed:
    - user: {{ user }}
    - group: {{ config.group }}
    - template: jinja
    - context:
      ip: {{ config.host }}
      port: {{ config.port }}
    - source: salt://ipython-notebook/ipython_config.py
    - mode: 0755
    - require: 
      - file: /home/{{ user }}/.ipython/profile_{{ config.profile }}

/home/{{ user }}/anaconda/bin/conda update -y ipython:
  cmd.run:
    - user: {{ user }}
    - group: {{ config.group }}

{% endfor %}
