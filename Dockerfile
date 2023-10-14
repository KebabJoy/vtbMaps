# Base image
FROM ruby:3.1.3

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev

# Set up application directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install gems
COPY Gemfile* ./
RUN bundle install

# Copy application files
COPY . .

# Set environment variables
ENV RAILS_ENV=development \
  RAILS_LOG_TO_STDOUT=true \
  RAILS_SERVE_STATIC_FILES=true \
  SECRET_KEY_BASE=your-secret-key-base

CMD ["sh", "-c", "cd /usr/src/app && bundle exec rails s -b 0.0.0.0"]
