# https://twitter.com/phileynick/status/1688922792887209985

adb devices | tail -n +2 | while read line
do
    deviceId=$(echo $line | awk '{print $1}')
    if [ -z "${deviceId}" ]; then
        continue
    fi
    if [[ $line == *"emulator"* ]]
    then
        deviceName=$deviceId
    else
        deviceName=$(echo $line | awk -F "device:" '{print $2}' | awk '{print $1}')
    fi
    echo "Capturing screenshot from device $deviceName"
    timestamp=$(date +"%Y-%m-%d at %H.%M.%S")
    filename="Android Screenshot - $deviceName - $timestamp.png"
    adb -s $deviceId exec-out screencap -p > "$filename"
done
