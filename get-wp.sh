#!/bin/sh

################################
# Download and unpack Wordpress#
################################

curl -o wordpress.tar.gz -fSL "https://wordpress.org/latest.tar.gz"
tar -xzf wordpress.tar.gz ; \
	rm wordpress.tar.gz; \
	chmod -R 777 ./wordpress