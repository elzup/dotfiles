
# android
export PATH=$PATH:/opt/android-ndk-r10d
case ${OSTYPE} in
    darwin*)
        export ANDROID_NDK_ROOT=/Applications/Android/android-ndk-r10d
        export ANDROID_SDK_ROOT=/Applications/Android/sdk
        export ANT_ROOT=/Applications/Android/apache-ant-1.9.4
        export NDK_ROOT=/Applications/Android/android-ndk-r10d
        ;;
    *)
        export NDK_ROOT=/opt/android-ndk-r9d
        export ANDROID_NDK_ROOT=/opt/android-ndk-r9d
        export ANDROID_SDK_ROOT=/opt/android-sdk
        export ANT_ROOT=/usr/bin
        ;;
esac
