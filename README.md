# Docker on AWS CodeDeploy

Deploying a Middleman site as a Docker container built with CircleCI and AWS CodeDeploy to a highly available cluster. Whoa, that was a mouthful. Basically, we are mashing up these services and applications:

* Docker
* Middleman
* CircleCI
* AWS

Still interested? Cool! Let's get to it...

## Setup

First things first, I make some assumptions in this article:

* You are already setup with AWS and are comfortable with IAM and policies.
* You have used or are interested in using CircleCI.
* You know a little bit about Middleman and maybe even have a Ruby environment available locally.
* You like fiddling with things.

## Application

* In the AWS CodeDeploy console, create a new application. We're going to use the name `middleman` for both the Application Name and the Deployment Group Name.
* Under *Search by Amazon EC2 Tags* select the *Name* key and fill in `middleman`. We'll create these instances soon.
* Deployment Config can be *OneAtATime*.
* Service Role ARN* should be the Service Role you already created in the setup.

Now you can click the *Create Application* button. Cool. We have an application!

## Instances

Now lets move over to the CloudFormation console so we can create our `middleman` stack.

* Click the *Create Stack* button near the top left of the page.
* We are going to use the name `middleman`.
* The template to upload is the `aws/codedeploy_docker_cf_template.json` file in this repository.
* Set *Instance Count* to 3.
* Set *Key Pair* to an actual key pair name in AWS already.
* Make sure *TagKey* is `Name` and set *TagValue* to `middleman` (the tag our CodeDeploy Deployment Group will look for).

Create the stack. Kewl.

## Revision

* Coming soon!
