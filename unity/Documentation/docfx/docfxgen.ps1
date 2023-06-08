dotnet tool install --global docfx
dotnet tool install -g DocFxMarkdownGen

Remove-Item -recurse -force _api
Remove-Item -recurse -force _site
Remove-Item -recurse -force _md

docfx metadata

#remove all files except for AuraSDK namespace
Remove-Item -recurse _api/* -exclude AuraSDK.*

docfx build
dfmg