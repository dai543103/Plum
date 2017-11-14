@echo off

echo "create protobuf-cpp"

%~dp0protoc.exe battlespheres.proto --cpp_out=.

copy /y "%~dp0\battlespheres.pb.h" "%~dp0\..\..\src\battlesvr\battlespheres.pb.h"
copy /y "%~dp0\battlespheres.pb.cc" "%~dp0\..\..\src\battlesvr\battlespheres.pb.cc"

copy /y "%~dp0\battlespheres.pb.h" "%~dp0\..\..\src\battlespheres-client\battlespheres.pb.h"
copy /y "%~dp0\battlespheres.pb.cc" "%~dp0\..\..\src\battlespheres-client\battlespheres.pb.cc"

%~dp0protoc.exe battlespheres_login.proto --cpp_out=.

copy /y "%~dp0\battlespheres_login.pb.h" "%~dp0\..\..\src\loginsvr\battlespheres_login.pb.h"
copy /y "%~dp0\battlespheres_login.pb.cc" "%~dp0\..\..\src\loginsvr\battlespheres_login.pb.cc"


pause