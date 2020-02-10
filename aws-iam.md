# AWS - Identity and Access Management

## AWS Account and Services

### AWS Root account

- root account credentials are the email address and password used when signing up for AWS account
- By default root user has FULL admin rights and access to every part of the account

### Best practice for root user

- Should not use root user for daily work and aws adminstration.  Create a second user that has admin rights and use it instead
- Protect root account with MFA

### AWS Admin User account

- Used in place of root account, granting AdministratorAccess Policy, allows all access except Billing account permissions.

## IAM Essentials

**IAM** - Identity and Access Management - Manage AWS users, groups, and roles, and their access to AWS accounts and services

**IAM** is a global access resource. Provides access and permissions to AWS resources

### Access Management Basics

- Principal *A person or application that can make an authenticated or anonymous request*
- Authentication *The process of authenticating a principal against an identity*
- Identity *Objects that require authentication and are authorized to access resources*
- Authorization *The process of checking and allowing or denying access to a resource for an identity*

### The common use of IAM is to manage

- users
- groups
- roles
- IAM access policies
- API keys
- Specify a password policy as well as manage MFA requirements on a per user basis

>By default, any new IAM user you create in an AWS account is created with NO access to any AWS services.  This is a non-explicit deny rule set on all new IAM users.

For all users (besides the root user), permissions must be given that grant access to AWS services (this is done through IAM policies)
Principal of least privilege.

### Shared Responsibility/Security Model

#### Customer Security in the cloud

- Customer data
- Platform, Application, Identity and Access management
- Operating system, Network and Firewall Config
- Encryption - At rest and in transit
- Network protection

#### AWS Security of the cloud

- Software
- compute storage database network
- Hardware AWS infrastructure
- Regions AZs Edge location

AWS Identity and Access Management (IAM) enables you to securely control access to AWS services and resources for your users. Using IAM, you can create and manage AWS users and groups, and use permissions to allow and deny their access to AWS resources.

- AWS account default limit of 20 EC2 instances.
- Use an IAM role to manage temporary credentials for applications that run on an EC2 instance.
- When you use a role, you don't have to distribute long-term credentials to an EC2 instance.

## IAM API keys

API Access Keys are required to make programmatic calls to AWS from the:

- AWS CLI, Tools for Windows Powershell, AWS SDKs, Direct HTTP calls using the APIs for individual AWS services.
- API credentials are used by developers, working from an on-premise network, for CLI access.
- API creds work they must be associated with a user.
- Roles do not have API creds

## IAM Security Token Service (STS)

STS allows you to create temporary security credentials that grant trusted users access to your AWS resources
When requested through an STS API call, credentials are returned with three components:

- Session Token, Access Key ID, Secret Access key.

## STS API Calls

    AssumeRole: Cross-Account Delegation and Federation Through a Custom Identity Broker
    AssumeRoleWithWebIdentity: Federation through a Web-based Identity Provider
    AssumeRoleWithSAML: Federation Through an Enterprise Identity Provider Compatible with SAML 2.0
    GetFederationToken: Federation Through a Custom Identity Broker
    GetSessionToken: temporary credentials for users in untrusted environments

## STS Benefits

    No long term AWS security creds in an application
    Grant access to AWS resources without having to create an IAM identity for them.
    Temp creds, no rotation or revoke.

## Identity Federation

    Enterprise identity Federation (authenticate through your companies network)
    STS supports Security Assertion Markup Language (SAML), which allows for use of Active directory
    Web Identity Federation (3rd party identity providers, google, amazon)

## Roles for Cross-Account Access

    Used for organizations that have more than one AWS account

## Roles for Amazon EC2 (and other AWS services)

    Grant access to an application running on an EC2 instance to access other AWS services without having to imbed credentials.

## IAM Policies

- A policy is a docuement that formally states one or more permissions
- By default, an explicit deny always overrides an explicit allow.
- IAM provides pre-built policy templates to assign to users and groups.
- More than one policy can be attached to a user or group at the same time.
- Policies cannot be directly attached to AWS resources.

## IAM Roles

A role is something that another entity can assume and in doing so acquires the specific permissions defined by the role.
Entities that can assume a role include AWS resources (such as an EC2 instance) OR a non-AWS account holder who may need temporary access to an AWS resource (through a service like Active Directory)

### Roles must be used because policies cannot be directly attached to AWS services

    if you are using an EC2 instance and it needs to access an S3 bucket:
    Instance should assume a role from IAM with the proper required permissions (S3 read-only)
    Instance can the perform actions based on the role it assumes (read from S3)
    assign a role to an EC2 instance during EC2 creation process.  Afterwards use CLI or EC2 management console.
    EC2 instance can only have ONE role attached at a time.

### Other uses of roles

    other users can assume a role for temporary access to AWS accounts and resources through Active Directory or single sign-on service (facebook, google) assume an Identity Provider Access Role.
    Create cross account access where a user from one account can assume a role with permissions in another account.
