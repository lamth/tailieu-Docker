# Một vài ghi chú trong quá trình tìm hiểu docker.

## CMD vs RUN vs ENTRYPOINT
- **RUN** sẽ thực thi lệnh chỉ trong quá trình build image. Thường được sử dụng để cài gói và sẽ tạo ra một image layer mới.

- **CMD** được dùng để cấu hình câu lệnh mặc định khi chạy container, nó có thể bị ghi đè khi viết lệnh docker run.

- **ENTRYPOINT**: Cấu hình lệnh, file thực thi để chạy khi container chạy, không bị ghi đè lệnh khác với lệnh docker run.



## Đẩy log của nginx ra stdout và stderr
```dockerfile
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
```


## Một vài cách để cấu hình ứng dụng trong Docker container.
### 1. Copy cấu file cấu hình vào trong Container.
Chuẩn bị sẵn file cấu hình và COPY vào container, hoặc tiến hành sử file config của ứng dụng với `echo` hoặc `sed` thông qua RUN trong quá trình build image.

### 2. Cấu hình động sử dụng biến môi trường.
Đây là cách cấu hình phổ biến cho các image trên docker hub.
Khi chạy container, cấu hình giá trị cho các biến môi trường( ví dụ `docker run -e -e MYSQL_ROOT_PASSWORD=123456 -d mysql:latest`). Sau đó, container entrypoint sẽ kiểm tra các biến môi trường và `sed` hay `echo` để cấu hình ứng dụng.

### 2.1. Cấu hình động thông qua Key-Value database.
Thay vì dùng biến môi trường, có thể cấu hình để entrypoint sẽ kết nối đến một Key-valua database trong mạng như `etcd` hay `consul` để lấy thông tin cấu hình.
Sau đó có thể cấu hình ứng dụng trong container bằng cách chỉnh sửa các giá trị trên KV database.


### 3. Cấu hình thông qua docker volume
Docker volume cho phép ánh xạ file, thư mục trên host vào container. Từ đó có thể ánh xạ file cấu hình từ host vào file cấu hình của ứng dụng trong container để có thể trực tiếp chỉnh sửa cấu hình của ứng dụng từ host.



## Build image từ scratch
scratch là một image trống, nên khi build image từ scratch(`FROM scratch`) thì image được tạo ra gần như là không có base image, Docker cũng sẽ không tạo một layer cho câu lệnh`FROM scratch`. 

Việc này đem lại bảo mật khi chúng ta hoàn toàn có thể kiểm soát soure code, filesystem của image.



## Chạy và tắt các service của docker compose theo thứ tự.

Bình thường dùng `depends_on` để khởi động container theo thứ tự nhưng nó chỉ phụ thuộc vào việc container đã chạy hay chưa mà không quan tâm đến trạng thái của dịch vụ chạy bên trong container đó.

Cách tốt nhất là thiết kế thêm cho ứng dụng chức năng tự động kết nối lại khi gặp lỗi.

Dùng script để đợi như kiểu:
```
version: "2"
services:
  web:
    build: .
    ports:
      - "80:8000"
    depends_on:
      - "db"
    command: ["./wait-for-it.sh", "db:5432", "--", "python", "app.py"]
  db:
    image: postgres
```
để kiểm tra các dịch vụ khác trước khi chạy ứng dụng chính.

Thực gia nếu là version 2.1 thì có cái `condition: service_healthy` kiểu dựa theo healcheck của dịch vụ khác:
```
version: '2.1'

services:
  app:
    build: app/.
    depends_on:
      rabbit:
        condition: service_healthy
    links: 
        - rabbit

  rabbit:
    build: rabbitmq/.
    ports: 
        - "15672:15672"
        - "5672:5672"
    healthcheck:
        test: ["CMD", "curl", "-f", "http://localhost:15672"]
        interval: 30s
        timeout: 10s
        retries: 5
```
https://stackoverflow.com/questions/31746182/docker-compose-wait-for-container-x-before-starting-y/41854997#41854997




# some thing else:

https://www.docker.com/blog/docker-golang/

- Kinh ngiệm build image:
https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

## ~~the end of~~ the begining................