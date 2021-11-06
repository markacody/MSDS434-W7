
PROJECT_ID = msds434-w7

#Install dependencies and run locally
install:
	pip install -r requirements.txt

run-locally:
	python main.py
	
#Create GCP Resources
#First login to GCP with gcloud auth login
#This bucket is for the terraform state file
create-tf-bucket:
	gsutil mb -p ${PROJECT_ID} gs://$(PROJECT_ID)-terraform

#CREATE WORKSPACE for "Dev" and "Prod"
ENV?=dev

terraform-create-workspace:
	cd terraform && \
	terraform workspace new $(ENV)

terraform-init:
	cd terraform && \
	terraform workspace select $(ENV) && \
	terraform init

terraform-plan:
	cd terraform && \
		terraform workspace select $(ENV) && \
		terraform plan

#
TF_ACTION?=plan
terraform-action:
	cd terraform && \
		terraform workspace select $(ENV) && \
		terraform $(TF_ACTION) \
		-var-file="./environments/common.tfvars" \
		-var-file="./environments/$(ENV)/config.tfvars"

clean:
	rm -rf __pycache__