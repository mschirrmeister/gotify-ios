# Gotify iOS notifications

There is no **iOS** app for [Gotify](https://gotify.net/) (yet). There is a blog post, that talks about a solution on how to send notifications from Gotify to iOS. You can read about it here <https://the-empire.systems/gotify-ios-notifications>.

Having it running in a container either standalone in Docker or in a Kubernetes cluster makes this a good solution where all dependencies are running isolted in a container.

This container connects to your Gotify server and pushes the messages to the configured backend(s). The backend is configured in a config file, which is then mounted into the container.

**Note**:  
There is probably a better way of keeping the process running in the foreground besides running it in `screen` and sleeping forever. But it was the only way to keep the container **up**. Even if the shell script does **not** exit, when run manually, it does for some reason exit when run via ENTRYPOINT or CMD. Not sure why at this point.

Build the docker image, if you want to run it locally.

    docker build -t gotify-ios .

I have images for **x86_64** and **arm64**. If that suites you, below are two examples on how to run the container with the pre-build images from Docker Hub.  
You need to set the following 2 variables for your environment and you should edit `ntfy.yml` with the backends you want to use. The example file includes the minimum settings for **[Pushover](https://pushover.net/)**.

- GOTIFY_SERVER
- GOTIFY_TOKEN

Run the container like this.

    docker run -d \
      --name=gotify2ios \
      -e "GOTIFY_SERVER=192.168.2.60" \
      -e "GOTIFY_TOKEN=xxx" \
      -v ~/.config/ntfy/ntfy.yml:/home/appuser/.config/ntfy/ntfy.yml \
      mschirrmeister/gotify-ios:latest

In case you use `macvlan` where you containers have an ip address from your network.

    docker run -d \
      --name=gotify2ios \
      --network=1_server_lan \
      --ip=192.168.2.61 \
      -e "GOTIFY_SERVER=192.168.2.60" \
      -e "GOTIFY_TOKEN=xxx" \
      -v ~/.config/ntfy/ntfy.yml:/home/appuser/.config/ntfy/ntfy.yml \
      mschirrmeister/gotify-ios:latest

