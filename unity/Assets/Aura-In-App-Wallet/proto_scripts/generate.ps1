#The csharp code in ../proto folder is generated using this script
#Since base and params match C# keywords, they have all been replaced to _base and _params
dotnet tool install --global protobuf-net.Protogen
set-variable -name "root" -value "/path/to/proto"
protogen --proto_path=$root --csharp_out=out @(Get-ChildItem -Path $root -Filter *.proto -r | % { $_.FullName.Replace($root + "\", "")})