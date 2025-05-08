path: bilivideo_down.zip
flutter clean
flutter pub get
flutter build windows

# 创建临时目录用于打包
$tempDir = "build\windows\temp_package"
New-Item -ItemType Directory -Force -Path $tempDir
Copy-Item -Path "build\windows\x64\runner\Release\*" -Destination $tempDir -Recurse

# 复制 sqlite3.dll 到临时目录
Copy-Item -Path "sqlite3.dll" -Destination $tempDir -Force
Write-Output 'Copied sqlite3.dll to package directory'

# 直接将编译好的文件打包成 bilivideo_down.zip，保存到 build/windows/ 目录
Compress-Archive -Path "$tempDir\*" -DestinationPath "build\windows\bilivideo_down.zip" -Force
Compress-Archive -Path "$tempDir\*" -DestinationPath "build\windows\biliVidoDown-windows-x86-64.zip" -Force

# 清理临时目录
Remove-Item -Path $tempDir -Recurse -Force


