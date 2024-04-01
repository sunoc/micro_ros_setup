EXTENSIONS_DIR=$FW_TARGETDIR/freertos_apps/microros_nucleo_f446ze_extensions

function help {
      echo "For compatibility purpose, configure script need an argument."
      echo "   --transport -t        rpmsg"
}

echo $CONFIG_NAME > $FW_TARGETDIR/APP
if [ "$UROS_TRANSPORT" != "rpmsg" ]; then
      help
fi
