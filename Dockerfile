FROM ruby:2.7.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs \
   && rm -rf /var/lib/apt/lists/* 

RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

COPY . $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock


RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]
