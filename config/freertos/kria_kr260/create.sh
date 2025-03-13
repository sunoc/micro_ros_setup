pushd $FW_TARGETDIR >/dev/null
    # Create the toolchain directory
    mkdir toolchain


    # Install toolchain
    # Since the build can happen on a separated desktop PC or on the KRIA
    # board's own Linux, both x86_64 and 64-bits ARM cases are covered.
    echo "Downloading ARM compiler, this may take a while"
    if [ $(uname -m) = "x86_64" ]; then
	wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
	tar --strip-components=1 -xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
	rm arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
    elif [ $(uname -m) = "aarch64" ]; then
	wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-aarch64-arm-none-eabi.tar.xz
	tar --strip-components=1 -xvf arm-gnu-toolchain-14.2.rel1-aarch64-arm-none-eabi.tar.xz
	rm arm-gnu-toolchain-14.2.rel1-aarch64-arm-none-eabi.tar.xz
    else
	echo "Unknown architecture used to build micro-ROS. Exiting with code 1."
	exit 1
    fi

    # Import repos
    vcs import --input $PREFIX/config/$RTOS/$PLATFORM/board.repos --recursive

    # ignore broken packages
    touch mcu_ws/ros2/rcl_logging/rcl_logging_spdlog/COLCON_IGNORE
    touch mcu_ws/ros2/rcl/COLCON_IGNORE
    touch mcu_ws/ros2/rosidl/rosidl_typesupport_introspection_cpp/COLCON_IGNORE
    touch mcu_ws/ros2/rcpputils/COLCON_IGNORE
    touch mcu_ws/ros2/ros2_tracing/test_tracetools/COLCON_IGNORE
    touch mcu_ws/uros/rcl/rcl_yaml_param_parser/COLCON_IGNORE
    touch mcu_ws/uros/rclc/rclc_examples/COLCON_IGNORE

popd >/dev/null
