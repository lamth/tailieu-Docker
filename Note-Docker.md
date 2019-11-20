# Một vài ghi chú trong quá trình tìm hiểu docker.

## CMD vs RUN vs ENTRYPOINT
- **RUN** sẽ thực thi lệnh chỉ trong quá trình build image. Thường được sử dụng để cài gói và sẽ tạo ra một image layer mới.

- **CMD** được dùng để cấu hình câu lệnh mặc định khi chạy container, nó có thể bị ghi đè khi viết lệnh docker run.

- **ENTRYPOINT**: Cấu hình lệnh, file thực thi để chạy khi container chạy, không bị ghi đè lệnh khác với lệnh docker run.


## ADD vs COPY


## Đẩy log của nginx ra stdout và stderr
```dockerfile
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
```


