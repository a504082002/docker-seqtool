FROM a504082002/biopython-mkl
MAINTAINER Yueh-Hua Tu <a504082002@gmail.com>

# Install dependencies
RUN apt-get update -qq && \
	apt-get install -yq --no-install-recommends \
						openjdk-8-jdk \
						ant \
						git \
						less \
						libdatetime-perl \
						libxml-simple-perl \
						libdigest-md5-perl \
						bioperl && \
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

# install roary
RUN conda config --add channels r && \
	conda config --add channels defaults && \
	conda config --add channels conda-forge && \
	conda config --add channels bioconda && \
	conda install -y roary && \

CMD ["/bin/bash"]

