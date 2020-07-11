# Links
[EC2 Re-use Key] (https://aws.nz/best-practice/re-using-ec2-key-pair)
[Terraform Course] (https://github.com/wardviaene/terraform-course)
[Stackoverflow] (https://stackoverflow.com/questions/38294628/docker-push-to-aws-ecr-fails-on-windows-no-basic-auth-credentials/38294629)

# Commands
sudo ssh-keygen -e -m RFC4716 -f {{PEMFILE}}.pem
ssh ec2-user@{{PUBLIC_IP}}
aws --profile default ecr get-authorization-token --region us-east-1

edit .docker/config.json to

{
	"auths": {
        "https://501317491826.dkr.ecr.us-east-1.amazonaws.com": {
        	"auth": "Token here..."
        }
    }
}

# Without token in config (12 hours expiration)

aws ecr get-login-password --region us-east-2
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 501317491826.dkr.ecr.us-east-2.amazonaws.com

docker build -t 501317491826.dkr.ecr.us-east-1.amazonaws.com/nubank-check-balance-app:latest .
docker push 501317491826.dkr.ecr.us-east-1.amazonaws.com/nubank-check-balance-app:latest

docker push 501317491826.dkr.ecr.us-east-2.amazonaws.com/apress-repo:app
