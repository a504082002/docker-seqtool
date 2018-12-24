FROM a504082002/biopython-mkl
MAINTAINER Yueh-Hua Tu <a504082002@gmail.com>

# Install dependencies
RUN apt-get update -qq && \
	apt-get install -yq --no-install-recommends \
						openjdk-8-jdk && \
	apt-get install -yq --no-install-recommends \
						ant \
						git \
						less \
						libdatetime-perl \
						libxml-simple-perl \
						libdigest-md5-perl \
						bioperl \
						bedtools cd-hit mcl parallel cpanminus prank mafft fasttree \
						roary && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	rm -rf /var/cache/oracle-jdk8-installer

# Fix certificate issues
RUN apt-get update -qq && \
	apt-get install -yq --no-install-recommends \
						ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Setup environment variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# clone prokka
RUN git clone https://github.com/tseemann/prokka.git && \
	prokka/bin/prokka --setupdb

# set links to /usr/bin
ENV PATH $PATH:/prokka/bin

CMD ["/bin/bash"]

