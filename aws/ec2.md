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

- Tạo một EC2 instance
- Security group
- Volumes and Snapshots
- Amazon Machine Image AMI
- Load Balancer & Health checks
- Cloud watch
- AWS-CLI
- IAM Roles với EC2
- Bootstrap Scripts
- Tạo một configuration group
- Auto scaling
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
-

- [EC2 FAQs](https://aws.amazon.com/ec2/faqs/)
- [EC2 ]()
