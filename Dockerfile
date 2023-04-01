# Base image
FROM ruby:2.7.5

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  redis \
  wget \
  default-jdk

# Set up application directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install gems
COPY Gemfile* ./
RUN bundle install

# Copy application files
COPY . .

# Set environment variables
ENV RAILS_ENV=production \
  RAILS_LOG_TO_STDOUT=true \
  RAILS_SERVE_STATIC_FILES=true \
  SECRET_KEY_BASE=your-secret-key-base

# Set up database
RUN bundle exec rails db:create db:migrate db:seed

# Start Solr and Rails server
CMD ["sh", "-c", "cd /usr/src/app && bundle exec rails s -b 0.0.0.0"]
