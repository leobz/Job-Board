# Job Board

Job Board is a platform for posting job openings and processing payments.

## Description

Job Board allows employers to post job openings and job seekers to find and apply for relevant jobs. It includes a payment gateway that enables employers to pay for job postings using  for example Bitcoin or the Lightning Network. This provides a simple, fast, and secure way to process payments and ensures that job postings are visible to a large audience.

## Setup

1. Install [docker](https://docs.docker.com/engine/install/)
2. Set up the environment variables by creating a `config/local_env.yml` file with the following fields:

```yml
# Admin Password
ADMIN_PASSWORD: "your_admin_password"

# Open Node
API_KEY: "open_node_api_key"
OPEN_NODE_URL: "https://api.opennode.com/v1/charges"
MY_HOST: "deploy_domain_who_is_going_to_be_requested_by_the_open_node_webhook"
```

You can obtain an API key by signing up for an account on OpenNode. See [open node documentation](https://developers.opennode.com/docs/creating-a-charge)

## Basic Commands: Development

Run app:

```
# Install ruby dependencies
bundle install

# Run the Ruby app locally + DB in container
make dev
```

Now you can visit [`localhost:3000`](http://localhost:3000)


Stop app:

```
make stop # Terminates the execution of all containers
```

## Clean containers

* After using the containers, you can destroy them with their volumes using `make clean`

## Available tasks

You can see available tasks with `make`

## Running Tests

To run the tests for Job Board, run the following command:

```bash
rake test
```
