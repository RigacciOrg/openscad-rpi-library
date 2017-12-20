include <misc_gadgets.scad>;
include <misc_boards.scad>;

// Wall thikness.
thick = 4;

// Inside size.
case_x = 250;
case_y = 130;
case_z =  60;

//
front_edge = 5;
side_edge = 1;

display_hole_x = 73;
display_hole_y = 25;

//------------------------------------------------------------------------
//------------------------------------------------------------------------
module inside_components() {
    usb_hub_x = 87.5; usb_hub_y = 68.5; usb_hub_z = 24;
    usb_audio_x = 55; usb_audio_y = 70;
    display_x = 80; display_y = 36;
    hd_y = 79;
    translate([2 + usb_hub_x, case_y - usb_hub_y, 0])
        rotate(a=90, v=[0, 0, 1])
            usb2_hub_7p_amazon_basics();
    translate([2 + usb_hub_x + 5, case_y, 0])
        rotate(a=270, v=[0, 0, 1])
            usb_audio_adapter_ugreen();
    translate([2, case_y - 3, usb_hub_z + 2])
        rotate(a=270, v=[0, 0, 1])
            usb_hard_disk_toshiba();
    translate([case_x - 5, 5, 2])
        rotate(a=90, v=[0, 0, 1])
            board_raspberrypi_3_model_b();
    translate([(case_x - display_x)/2, 1.8, (case_z - display_y)/2])
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
        translate([ 30, 70]) venting_slots(60, 50, 2, 4);
        translate([180, 20]) venting_slots(60, 50, 2, 4);
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
    offset_z = 0;
    usb_hub_x = 87.5;
    difference() {
        square(size = [case_x, case_z]);
        translate([usb_hub_x - 34, offset_z + 3]) square(size = [28, 22]);
        translate([usb_hub_x + 20, offset_z + 7]) square(size = [28, 15]);
    }
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
translate([side_edge + thick, front_edge + thick, thick]) inside_components();
