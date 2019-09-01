# Links
<https://aws.nz/best-practice/re-using-ec2-key-pair/ />
<https://github.com/wardviaene/terraform-course />
<https://stackoverflow.com/questions/38294628/docker-push-to-aws-ecr-fails-on-windows-no-basic-auth-credentials/38294629 />

# Commands
ssh-keygen -e -m RFC4716 -f main-private-key.pem

aws --profile default ecr get-authorization-token --region us-east-1

edit .docker/config.json to

{
	"auths": {
        "https://501317491826.dkr.ecr.us-east-1.amazonaws.com": {
        	"auth": "Token here..."
        }
    }
}

docker build -t 501317491826.dkr.ecr.us-east-1.amazonaws.com/nubank-check-balance-app:latest .
docker push 501317491826.dkr.ecr.us-east-1.amazonaws.com/nubank-check-balance-app:latest
