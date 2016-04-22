FROM ruby:2.1.5

RUN apt-get update -qq && apt-get install -y build-essential wget nodejs npm nodejs-legacy mysql-client vim python-software-properties debconf-utils software-properties-common apt-utils

# Install Java JDK
RUN apt-get install -y openjdk-7-jdk

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN npm install -g phantomjs-prebuilt
RUN npm install -g bower
RUN wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb
RUN dpkg -i elasticsearch-2.3.1.deb

# Adding ES
RUN service elasticsearch start

RUN mkdir /myapp

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /myapp
WORKDIR /myapp

RUN RAILS_ENV=development
CMD ["rails","server","-b","0.0.0.0"]
