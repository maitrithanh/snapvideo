# 📥 SnapVideo - Video Downloader

Phần mềm tải video miễn phí hỗ trợ hơn 1000+ nền tảng như YouTube, Facebook, TikTok, Instagram, Twitter và nhiều nền tảng khác!

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Python](https://img.shields.io/badge/python-3.7+-green)
![License](https://img.shields.io/badge/license-MIT-orange)

## ✨ Tính năng

- 🎬 **Hỗ trợ nhiều nền tảng**: YouTube, Facebook, TikTok, Instagram, Twitter, Vimeo và hơn 1000+ website khác
- 🎯 **Chọn chất lượng video**: Tải video ở chất lượng 1080p, 720p, 480p, 360p hoặc tốt nhất có thể
- 🎵 **Tải âm thanh**: Chuyển đổi video thành file MP3
- 🎨 **Giao diện đẹp mắt**: Thiết kế hiện đại, dễ sử dụng
- ⚡ **Tải nhanh**: Sử dụng yt-dlp engine mạnh mẽ
- 📊 **Theo dõi tiến trình**: Hiển thị tiến trình tải xuống real-time
- 💾 **Tự do chọn thư mục**: Lưu video vào thư mục bạn muốn

## 📋 Yêu cầu hệ thống

- **Hệ điều hành**: Windows 10/11 (hoặc Windows 7/8 với Python 3.7+)
- **Python**: 3.7 trở lên
- **Dung lượng**: ~100MB (bao gồm các thư viện)
- **Kết nối internet**: Cần thiết để tải video

## 🚀 Cài đặt

### Bước 1: Cài đặt Python

1. Tải Python từ [python.org](https://www.python.org/downloads/)
2. Chạy file cài đặt
3. **QUAN TRỌNG**: Tick vào ô "Add Python to PATH" trước khi cài đặt
4. Click "Install Now"

### Bước 2: Cài đặt FFmpeg (Tùy chọn nhưng khuyến nghị)

FFmpeg cần thiết để tải video chất lượng cao và chuyển đổi audio.

**Cách 1: Tự động (Khuyến nghị)**
1. Mở Command Prompt (cmd) với quyền Administrator
2. Chạy lệnh:
```bash
winget install ffmpeg
```

**Cách 2: Thủ công**
1. Tải FFmpeg từ [ffmpeg.org](https://ffmpeg.org/download.html)
2. Giải nén và thêm vào PATH của Windows

### Bước 3: Cài đặt SnapVideo

1. Tải mã nguồn hoặc clone repository này
2. Mở Command Prompt (cmd) trong thư mục chứa SnapVideo
3. Chạy lệnh để cài đặt các thư viện cần thiết:

```bash
pip install -r requirements.txt
```

## 🎮 Cách sử dụng

### Phương pháp 1: Sử dụng file .bat (Dễ nhất)

1. Double-click vào file `run_snapvideo.bat`
2. Ứng dụng sẽ tự động mở

### Phương pháp 2: Chạy bằng Python

1. Mở Command Prompt trong thư mục chứa SnapVideo
2. Chạy lệnh:

```bash
python snapvideo.py
```

### Phương pháp 3: Chạy bằng Python (từ bất kỳ đâu)

```bash
python "đường\dẫn\đến\snapvideo.py"
```

## 📖 Hướng dẫn sử dụng

1. **Mở SnapVideo**: Chạy ứng dụng bằng một trong các phương pháp trên
2. **Dán link video**: Copy link video từ YouTube, Facebook, TikTok... và dán vào ô "Link Video"
3. **Chọn chất lượng**: Chọn chất lượng video bạn muốn (Best, 1080p, 720p, 480p, 360p hoặc chỉ Audio)
4. **Chọn thư mục lưu**: Click "Chọn thư mục" để chọn nơi lưu video (mặc định là Downloads/SnapVideo)
5. **Tải video**: Click nút "TẢI VIDEO" và đợi quá trình hoàn tất
6. **Hoàn thành**: Video sẽ được lưu vào thư mục bạn đã chọn

## 🌐 Danh sách nền tảng được hỗ trợ

- **Video Streaming**: YouTube, Vimeo, Dailymotion, Twitch
- **Social Media**: Facebook, Instagram, Twitter/X, TikTok, LinkedIn
- **Giáo dục**: Coursera, Udemy, Khan Academy, edX
- **Và hơn 1000+ website khác!**

## ⚙️ Cấu trúc thư viện

```
snapvideo/
│
├── snapvideo.py           # File chính của ứng dụng
├── requirements.txt       # Danh sách thư viện cần thiết
├── run_snapvideo.bat     # File batch để chạy nhanh trên Windows
└── README.md             # File hướng dẫn này
```

## 🐛 Xử lý lỗi thường gặp

### Lỗi: "Python is not recognized"
- **Nguyên nhân**: Python chưa được thêm vào PATH
- **Giải pháp**: Cài đặt lại Python và nhớ tick "Add Python to PATH"

### Lỗi: "No module named 'yt_dlp'"
- **Nguyên nhân**: Chưa cài đặt thư viện
- **Giải pháp**: Chạy `pip install -r requirements.txt`

### Lỗi: "Unable to download video"
- **Nguyên nhân**: Link không hợp lệ hoặc video bị giới hạn khu vực
- **Giải pháp**: Kiểm tra lại link hoặc thử với video khác

### Lỗi khi tải video chất lượng cao
- **Nguyên nhân**: Thiếu FFmpeg
- **Giải pháp**: Cài đặt FFmpeg theo hướng dẫn ở trên

### Video không có âm thanh
- **Nguyên nhân**: Thiếu FFmpeg để merge audio và video
- **Giải pháp**: Cài đặt FFmpeg hoặc chọn chất lượng thấp hơn

## 🔧 Cập nhật

Để cập nhật SnapVideo và các thư viện:

```bash
pip install --upgrade -r requirements.txt
```

## 🏗️ Build phần mềm (Dành cho Developer)

### Build file .EXE (Standalone executable)

Nếu bạn muốn tạo file `.exe` độc lập không cần cài Python:

**Bước 1: Cài đặt PyInstaller**
```bash
pip install -r requirements-dev.txt
```

**Bước 2: Build bằng script tự động**
```bash
# Double-click file hoặc chạy:
build_exe.bat
```

**Hoặc build thủ công:**
```bash
pyinstaller --clean snapvideo.spec
```

Kết quả: File `SnapVideo.exe` (~30-50MB) có thể chạy trên bất kỳ máy Windows nào mà không cần Python!

### Tạo Installer (Setup.exe)

Để tạo installer chuyên nghiệp với wizard:

**Bước 1: Cài đặt Inno Setup**
- Tải từ [jrsoftware.org](https://jrsoftware.org/isdl.php)
- Cài đặt với các tùy chọn mặc định

**Bước 2: Build installer**
```bash
# Double-click file hoặc chạy:
build_installer.bat
```

Kết quả: File `SnapVideo_Setup_v1.0.0.exe` trong thư mục `output/`

📚 **Xem hướng dẫn chi tiết**: `HUONG_DAN_BUILD.txt`

### Phân phối

Sau khi build, bạn có thể:
- ✅ Chia sẻ file `.exe` trực tiếp
- ✅ Upload installer lên GitHub Releases
- ✅ Tạo website download
- ✅ Chia sẻ qua Google Drive, Dropbox, etc.

## 📝 Lưu ý pháp lý

- Phần mềm này chỉ dùng cho mục đích cá nhân và học tập
- Người dùng tự chịu trách nhiệm về việc sử dụng phần mềm
- Tôn trọng bản quyền và điều khoản sử dụng của các nền tảng
- Không sử dụng để tải nội dung vi phạm bản quyền

## ❤️ Hỗ trợ dự án

Nếu bạn thấy SnapVideo hữu ích, hãy hỗ trợ phát triển!

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/maitrithanh)
[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/maitrithanh)

Hoặc star ⭐ repository này để ủng hộ!

## 🤝 Đóng góp

Mọi đóng góp đều được chào đón! Nếu bạn có ý tưởng cải thiện hoặc tìm thấy lỗi, hãy tạo issue hoặc pull request.

## 📄 Giấy phép

MIT License - Xem file LICENSE để biết thêm chi tiết

## 👨‍💻 Tác giả

Được phát triển với ❤️ bởi SnapVideo Team

## 🙏 Cảm ơn

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - Thư viện tải video mạnh mẽ
- [FFmpeg](https://ffmpeg.org/) - Công cụ xử lý video/audio
- Tất cả người dùng và contributors

## 📞 Liên hệ & Hỗ trợ

Nếu bạn gặp vấn đề hoặc có câu hỏi:
- 📧 Email: support@snapvideo.com
- 🐛 Báo lỗi: Tạo issue trên GitHub
- 💬 Thảo luận: Tham gia discussions

---

**⭐ Nếu bạn thấy hữu ích, đừng quên để lại một ngôi sao!**

Chúc bạn sử dụng vui vẻ! 🎉

