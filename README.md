# EC2 Web Server Automation

Creating Fun web server for experiments in EC2

## Installation

TBD

## Usage

Create a EC2 Instance:
- Copy/paste the user data script from [user-data.sh](/user-data/user-data.sh)
- Create an IAM Role with the following policy:

```
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1409309287000",
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeTags"
        ],
        "Resource": [
          "*"
        ]
      }
    ]
  }
```

- Create a tag with Name="Cat" and Value any of {cat1, cat2, cat3, cat4, cat5}