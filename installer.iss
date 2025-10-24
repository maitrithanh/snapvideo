; SnapVideo Installer Script for Inno Setup
; Tạo file installer (setup.exe) cho SnapVideo

#define MyAppName "SnapVideo"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "SnapVideo Team"
#define MyAppURL "https://github.com/yourusername/snapvideo"
#define MyAppExeName "SnapVideo.exe"

[Setup]
; Thông tin ứng dụng
AppId={{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

; Đường dẫn cài đặt mặc định
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}

; Không cho phép thay đổi thư mục cài đặt (comment dòng này nếu muốn cho phép)
;DisableDirPage=yes

; Output
OutputDir=output
OutputBaseFilename=SnapVideo_Setup_v{#MyAppVersion}
SetupIconFile=icon.ico

; Compression
Compression=lzma2/max
SolidCompression=yes

; Privileges
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

; Giao diện
WizardStyle=modern
DisableWelcomePage=no
LicenseFile=

; Ngôn ngữ
ShowLanguageDialog=auto

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "vietnamese"; MessagesFile: "compiler:Languages\Vietnamese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode

[Files]
; File thực thi chính
Source: "SnapVideo.exe"; DestDir: "{app}"; Flags: ignoreversion

; Thêm các file khác nếu cần
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "HUONG_DAN_CAI_DAT.txt"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Tạo shortcut trong Start Menu
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\README"; Filename: "{app}\README.md"
Name: "{group}\Hướng dẫn"; Filename: "{app}\HUONG_DAN_CAI_DAT.txt"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

; Tạo shortcut trên Desktop (nếu user chọn)
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

; Tạo shortcut trong Quick Launch (nếu user chọn)
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
; Chạy ứng dụng sau khi cài đặt (nếu user chọn)
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
// Kiểm tra Windows version
function InitializeSetup(): Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  
  // Yêu cầu tối thiểu Windows 7
  if Version.Major < 6 then
  begin
    MsgBox('SnapVideo yêu cầu Windows 7 trở lên!', mbError, MB_OK);
    Result := False;
  end
  else
    Result := True;
end;

// Hiển thị thông báo sau khi cài đặt thành công
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Tạo thư mục Downloads mặc định
    ForceDirectories(ExpandConstant('{userdocs}\Downloads\SnapVideo'));
  end;
end;

