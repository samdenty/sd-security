; SD-Security SecurInstaller, Copyright SD-Storage. All Rights Reserved.

#define AppName "SD-Security"
#define AppPublisher "SD-Storage©"
#define AppVersion "1.3.1B"
#define AppURL "http://SD-Storage.weebly.com/#SDS"
#define AppExeName "SD-Security.exe"
#define SdsLocation "D:\Project Security\SD-Security.exe"

[Setup]
;Program Variables
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={src}
DefaultGroupName={#AppName}
;Files
WizardImageFile=Files\background.bmp    
WizardSmallImageFile=Files\small_background.bmp
LicenseFile=Files\Terms And Conditions.rtf
OutputDir=D:\Project Security\Compiler\Installer
OutputBaseFilename=SD-SecurInstaller
SetupIconFile=Files\Icon.ico
;Advanced Variables
AllowRootDirectory=yes
AppendDefaultDirName=no
CreateUninstallRegKey=no
Uninstallable=no
AppId={{B0E6F17F-0489-4529-98AC-79532952003B}
PrivilegesRequired=lowest
AllowNoIcons=yes
DirExistsWarning=no
Compression=lzma
SolidCompression=yes

[Messages]
WelcomeLabel2=SD-SecurInstaller for Windows%nThis will install SD-Security on your computer.%n%nIt is recommended that you close all other applications and disable your anti virus before continuing.
BeveledLabel=SD-SecurInstaller

[Code]
procedure InitializeWizard();
begin
  WizardForm.WelcomeLabel2.Font.Color := $374943;
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "Files\ISSkin.dll"; DestDir: {app}; Flags: dontcopy
Source: "Files\Win10.cjstyles"; DestDir: {tmp}; Flags: dontcopy
Source: "{#SdsLocation}"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#AppName}}"; Filename: "{#AppURL}"
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Tasks: desktopicon

[Code]
procedure LoadSkin(lpszPath: String; lpszIniFileName: String);
external 'LoadSkin@files:isskin.dll stdcall';
procedure UnloadSkin();
external 'UnloadSkin@files:isskin.dll stdcall';
function ShowWindow(hWnd: Integer; uType: Integer): Integer;
external 'ShowWindow@user32.dll stdcall';
function InitializeSetup(): Boolean;
begin
	ExtractTemporaryFile('Win10.cjstyles');
	LoadSkin(ExpandConstant('{tmp}\Win10.cjstyles'), '');
	Result := True;
end;
procedure DeinitializeSetup();
begin
	ShowWindow(StrToInt(ExpandConstant('{wizardhwnd}')), 0);
	UnloadSkin();
end;

[Run]
Filename: "{app}\{#AppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(AppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent