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

## Bucket

Move over to the S3 console and create a bucket.

* Click the blue *Create Bucket* button.
* We are using the bucket named `andyshinn-middleman` in this example.

## Deploy

When you commit and push code to your repository the following will now happen:

* Our Middleman application Docker image gets built.
* We run the image to generate a Middleman site as `build.tar.gz`.
* We then copie `build.tar.gz` out of the container and into `images/nginx`.
* Now we build the `images/nginx` image as `middleman`.
* We then export the `middleman` image as `middleman_docker_image.tar.gz`.
* The CodeDeploy revision is kicked off and our application is pushed as a zip file to our S3 bucket.
* A CodeDeploy deployment of this revision is run for our server group.
