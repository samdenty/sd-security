; SD-Security AppBundle, Copyright SD-Storage. All Rights Reserved.

#define AppName "AppBundle for SDS"
#define AppPublisher "SD-Storage©"
#define AppVersion "1.0.1"
#define AppURL "http://SD-Storage.weebly.com/#SdsAppbundle"
#define AppExeName "SD-Security.exe"
#define SdsLocation "D:\Unlocked\Batch Files\Project Security\BETA\SD-Security.exe"

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
OutputDir=D:\Unlocked\Batch Files\Project Security\BETA\Portable Compiler\Installer
OutputBaseFilename=AppBundle
SetupIconFile=Files\Icon_AppBundle.ico
;Advanced Variables
AllowRootDirectory=yes
AppendDefaultDirName=no
CreateUninstallRegKey=no
Uninstallable=no
AppId={{936E130C-E949-4105-8D93-74E437B0F644}
PrivilegesRequired=lowest
AllowNoIcons=yes
DirExistsWarning=no
Compression=lzma
SolidCompression=yes

[Messages]
WelcomeLabel2=SD-SecurInstaller for Windows%nThis will a AppBundle for SD-Security on your PC.%n%nIt is recommended that you close all other applications and disable any anti virus before continuing.
BeveledLabel=SDS AppBundle (SD-SecurInstaller)

[Code]
procedure InitializeWizard();
begin
  WizardForm.WelcomeLabel2.Font.Color := $374943;
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "Files\ISSkin.dll"; DestDir: {app}; Flags: dontcopy
Source: "Files\Win10.cjstyles"; DestDir: {tmp}; Flags: dontcopy
Source: "D:\Unlocked\Batch Files\Project Security\BETA\Plugins\*"; DestDir: "{app}\SDS_Files\Plugins\"; Flags: ignoreversion recursesubdirs createallsubdirs

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