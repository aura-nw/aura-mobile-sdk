#The csharp code in ../proto folder is generated using this script
#Since base and params match C# keywords, they have all been replaced to _base and _params
dotnet tool uninstall --global protobuf-net.Protogen
dotnet tool install --global protobuf-net.Protogen --version 2.3.17
set-variable -name "root" -value "/path/to/proto"
protogen --proto_path=$root --csharp_out=$root/out @(Get-ChildItem -Path $root -Filter *.proto -r | % { $_.FullName.Replace("\", "/").Replace($root + "/", "")})