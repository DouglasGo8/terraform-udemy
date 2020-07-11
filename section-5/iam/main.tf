

resource "aws_iam_group" "administrators" {
  name = "Administrators"
}


resource "aws_iam_policy_attachment" "administrator-policies" {
  name       = "administrators-policies"
  groups     = ["${aws_iam_group.administrators.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_group_policy" "developer-admin-policy" {
  name   = "developer_admin_policy"
  group  = "${aws_iam_group.administrators.id}"
  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "*",
                "Resource": "*"
            }
        ]
    }
    EOF
}


resource "aws_iam_user" "admin1" {
  name = "admin1"
}


resource "aws_iam_user" "admin2" {
  name = "admin2"
}

resource "aws_iam_group_membership" "administratos-users" {
  name = "administrator-users"
  users = [
    "${aws_iam_user.admin1.name}",
    "${aws_iam_user.admin2.name}"
  ],
  group = "${aws_iam_group.administrators.name}"
}


