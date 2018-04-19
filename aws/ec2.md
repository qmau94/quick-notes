# Elastic Compute Cloud - EC2

## Định nghĩa
Một dịch vụ web cung cấp khả năng tính toán đám mây, giảm thời gian boot và cho phép scale up & down tuỳ thuộc vào nhu cầu tính toán.

Chỉ yêu cầu chỉ trả phần tài nguyên sử dụng, cung cấp các ứng dụng sửa lỗi cho các scenarios đơn giản.

## Options
- On demand - cho phép chi trả theo giờ hoặc giây.
  - Người sử dụng muốn giá thấp, sử dụng tài nguyên EC2 một cách linh hoạt, không cần trả trước hay cam kết dài hạn
  - Ứng dụng trong thời gian ngắn, không dự đoán được workload.
  - Ứng dụng đang được phát triển hoặc thử nghiệm trên EC2 lần đầu tiên.
- Reserved - cung cấp một lượng tài nguyên định trước, giá sẽ giảm theo giờ với mỗi instance, 1-3 year terms
  - Ứng dụng đang hoạt động ổn định và có thể dự đoán đc workload.
  - Ứng dụng yêu cầu cung cấp một lượng tài nguyên ổn định.
  - Người dùng có thể chi trả trước chi phí, bù lại sẽ giảm được giá thành (RI-reserved instance)
    - Standard RI's (giảm tối đa 75% so với on demand)
    - Convertible RI's (giảm tối đa 54% so với on demand), có khả năng thay đổi các thông số của RI (bằng hoặc hơn).
    - Schedule RI's, nếu dự đoán được những ngày cần lượng tài nguyên lớn có thể đăng ký gói này.
- Spot - cho phép chọn giá với một lượng tài nguyên, tiết kiệm chi phí nếu ứng dụng có thời gian sử dụng không cố định. Tuỳ thuộc vào thị trường.
  - Có thời gian hoạt động linh hoạt
  - Có khả năng hoạt động với giá thành tính toán nhỏ
  - Người dùng có nhu cầu cấp thiết mở rộng tài nguyên tính toán.
- Dedicated hosts - máy chủ EC2. Có thể giảm chi phí với một server cố định.
  - Có thể mua theo hình thức on demand (hourly)
  - Có thể mua với revervation với giả giảm 70% so với on demand

![ec2-types](https://scontent-nrt1-1.xx.fbcdn.net/v/t1.0-9/30443448_10214041446144479_5798647282043715584_o.jpg?_nc_cat=0&oh=12b358c1cceeacf9ad6175b040b7548b&oe=5B6A76F5)
- EC2 Intance Types

|||
|--|--|
|D| for Density - Dense Storage|
|I| for IOPS - Highspeed Strorage|
|R| for RAM  - Memory Optimized|
|T| cheap general purpose (t2 micro)|
|M| Main choice - General Purpose|
|C| for Compute - Compute Optimized|
|G| for Graphics - Graphic Intensive|
|F| FPGA - Field Programmable Gate Array|
|P| Graphic/ General Purpose GPU (Pics)|
|X |Memory Optimized|

**DR Mc GIFT PX**

- Elastic Block Storage - EBS
  - Tạo storage volumes sử dụng trong EC2. Hệ thống sử dụng phía trên EBS có thể sử dụng block storage cho việc tạo database,... EBS được đặt trong một Available zone (AZ) và được replicate để bảo vệ khỏi sự cố.
  - Types
    - **General purpose SSD (GP2)**
      - sử dụng với mục đích thông thường, cân bằng giữa giá và performance.
      - Tỉ lệ 3 IOPS per GB lên đến 10.000IOPS, có thể kéo dài với 3000 IOPS với volume 3334GiB.
    - **Provisioned IOPS SSD (IO1)**
      - Sử dụng cho các ứng dụng có nhiều tác vụ I/O, ví dụ như database.
      - Nếu cần trên 10.000IOPS
      - Có thể lên tới 20.000IOPS
    - **Throuhput Optimized HDD(ST1)**
      - Big data
      - Data warehouse
      - Log processing
      - Các dữ liệu tuần tự
      - Không được sử dụng làm boot volume
    - **Cold HDD (SC1)**
      - Cho các workload được truy cập ít, giá thành rẻ
      - File server
      - Không thể sử dụng làm boot volume
    - **Magnetic (Standard)**
      - Giá per GiB rẻ nhất trong các loại EBS volume được sử dụng để boot. Sử dụng cho các dữ liệu ít được truy cập và các ứng dụng quan trọng giá thành rẻ.
  - EBS và EC2 instance cần ở trong cùng một AZ.
  - Có thể modify tất cả các volume trừ magnetic.
  - Để sử dụng EBS ở AZ này với EC2 instance ở AZ khác cần tạo snapshot rồi tạo lại volume ở AZ muốn chuyển tới.
  - Có thể thay đổi volume type khi tạo mới từ snapshot.
  - Cần copy snapshot sang một region khác nếu muốn sử dụng.
  - Có thể tạo AMI từ snapshot để launch một EC2 instance (có thể bán trên AMI Marketplace), có thể sử dụng AMI để tạo một EC2 instance ở region khác.
- RAID (Redundant Array of Indepentdent Disks)
    - RAID 0 - Striped, No redundancy, Good Performance
    - RAID 1 - Mirrored, Redundancy
    - RAID 5 - Good for reads, bad for writes, AWS does not recommend ever putting RAID 5's on EBS.
    - RAID 10 - Striped & Mirrored, Good Redundancy, Good Performance.
    - Not enough disk IO, add multiple EBS volumes and configure them as a RAID array.
    - Snapshot by RAID volumes:
      - Take an application consistent snapshot:
        - Stop the application from writing to disk.
        - Flush all caches to the disk.
        - How can we do this?
          - Freeze the file system
          - Unmount the RAID array
          - Shutting down the associated EC2 instance.
- Tạo một EC2 instance
  - Termination Protection is off by default, you must turn it on.
  - On an EBS-backed instance, the default action is for the root EBS volume to be deleted when the instance is terminated.
  - EBS root volume of your default AMI's can not be encrypted. You can alse use a third party tool (such as bit locker) to encrypt the root volume, or this can be done when creating AMI's in the AWS console or using API.
  - Additional volumes can be encrypted.
- Security groups
  - Virtual firewall controls traffic in and out instances.
  - All inbound traffic is blocked by default.
  - All outbound traffic is allowed by default.
  - Changes to Security Groups take effect immediately.
  - You can have any number of EC2 instances within a security group.
  - You can have multiple security groups attached to EC2 instances.
  - Security Groups are STATEFUL:
    - If you create an inbound rule allowing traffic in, that traffic is automatically allowed back out again.
  - You can not block specific IP addresses using Security Groups, instead use Network Access Control Lists.
  - You can specify allow rules, but not deny rules.
- Volumes and Snapshots
  - Volumes exist on EBS:
    - Virtual Hard Disk
  - Snapshots exist on S3
  - Snapshots are point in time copies of Volumes.
  - Snapshots are incremental - this means that only the blocks that have changed since your last snapshot are moved to S3.
  - First snapshot takes time to be created.
  - To create a snapshot for Amazon EBS volumes that serve as root devices, you should stop the instance before taking the snapshot.
  - However you can take a snap while the instance is running.
  - You can create AMI's from both Volumes and Snapshots.
  - You can change EBS volume sizes on the fly, including changing the size and storage type. 
  - Volumes will ALWAYS be in the same available zone as the EC2 instance.
  - To move an EC2 volume from one AZ/region to another, take a snap or image of it, then copy it to the new AZ/region.
  - Snapshots of encrypted volumes are encrypted automatically.
  - Volumes restored from encrypted snapshots are encrypted automatically.
  - You can share snapshots, but only if they are unencrypted.
    - These snapshots can be shared with other AWS accounts or made public.
  - Best practice: 
    - Stop the instance
    - Create a snapshot
    - Copy to the new region
    - Create AMI from copied snapshots 
  - Security:
    - Snapshots of encrypted volumes are encrypted automatically.
    - Volumes restored from encrypted snapshots are encrypted automatically.
    - You can share snapshots, but only if they are unencrypted.
      - These snapshots can be shared with other AWS accounts or made public.
- Amazon Machine Image AMI
  - AMI Types (EBS and Instance store)
    - Region 
    - Operating system
    - Architecture
    - Launch Permissions
    - Storage for the Root device (Root Device Volume)
      - Instance Store (EPHEMERAL STORAGE)
        - Can not stop the instance.
        - If the instance failed, basically you lost the instance.
        - The root device for an instance launched from the AMI is an instance store volume created from a template store in Amazon S3.
      - EBS Backed Volumes
        - The root device for an instance launched from the AMI is an Amazon EBS volume created from an EBS snapshot.
        - Can stop the instance. Load Balancer & Health checks
- Elastic Load Balancers:
  - Instances monitored by ELB are reported as: InService, or OutService
  - Health Checks check the instance health by talking to it
  - Have their own DNS name. You are never given an IP address.
  - Focus on classic load balancers.
- Cloud watch
  - Standard Monitoring = 5 minutes
  - Detailed Monitoring = 1 minutes
  - Dashboard - Create dashboard to see what is happening with your AWS environment
  - Alarms - set Alarms that notify you when particular thresholds are hit.
  - Events - CloudWatch Events helps you to respond to state changes in your AWS resources.
  - Logs  - helps you aggregate, monitor, and store logs.
  - Cloud watch - logging, monitoring of a resources. Cloud Trail monitoring all AWS services.
- AWS-CLI
  - Save credentials under .aws folder → big security risk
- IAM Roles với EC2
  - Using roles instead of credentials for easy control and security.
- Bootstrap Scripts
  - Script starts and EC2 start-up.
  - Start up with `#/!bin/bash` to run as root privilige.
- Tạo một configuration group
- Auto scaling
  - 
- Elastic File System EFS
- Lambda
- Serverless webpage với lambda và API gateway
- Serverless website với Polly
- Alexa skill
- HPC High Performance Compute



## Exam tips
- Pricing models
  - On Demand
  - Spot
    - If you terminate the instance, you pay for the hour
    - If AWS terminate the spot instance, you get the hour it was terminated in for free.
  - Reserved
  - Dedicated Hosts
- EBS
  - SSD, General purpose - GP2 - up to 10.000 IOPS
  - SSD, Provisioned IOPS - IO1 - more than 10.000 IOPS
  - HDD, Throughput Optimized - ST1 - frequently accessed workloads
  - HDD, Cold - SC1 - less frequently accessed data.
  - HDD, Magnetic - Standard - cheap, infrequently accessed storage.
- EBS vs Instance Store 
  - Instance Store Volumes are sometimes called Ephemeral Storage.
  - Instance Store Volumes can not be stopped. If the unerlying host fails, you will lose your data. 
  - EBS backed instances can be stopped. You will not lose the data on this instance if it is stopped.
  - You can reboot both, you will not lose your data.
  - By default, both ROOT volumes will be deleted on termination, however with EBS volumes, yo can tell AWS to keep the root device volume.
- multiple EC2 instances can not mount the same EBS, use EFS instead.
- EC2 Types
  **DR Mc GIFT PX**
  - D
  - R
  - M
  - C
  - G
  - I
  - F
  - T
  - P
  - X
- One subnet = one AZ

- [ELB FAQs](https://aws.amazon.com/elasticloadbalancing/faqs/)
- [EC2 FAQs](https://aws.amazon.com/ec2/faqs/)
- [EC2 ]()
