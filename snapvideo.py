"""
SnapVideo - Video Downloader
Phần mềm tải video từ YouTube, Facebook, TikTok và nhiều nền tảng khác
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
import threading
import os
import sys
from pathlib import Path
import yt_dlp


class VideoDownloader:
    def __init__(self, root):
        self.root = root
        self.root.title("SnapVideo - Video Downloader")
        self.root.geometry("800x600")
        self.root.resizable(True, True)
        
        # Đặt màu nền và style
        self.root.configure(bg="#1e1e2e")
        
        # Biến lưu trữ
        self.download_path = str(Path.home() / "Downloads" / "SnapVideo")
        self.is_downloading = False
        
        # Tạo thư mục download mặc định
        os.makedirs(self.download_path, exist_ok=True)
        
        self.setup_ui()
        
    def setup_ui(self):
        """Thiết lập giao diện người dùng"""
        
        # Header
        header_frame = tk.Frame(self.root, bg="#2d2d44", height=80)
        header_frame.pack(fill="x", padx=0, pady=0)
        header_frame.pack_propagate(False)
        
        title_label = tk.Label(
            header_frame,
            text="📥 SnapVideo",
            font=("Segoe UI", 28, "bold"),
            bg="#2d2d44",
            fg="#00d4ff"
        )
        title_label.pack(pady=20)
        
        # Main container
        main_frame = tk.Frame(self.root, bg="#1e1e2e")
        main_frame.pack(fill="both", expand=True, padx=20, pady=20)
        
        # URL Input Section
        url_frame = tk.Frame(main_frame, bg="#1e1e2e")
        url_frame.pack(fill="x", pady=(0, 20))
        
        url_label = tk.Label(
            url_frame,
            text="🔗 Link Video:",
            font=("Segoe UI", 12, "bold"),
            bg="#1e1e2e",
            fg="#ffffff"
        )
        url_label.pack(anchor="w", pady=(0, 8))
        
        self.url_entry = tk.Entry(
            url_frame,
            font=("Segoe UI", 11),
            bg="#2d2d44",
            fg="#ffffff",
            insertbackground="#ffffff",
            relief="flat",
            highlightthickness=2,
            highlightcolor="#00d4ff",
            highlightbackground="#3d3d5c"
        )
        self.url_entry.pack(fill="x", ipady=10, padx=2)
        self.url_entry.insert(0, "Dán link video vào đây...")
        self.url_entry.bind("<FocusIn>", self.on_entry_click)
        self.url_entry.bind("<FocusOut>", self.on_focus_out)
        self.url_entry.config(fg="#808080")
        
        # Quality Selection
        quality_frame = tk.Frame(main_frame, bg="#1e1e2e")
        quality_frame.pack(fill="x", pady=(0, 20))
        
        quality_label = tk.Label(
            quality_frame,
            text="🎬 Chất lượng video:",
            font=("Segoe UI", 12, "bold"),
            bg="#1e1e2e",
            fg="#ffffff"
        )
        quality_label.pack(anchor="w", pady=(0, 8))
        
        self.quality_var = tk.StringVar(value="best")
        quality_options = [
            ("Tốt nhất (Best)", "best"),
            ("1080p", "1080"),
            ("720p", "720"),
            ("480p", "480"),
            ("360p", "360"),
            ("Chỉ âm thanh (MP3)", "audio")
        ]
        
        quality_selector = tk.Frame(quality_frame, bg="#1e1e2e")
        quality_selector.pack(fill="x")
        
        for text, value in quality_options:
            rb = tk.Radiobutton(
                quality_selector,
                text=text,
                variable=self.quality_var,
                value=value,
                font=("Segoe UI", 10),
                bg="#1e1e2e",
                fg="#ffffff",
                selectcolor="#2d2d44",
                activebackground="#1e1e2e",
                activeforeground="#00d4ff"
            )
            rb.pack(side="left", padx=(0, 15))
        
        # Download Path Section
        path_frame = tk.Frame(main_frame, bg="#1e1e2e")
        path_frame.pack(fill="x", pady=(0, 20))
        
        path_label = tk.Label(
            path_frame,
            text="📁 Thư mục lưu:",
            font=("Segoe UI", 12, "bold"),
            bg="#1e1e2e",
            fg="#ffffff"
        )
        path_label.pack(anchor="w", pady=(0, 8))
        
        path_input_frame = tk.Frame(path_frame, bg="#1e1e2e")
        path_input_frame.pack(fill="x")
        
        self.path_entry = tk.Entry(
            path_input_frame,
            font=("Segoe UI", 10),
            bg="#2d2d44",
            fg="#ffffff",
            insertbackground="#ffffff",
            relief="flat",
            highlightthickness=2,
            highlightcolor="#00d4ff",
            highlightbackground="#3d3d5c"
        )
        self.path_entry.pack(side="left", fill="x", expand=True, ipady=8, padx=(2, 10))
        self.path_entry.insert(0, self.download_path)
        
        browse_btn = tk.Button(
            path_input_frame,
            text="📂 Chọn thư mục",
            command=self.browse_folder,
            font=("Segoe UI", 10, "bold"),
            bg="#4d4d6d",
            fg="#ffffff",
            activebackground="#5d5d7d",
            activeforeground="#ffffff",
            relief="flat",
            cursor="hand2",
            padx=20,
            pady=8
        )
        browse_btn.pack(side="right")
        
        # Progress Section
        progress_frame = tk.Frame(main_frame, bg="#1e1e2e")
        progress_frame.pack(fill="x", pady=(0, 20))
        
        self.status_label = tk.Label(
            progress_frame,
            text="⏳ Trạng thái: Sẵn sàng",
            font=("Segoe UI", 11),
            bg="#1e1e2e",
            fg="#00ff88",
            anchor="w"
        )
        self.status_label.pack(fill="x", pady=(0, 10))
        
        # Style cho progress bar
        style = ttk.Style()
        style.theme_use('default')
        style.configure(
            "Custom.Horizontal.TProgressbar",
            troughcolor='#2d2d44',
            background='#00d4ff',
            bordercolor='#2d2d44',
            lightcolor='#00d4ff',
            darkcolor='#00d4ff'
        )
        
        self.progress_bar = ttk.Progressbar(
            progress_frame,
            mode='indeterminate',
            style="Custom.Horizontal.TProgressbar",
            length=300
        )
        self.progress_bar.pack(fill="x", ipady=8)
        
        # Download Button
        button_frame = tk.Frame(main_frame, bg="#1e1e2e")
        button_frame.pack(fill="x", pady=(20, 0))
        
        self.download_btn = tk.Button(
            button_frame,
            text="⬇️ TẢI VIDEO",
            command=self.start_download,
            font=("Segoe UI", 14, "bold"),
            bg="#00d4ff",
            fg="#1e1e2e",
            activebackground="#00b8e6",
            activeforeground="#1e1e2e",
            relief="flat",
            cursor="hand2",
            padx=40,
            pady=15
        )
        self.download_btn.pack(expand=True)
        
        # Info Section
        info_frame = tk.Frame(main_frame, bg="#2d2d44", relief="flat")
        info_frame.pack(fill="both", expand=True, pady=(20, 0))
        
        info_label = tk.Label(
            info_frame,
            text="ℹ️ Hỗ trợ: YouTube, Facebook, TikTok, Instagram, Twitter và hơn 1000+ nền tảng khác!",
            font=("Segoe UI", 10),
            bg="#2d2d44",
            fg="#b0b0b0",
            wraplength=700,
            justify="center"
        )
        info_label.pack(pady=20)
        
    def on_entry_click(self, event):
        """Xử lý khi click vào ô nhập URL"""
        if self.url_entry.get() == "Dán link video vào đây...":
            self.url_entry.delete(0, "end")
            self.url_entry.config(fg="#ffffff")
    
    def on_focus_out(self, event):
        """Xử lý khi rời khỏi ô nhập URL"""
        if self.url_entry.get() == "":
            self.url_entry.insert(0, "Dán link video vào đây...")
            self.url_entry.config(fg="#808080")
    
    def browse_folder(self):
        """Chọn thư mục lưu file"""
        folder = filedialog.askdirectory(initialdir=self.download_path)
        if folder:
            self.download_path = folder
            self.path_entry.delete(0, "end")
            self.path_entry.insert(0, folder)
    
    def update_status(self, message, color="#00ff88"):
        """Cập nhật trạng thái"""
        self.status_label.config(text=f"⏳ Trạng thái: {message}", fg=color)
        self.root.update_idletasks()
    
    def progress_hook(self, d):
        """Hook để theo dõi tiến trình download"""
        if d['status'] == 'downloading':
            if 'total_bytes' in d:
                percent = (d['downloaded_bytes'] / d['total_bytes']) * 100
                self.update_status(f"Đang tải... {percent:.1f}%", "#00d4ff")
            else:
                self.update_status("Đang tải...", "#00d4ff")
        elif d['status'] == 'finished':
            self.update_status("Đang xử lý...", "#ffa500")
    
    def download_video(self):
        """Thực hiện download video"""
        url = self.url_entry.get()
        
        # Kiểm tra URL
        if not url or url == "Dán link video vào đây...":
            messagebox.showerror("Lỗi", "Vui lòng nhập link video!")
            self.update_status("Sẵn sàng", "#00ff88")
            self.is_downloading = False
            self.download_btn.config(state="normal", text="⬇️ TẢI VIDEO")
            self.progress_bar.stop()
            return
        
        quality = self.quality_var.get()
        
        try:
            self.update_status("Đang chuẩn bị...", "#00d4ff")
            
            # Cấu hình yt-dlp
            ydl_opts = {
                'outtmpl': os.path.join(self.download_path, '%(title)s.%(ext)s'),
                'progress_hooks': [self.progress_hook],
                'quiet': False,
                'no_warnings': False,
            }
            
            # Cấu hình format dựa trên lựa chọn
            if quality == "audio":
                ydl_opts['format'] = 'bestaudio/best'
                ydl_opts['postprocessors'] = [{
                    'key': 'FFmpegExtractAudio',
                    'preferredcodec': 'mp3',
                    'preferredquality': '192',
                }]
            elif quality == "best":
                ydl_opts['format'] = 'bestvideo+bestaudio/best'
            else:
                ydl_opts['format'] = f'bestvideo[height<={quality}]+bestaudio/best[height<={quality}]'
            
            # Tải video
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                self.update_status("Đang tải video...", "#00d4ff")
                info = ydl.extract_info(url, download=True)
                video_title = info.get('title', 'Video')
            
            self.update_status("Hoàn thành! ✅", "#00ff88")
            messagebox.showinfo(
                "Thành công", 
                f"Video đã được tải về thành công!\n\nTên: {video_title}\nThư mục: {self.download_path}"
            )
            
        except Exception as e:
            error_msg = str(e)
            self.update_status("Lỗi! ❌", "#ff4444")
            messagebox.showerror("Lỗi", f"Không thể tải video!\n\nLỗi: {error_msg}")
        
        finally:
            self.is_downloading = False
            self.download_btn.config(state="normal", text="⬇️ TẢI VIDEO")
            self.progress_bar.stop()
    
    def start_download(self):
        """Bắt đầu quá trình download trong thread riêng"""
        if self.is_downloading:
            messagebox.showwarning("Cảnh báo", "Đang có video đang được tải!")
            return
        
        self.is_downloading = True
        self.download_btn.config(state="disabled", text="⏳ ĐANG TẢI...")
        self.progress_bar.start(10)
        
        # Chạy download trong thread riêng để không block UI
        download_thread = threading.Thread(target=self.download_video, daemon=True)
        download_thread.start()


def main():
    """Hàm chính để khởi động ứng dụng"""
    root = tk.Tk()
    app = VideoDownloader(root)
    
    # Căn giữa cửa sổ
    root.update_idletasks()
    width = root.winfo_width()
    height = root.winfo_height()
    x = (root.winfo_screenwidth() // 2) - (width // 2)
    y = (root.winfo_screenheight() // 2) - (height // 2)
    root.geometry(f'{width}x{height}+{x}+{y}')
    
    root.mainloop()


if __name__ == "__main__":
    main()

