include <misc_gadgets.scad>;
include <misc_boards.scad>;

// Wall thikness.
thick = 4;

// Inside size.
case_x = 250;
case_y = 100;
case_z =  50;

//
front_edge = 5;
side_edge = 1;

display_hole_x = 60;
display_hole_y = 20;

//------------------------------------------------------------------------
//------------------------------------------------------------------------
module inside_components() {
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
}

//------------------------------------------------------------------------
// Case components.
//------------------------------------------------------------------------
module venting_slots(x, y, width, space) {
    for (slot_y = [0 : space : y]) {
        translate([0, slot_y]) square(size = [x, width]);
    }
}

module side_panel_2d() {
    square(size = [case_z, case_y + (thick + front_edge) * 2]);
}
module side_panel() {
    linear_extrude(height = thick) side_panel_2d();
}

module top_panel_2d() {
    difference() {
        square(size = [case_x + (thick + side_edge) * 2, case_y + (thick + front_edge) * 2]);
        translate([30, 50]) venting_slots(40, 30, 2, 4);
    }
}
module top_panel() {
    linear_extrude(height = thick) top_panel_2d();
}

module bottom_panel_2d() {
    difference() {
        square(size = [case_x + (thick + side_edge) * 2, case_y + (thick + front_edge) * 2]);
        translate([80, 50]) venting_slots(40, 30, 2, 4);
    }
}
module bottom_panel() {
    linear_extrude(height = thick) bottom_panel_2d();
}

module front_panel_2d() {
    difference() {
        square(size = [case_x, case_z]);
        translate([case_x / 2, case_z / 2]) square(size = [display_hole_x, display_hole_y], center = true);
    }
}
module front_panel() {
    linear_extrude(height = thick) front_panel_2d();
}

module back_panel_2d() {
    square(size = [case_x, case_z]);
}
module back_panel() {
    linear_extrude(height = thick) back_panel_2d();
}

module case_assembled() {
    //bottom_panel();
    translate([0, 0, case_z + thick]) %top_panel();
    translate([thick + side_edge, 0, thick])              rotate(a = 90, v = [0, -1, 0]) %side_panel();
    translate([case_x + side_edge + thick * 2, 0, thick]) rotate(a=90, v=[0, -1, 0])     %side_panel();
    translate([side_edge + thick, front_edge + thick, thick]) rotate(a = 90, v = [1, 0, 0]) front_panel();
    translate([side_edge + thick, front_edge + thick * 2 + case_y, thick]) rotate(a = 90, v = [1, 0, 0]) back_panel();
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
case_assembled();
inside_components();
