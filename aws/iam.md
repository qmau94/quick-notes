# Indentity and Access Management - IAM 
## Định nghĩa
Là một service giúp quản lý User trong hệ thống AWS.
## Các khái niệm
1. User
Là người sử dụng hệ thống.
2. Group
Các group user sử dụng hệ thống
3. Policies
Là các quyền truy cập, quản lý các tài nguyên của hệ thống.
4. Roles
Các chức danh dành cho user, có thể phân quyền cho các user từ ứng dụng thứ 3 hoặc bằng các định danh (indentifier) từ các hệ thống khác.

## Notes:
- IAM được cài đặt global, không theo region.
- Người dùng mới, chưa được phân quyền → no access đến tất cả resource.
- Root account không cần IAM, người dùng có quyền như root account là Power User.
- Secret ID, secret key có thể dùng để đăng nhập, quản lý hệ thống từ các phần mềm, CLI,... secret key chỉ hiển thị 1 lần → cần chú ý.
- MFA (Multi-Factor Authentication) giúp tăng tính bảo mật cho tài khoản AWS
