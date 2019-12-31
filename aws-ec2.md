# AWS EC2

## EC2 Essentials

- **Amazon Machine Image (AMI):** *Operating system and other settings*
- **Instance Type:** *The hardware*
- **Network Interface:** *Public, private, elastic IP addresses*
- **Storage: Elastic Block Store (EBS):** *Instance Store - ephemeral storage*

>A security group must be assigned to an instance during creation process, each instance must be placed into an existing VPC, availablity zone, subnet.

- Bootstrapping - custom launch commands can be passed into the instance during launch - user-data scripts
- Tags - can be used to name, organize instances
- Limits - to the number of instances in a region at a particular time.

### [EC2 instance types]

- t2: General Purpose - burstable performance instances
- m3: General Purpose - Nice balance
- c3/c4: Compute Optimized - For high traffic front end fleets, web servers
- d2: Storage Optimized - For Large-scale data warehouse or parallel file systems
- i2: Storage Optimized - For Large-scale data warehouse or parallel file systems
- g2: GPU Optimized - For machine learning, high performance databases, rendering
- p2: GPU Optimized - For machine learning, high performance databases, rendering
- r3/r4: Memory Optimized - For databases, memcached, large deployments of enterprise applications
- x1: Memory Optimized - For databases, memcached, large deployments of enterprise applications

### [EC2 IP addresses]

- Private IP address: All EC2 instances are automatically created with a private IP address.  Private IP address is used for inside VPC communications
- Public IP Address: you have the option to enable (auto-assign) a Public IP address.  Auto-assigning is based on the setting for the selected subnet the instance is provisioned in.
- Elastic IP Address: An EIP is a static IPv4 address and is a public IPv4 address.  With an EIP you can attach a public IP address to an EC2 instance that was created with only a private IP address or mask a failure of an instance by remapping to another instance.  Attaching an EIP to an instance will replace its default public IP address.

### [EC2 Purchasing Options]

#### On-Demand

Can only have 20 instances of this type running at the same time
Most expensive and flexible.  Only charged when running.
Per second pricing - Amazon Linux and Ubuntu AMIs (60s billing minimum)
Hourly pricing - Windows and RHEL

#### Reserved

Purchase an instance for a set time period of 1 or 3 years
Significant price discount over on-Demand
Responsible for entire price, whether using it or not.

#### Spot

Bid on instance type and only pay for and use that instance when the spot price is equal to or below your bid price
When you have an active bid, an instance is provisioned for you when the spot price is equal or below, and is terminated automatically when the price goes greater than your bid

### [EC2 Placement Groups]

- Placement group is a cluster of instances within the same availablity zone.  Used for applications that require an extremely low latency network between them.
AWS attempts to place all instances as close as physically possible in the datacenter to reduce latency.
- Instances that are in placement group have low-latency, 10Gbps network connection between them, also need to have enhanced networking in order to maximize placement Groups
- Instance in placement group is stopped, once started again it will continue in the placement group.
- Launch all required instances in placement group in a single request, and all instances be the same instance type.
- If more instances are added or a stopped instance is started and receive an error "Insufficient capacity" stop all instances and start all of them in a single command
- Instances not originally launched or created in placement group cannot be moved into the placement group.  Placement groups cannot be merged, nor span availablity zones.
- PG names must be unique within your own AWS account
- PGs can be connected

## EC2 Storage

### [Elastic File System (EFS)]

- EFS is a storage option for EC2 that allows for scalable storage option
- EFS storage capacity is elastic - The capacity will increase and decrease as you add or remove files.  applications running on EC2 using EFS will always have storage, without the need to provision larger storage devices.
- EFS is fully-managed and supports NFSv4, and best performance when using AMI Linux kernel 4.0 or newer
- EFS file system can be accessed by one or more EC2 instances at the same time, can be mounted to on-prem server using AWS direct connect.
- EFS can scale to petabytes in size, low-latency and high levels of throughput
- Only pay for the amount of storage you are using.
- Encrypt data at rest using AWS Key Management Service (KMS)
- Big Data and analytics
- Media processing worflows
- Web Serving & Content Management

### [Elastic Block Store (EBS)]

- EBS volumes are persistent and can live beyond the life of the EC2 they are attached to.
- EBS volumes are NAS, can be attached/detached for or from EC2 instances, but only to ONE EC2 instance at a time.
- EBS volumes can be backed up into snapshots - which can be restored into new EBS volumes
- EBS volumes measure performance in IOPS - input/output operations per second.  AWS measures IOPS in 256kb chunks, operations that are greater than 256kb are seperated into individual 256kb chunks
- Volumes created from an EBS snapshot must be initialized

### [EBS Volume Types]

- General Purpose SSD: use for dev/test environments and smaller DB instances, performance of 3 IOPS/GiB (burstable with baseline performance).  Volume size of 1GB to 16TB.
- Provisioned IOPS SSD: used for mission critical applications that require sustained IOPS performance.  Large DB workloads, Volume size 4GB to 16TB.  performance at provisioned level and can provision up to 20,000 IOPS per volume
- Magnetic: low storage cost, data not accessed often.  Volume size 1GB to 1TB

### [EC2 Instance Store Volumes]

- Instance-store volumes are virtual devices whose underlying hardware is physically attached to the host computer that is running the instance.
- Instance store volumes are ephemeral data, only exists for the duration of the life of the instance
- Once instance is stopped or shutdown the data is erased, a reboot will still maintain ephemeral data.

### [EBS Snapshots]

- Snapshots are point-in-time backups of EBS volumes that are stored in S3.
- Snapshots are incremental in nature
- A snapshot ony stores the changes since the most recent snapshot, thus reducing costs
- However if the original snapshot is deleted, all data is still available in all the other Snapshots
- Even though snapshot storage only charges you fo rhte amount of incremental data in each snapshot all prior data is still there
- Snapshots can be used to create fully restored EBS volumes
- Frequent snapshots of your data increases data durability - recommended
- When a snapshot is being taken against the EBS volume, it can degrade performance so snapshots should occur during non-production or non-peak load hours
