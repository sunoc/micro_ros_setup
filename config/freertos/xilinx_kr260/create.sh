pushd $FW_TARGETDIR >/dev/null
    # Create the toolchain directory
    mkdir toolchain


    # Install toolchain
    echo "Downloading ARM compiler, this may take a while"
    if [ $(uname -m) = "x86_64" ]; then
	wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
	tar --strip-components=1 -xvjf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -C toolchain > /dev/null
	rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
    elif [ $(uname -m) = "aarch64" ]; then
	wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-aarch64-linux.tar.bz2
	tar --strip-components=1 -xvjf gcc-arm-none-eabi-10.3-2021.10-aarch64-linux.tar.bz2 -C toolchain > /dev/null
	rm gcc-arm-none-eabi-10.3-2021.10-aarch64-linux.tar.bz2
    else
	echo "Unknown architecture used to build micro-ROS. Exiting with code 1."
	exit 1
    fi
    # Import repos
    vcs import --input $PREFIX/config/$RTOS/$PLATFORM/board.repos

    # ignore broken packages
    touch mcu_ws/ros2/rcl_logging/rcl_logging_spdlog/COLCON_IGNORE
    touch mcu_ws/ros2/rcl/COLCON_IGNORE
    touch mcu_ws/ros2/rosidl/rosidl_typesupport_introspection_cpp/COLCON_IGNORE
    touch mcu_ws/ros2/rcpputils/COLCON_IGNORE
    touch mcu_ws/ros2/ros2_tracing/test_tracetools/COLCON_IGNORE
    touch mcu_ws/uros/rcl/rcl_yaml_param_parser/COLCON_IGNORE
    touch mcu_ws/uros/rclc/rclc_examples/COLCON_IGNORE

popd >/dev/null
