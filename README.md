# TF-AUTH-PATTERNS

## Vault AWS Secret engine Setup



```bash
$ vault secrets enable aws
Success! Enabled the aws secrets engine at: aws/
```



```bash
$ vault write aws/config/root \
access_key=AKIAU3NXDWRUO2Y4EJBI \
secret_key=**************************** \
region=ap-northeast-2
```



```bash
$ vault write aws/roles/my-role \
    credential_type=iam_user \
    policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
EOF

$ vault write aws/roles/my-other-role \
policy_arns=arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess,arn:aws:iam::aws:policy/IAMReadOnlyAccess \
iam_groups=group1,group2 \
credential_type=iam_user \
policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
EOF

$ vault write aws/roles/ec2_admin \
credential_type=federation_token \
policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "ec2:*",
      "sts:GetFederationToken"
    ],
    "Resource": "*"
  }
}
EOF
```



```bash
$ vault read aws/creds/my-role
Key                Value
---                -----
lease_id           aws/creds/my-role/f3e92392-7d9c-09c8-c921-575d62fe80d8
lease_duration     768h
lease_renewable    true
access_key         AKIAIOWQXTLW36DV7IEA
secret_key         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
security_token     <nil>

$ vault lease revoke aws/creds/my-role/ZYV9Rp6bfivOzmrQNtdqGXyD

$ vault write aws/sts/ec2_admin ttl=60m
Key                Value
---                -----
lease_id           aws/sts/ec2_admin/hfGshjoLNyedzKdVtnXP74fy
lease_duration     59m59s
lease_renewable    false
access_key         ASIAU3NXDWRUIY72RFC3
secret_key         lv4kJnf7XnGTJKT0ZP+w+zTrp6Zlc5+gNyuesivD
security_token     IQoJb3JpZ2luX2VjEM3//////////wEaDmFwLW5vcnRoZWFzdC0yIkYwRAIgB76TeW3zUXLd3LCYYPn05AbudXzqf8vwfzq508Q7nOECIHDRwhNo28dwzAO8Qk6kTKdvEbQ/UrX/cs8IGOURvklkKrgCCCYQAhoMMzMzNzgwODU3OTYwIgwDfgm3ECeivK0FqocqlQJ48Y476n3JUgYeBP7Yw0zuQITtulfra2V7ViTt3wnvzDkE7GYRKy7rHtGpiH4VcfQ/XESh+wo+m+EIOREg09mSJx92oM9Ao9qO8rIxFcmE9Ha+dHQpeNA+n6h5sLPxp3m5lul819tMwrZsqN9qYPzVKNOhK9Tek/OvyJaaJanyvEgmQI+WbOGEREheOHV8aczKRY3ILO/TX+aFoJJ4zgl49VBaLqLy36DQ0eVrYry27ltfspGNtJWDloNhZP6ZOHQF4WKQKY6iMNlv+QmHpLrSUwVgoP1x1RswjLOK5teXI45W0g5cTOWKFtTLGK7OR12exD+o2IiwWgKhTvCNuFZVPWBQRmqpe79fZOJnfBLVu0JxmuCUMP63+4kGOpoB+sDiY2Ry7dH0e5+YVEng8YgaFoICtCYMqLrArDo5uO7ZBE/clDRALlVhPO0CFcM1weV2baCP4Q6Q3adItMvDDcYpOQzyIRdK1tzM0V3Xzje4R+bWoa18YeuNW4UbGP5redO34b8tlEMS/j5oD3T/BgApzjCA03zh1RZm4ziVsvhJXR1phrbScKakQ/KsYQa5XgPLtWGBdA8jcg==
```

