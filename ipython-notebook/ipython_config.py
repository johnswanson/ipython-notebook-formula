c = get_config()
c.IPKernelApp.pylab = 'inline'
c.NotebookApp.ip = '{{ ip }}'
c.NotebookApp.port = {{ port }}
c.NotebookApp.open_browser = False
c.IPKernelApp.trust_xheaders = True

{% if hashed_pass %}
c.NotebookApp.password = u'{{ hashed_pass }}'
{% endif %}
