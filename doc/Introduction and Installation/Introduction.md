# Introduction
- Ở thời kì bắt đầu cuộc các mạng CNTT, hầu hết các ứng dụng được triển khai trực tiếp lên các phần cứng vật lý, qua các hệ điều hành máy chủ. Do không gian người dùng là duy nhất nên thời gian chạy được chia sẻ giữa các ứng dụng. Việc triển khai như vậy ổn định, tập trung vào phần cứng và có chu kỳ bảo trì dài. Nó được quản lý bởi một bộ phận CNTT và nó đem lại rất nhiều sự thiếu linh hoạt cho các nhà phát triển. Trong trường hợp này, các tài nguyên phần cứng thường được sử dụng một cách không hiệu quả.
![](http://i.imgur.com/Dh92BrV.png)
- Để khắc phục được các nhược điểm của cách triển khai dịch vụ truyền thống, ** Ảo hóa** đã được phát minh. Với các trình ảo hóa như là KVM, XEN, EXS, Hyper-V và vân vân, chúng ta có thể giả lập phần cứng của máy ảo ( VMs) và triển khai các hệ điều hành guest trên mỗi máy ảo. các máy ảo có thể có các hệ điều hành khác so với máy chủ vật lý; nó có nghĩa là chúng ta phải quản lý cập nhật, bảo mật, hiệu năng của máy ảo đó. Với ảo hóa, các ứng dụng bị cô lập ở tầng máy ảo và được xác định bởi vòng đời của các máy ảo. Nó đem lại sự hiệu quả trong đầu tư, tăng tính linh hoạt, chi phí sẽ tăng với độ phức tạp và dự phòng cho chúng.Sơ đồ sau mô tả một môi trường ảo hóa điển hình:
![](http://i.imgur.com/Y6D2eOB.png)
- Sau ảo hóa, chúng ta đang dần tiến tới tập trung về ứng dụng CNTT hơn. Chúng ta đã xóa tầng trình ảo hóa để giảm sự giả lập phần cứng và sự phức tạp của nó. Những ứng dụng được đóng gói với môi trường của chúng và được triển khai sử dụng các **container**. OpenVZ, Solaris, and LXC là một số ví dụ về công nghệ ảo hóa sử dụng container. Các container ít linh hoạt hơn là máy ảo; ví dụ. chúng ta không thể chạy Microsoft Windows trên hệ điều hành Linux. Các container cũng được coi là kém bảo mật hơn so với máy ảo, vì với container, tất cả mọi thứ đều chạy trên hostOS. Nếu một container bị xâm phạm thì nó có khả năng chiếm toàn quyền truy cập của HostOS của container đó. Nó cũng có thể có một chút khó khăn trong quá trình thiết lập, quản lý và tự động hoá. Đó là một vài lý do khiến container chưa được sử dụng đại trà trong vài năm gần đây mặc dù chúng ta đã có công nghệ này.
![](http://i.imgur.com/jJeycz4.png)
- Với **Docker**, container đột nhiên trở thành "công dân hạng nhất".  Tất cả các tập đoàn lớn như Google, Microsoft, IBM, Red Hat và các tập đoàn khác đều đang sử dụng container là công nghệ chủ đạo.
- Docker được khởi động như một dự án nội bộ bởi Solomon Hykes, người mà đang là CTO của Docker Inc., at dotCloud. Nó được phát hành dưới dạng mã nguồn mở vào tháng 3 năm 2013 theo giấy phép của Apache 2.0.
- Docker sử dụng các tính năng kernel cơ bản của Linux để có thể container hóa. Sơ đồ sau mô tả các driver thực thi và các tính năng kernel mà được sử dụng bởi Docker.
![](http://i.imgur.com/cAyN90F.png)









 Written with [StackEdit](https://stackedit.io/).
