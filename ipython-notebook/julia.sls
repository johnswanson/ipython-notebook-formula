{% from "ipython-notebook/map.jinja" import ipython_notebook as ip with context %}

{% for user, config in ip.users.iteritems() %}

env PATH=/home/{{ user }}/anaconda/bin:$PATH julia -e 'Pkg.add("IJulia")':
  cmd.run:
    - user: {{ user }}
    - group: {{ config.group }}
    - creates: /home/{{ user }}/.ipython/profile_julia
    - prerequisite:
      - file: /home/{{ user }}/.ipython/profile_julia/ipython_notebook_config.py:

