# iPython Notebook Formula
Sets up iPython notebook server

## Example pillar
	ipython-notebook:
	  users:
		dhc-user:
		  hashed_pass: sha1:56f09206d73e:8d66361770645216171bcbf9b648a33429fa4c90
		  group: dhc-user
		  profile: julia
		  port: 8080
		  host: localhost
