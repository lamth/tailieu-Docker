# Build và chạy Apache Container
## 1.Các bước thực hiện build image và chạy container từ image
### Bước 1: Tạo thư mục 
Tạo thư mục để chứa *Dockerfile* và các file cần thiết cho quá trình build image:
```
# mkdir /root/httpd
```
### Bước 2: Tạo một trang web ví dụ với tên là index.html trong httpd
```bash 
# cd /root/httpd
# vim index.html
```
```html
<!DOCTYPE html>
<html>
<body>
<h1>Đây là web test</h1>
</boby>
</html>
```
### Bước 3: Tạo và sửa file `Dockerfile`
```bash
# cd /root/httpd
# vim Dockerfile
```
```Dockerfile
FROM centos:centos7 

MAINTAINER lamth99

RUN yum -y install httpd

COPY index.html /var/www/html

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80
```
### Bước 4: Build image với lệnh `docker build`
Dùng lệnh `docker build` chỏ đến thư mục chứa dockerfile(/root/httpd) và thêm option `-t` để đặt tag cho image(httpd:test).

Docker sẽ tiến hành build image *httpd:test* theo chỉ dẫn trong **Dockerfile**.

```bash
# docker build /root/httpd -t httpd:test

Sending build context to Docker daemon  3.072kB
Step 1/6 : FROM centos:centos7
centos7: Pulling from library/centos
8ba884070f61: Pull complete 
Digest: sha256:b5e66c4651870a1ad435cd75922fe2cb943c9e973a9673822d1414824a1d0475
....
Successfully built 15a884002e64
Successfully tagged httpd:test
```
### Bước 5: Chạy container từ image vừa tạo
```bash
# docker run -d -p 8080:80 httpd:test
```

Lệnh trên chạy container từ image *httpd:test* với một số tùy chọn: `-d` là để chạy container background, `-p 8080:80` là để public port 80 của container ra port 8080 của host.

### Bước 6: Kiểm tra trên trình duyệt web 

http://localhost:8080

![](http://i.imgur.com/LMVnyr8.png)

## 2.Giải thích các lệnh trong Dockerfile

**FROM**: FROM là lệnh dùng để xác định image nền tảng cho image muốn build. Ở đây chọn image centos với tag là centos7.

**MAINTAINER** là lệnh để xác định tác giả của image

**RUN** Là lệnh để chạy lệnh, thường dùng để cài các gói, phần mềm cần thiết. Ở đây chạy lệnh `yum -y install httpd` để cài Apache cho image. 

**COPY**: Là lệnh dùng để copy một file hay thư mục từ host vào trong filesystem của container. Ở đây copy file `index.html` vào thư mục chứa web mặc định của Apache trên Centos là `/var/www/html`

**CMD**: Là lệnh dùng để chạy một lệnh nào đó ngay sau khi container được mở. Lệnh **CMD** khác với lệnh **RUN** là lệnh đặt trong RUN chỉ chạy khi build docker image, còn lệnh đặt trong CMD thì sẽ chạy mỗi lần ngay sau khi container chạy và chỉ có một lệnh CMD trong một Dockerfile. Ở đây, CMD chạy lệnh `/usr/sbin/httpd -D FOREGROUND` để chạy dịch vụ apache ở foregroud giúp apache khởi động mỗi lần chạy container.

**EXPOSE**: Là lệnh dùng để xác định một port mà container sẽ chạy dịch vụ và lắng nghe trên port đó. Ở đây, dịch vụ Apache webserver hoạt động trên port 80 nên chúng ta cần expose port này.



