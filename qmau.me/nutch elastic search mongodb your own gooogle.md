Cũng tầm này 2 năm trước mình đang vật lộn ở nhà với 1 cái chân bó, 1 đồ án chưa xong và mất đến 3 ngày để cài đặt môi trường cho cái 2 con server được thầy hướng dẫn cấp cho.

Để xây dựng google cho bản thân, stack mình chọn sẽ là:
- Apache Nutch 2.3.1
- Elastic Search 6.2.3
- Apache Ant 1.10.3
- MongoDB 3.6.0


## Cài đặt môi trường
- Tạo thư mục tools

```bash
mkdir tools
cd tools
```

### Apache Ant 1.10.3
- Mục đích cài chỉ để build nutch để tiến hành crawl
- Download bản binary [tại trang chủ của Ant](https://ant.apache.org/bindownload.cgi)
- Giải nén, để vào thư mục tools và thêm PATH trong CLI
```bash
vi ~/.bashrc
```
`.bashrc`
```

```
