Do ứng dụng chưa public nên chưa có domain để phục vụ Oauth2 redirect. Cần phải sửa hosts của emulator để sử dụng Oauth2.

cd ${AndroidSDKPath}/emulator

./emulator -writable-system -netdelay none -netspeed full -avd <AVDName> 

Open new terminal:

adb root
adb remount
adb pull /system/etc/hosts
adb shell
cd system/etc
echo "10.0.2.2    develop.com" >> hosts

END.