include <misc_gadgets.scad>;
include <misc_boards.scad>;

usb_hub_y = 41;
usb_audio_y = 70;

translate([0, 0, usb_hub_y])
    rotate(a=270, v=[1, 0, 0])
        usb_hub_4p_amazon_basics();

translate([15, usb_audio_y + 45, 0])
    rotate(a=270, v=[0, 0, 1])
        usb_audio_adapter_ugreen();

translate([0, 105, 24])
    rotate(a=270, v=[0, 0, 1])
        usb_hard_disk_toshiba();

translate([220, 15, 0])
    rotate(a=90, v=[0, 0, 1])
        board_raspberrypi_3_model_b();

translate([140, 1.8, 0])
    rotate(a=90, v=[1, 0, 0])
        lcd_1602a();
