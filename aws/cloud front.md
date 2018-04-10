# Cloud Front

## Định nghĩa và các khái niệm
- Content delivery network (CDN) là một hệ thống phân tán các server (network) chịu trách nhiệm truyền tải webpages, web content đến với người dùng dựa theo vị trí địa lí của người dùng và vị trí của webserver.
- Edge location - Là nơi content được cache và có tại các AWS regions/AZ (AWS có khoảng 50 ELs)
- Origin - là nơi chứa các file mà CDN sẽ phân phối (s3, ec2, elastic load balancer, route53)
- Distribution - Tên của CDN chứa các Edge locations
- **Amazon Cloud Front** có thể được sử dụng để deliver toàn bộ website (tĩnh, động, stream, interactive content) nhờ sử dụng hệ thống edge location. Request lấy content sẽ được chuyển đến EL gần nhất, content sẽ được chuyển đến với performance tốt nhất. Kết hợp cùng S3, EC2, Elastic load balancer, route53 và cả các non-AWS server.
- Web distribution
- RTMP - Media streaming

## Exam tips:
- Edge location != AWS region/az
- Origin
- Distribution - cdn consists of a collection Edge locations
  - web distribution: thường dùng cho website
  - RTMP: dùng cho media streaming
- Edge location is not READ only, you can write them too (ie put an object on to them)
- Object được cache với TTL (time to live)
- Có thể clear cached objects nhưng sẽ bị charge.
