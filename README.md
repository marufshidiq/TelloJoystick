# TelloJoystick

DJI Tello interface using Joystick as controller

## Hardware

- [DJI Tello](https://www.ryzerobotics.com/tello)
- [Logitech Extreme 3D Pro](https://www.logitechg.com/en-roeu/products/gamepads/extreme-3d-pro-joystick.html)
  > This program also can work using keyboard

## Program

- [Processing IDE](http://processing.org/) - `TelloJoystick_code.pde`

## Library

- [UDP](https://ubaa.net/shared/processing/udp/index.htm) - To communicate with DJI Tello using **User Datagram Protocol**
- [Game Control Plus](http://lagers.org.uk/gamecontrol/index.html) - To get data from a game controller
- [GL Video](https://github.com/gohai/processing-glvideo) - Hardware accelerated video on the Raspberry Pi & Linux

```bash
$ sudo apt-get update
$ sudo apt-get build-essential
$ sudo apt-get pkg-config
$ sudo apt-get install libgstreamer1.0-0 gstreamer1.0-dev gstreamer1.0-tools gstreamer1.0-doc
$ sudo apt-get install gstreamer1.0-plugins-base gstreamer1.0-plugins-good
$ sudo apt-get install gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly
$ sudo apt-get install gstreamer1.0-libav
$ sudo apt-get install gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
```

## Reference

- [SDK Documentation](/reference/Tello_SDK_Documentation_EN_1.3_1122.pdf)
