# What

* Simple ubuntu container for devops also containing a code server
	* arm64 ( tested on raspberry pi 4)
		* `docker pull iusetabs/devops-helper-ubuntu-arm64:latest`
	* amd64 ( tested on wsl v2 )
		* `docker pull iusetabs/devops-helper-ubuntu-amd64:latest`
		* Note for WSL, you need to run the image using the `--net=host` option. 
	* Example run of the image: `docker run -d --rm --name devops-ubuntu --net=host iusetabs/devops-helper-ubuntu-amd64`
