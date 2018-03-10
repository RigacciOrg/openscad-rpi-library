include <misc_gadgets.scad>;
include <misc_boards.scad>;

// Wall thikness.
thick = 4;

// Inside size.
case_x = 250;
case_y = 150;
case_z =  60;

//
front_edge = 5;
side_edge = 1;

display_hole_x = 73;
display_hole_y = 25;

raspberry_offset_x = case_x - 5; 
raspberry_offset_y = 8;
usb_hub_offset_x   = 87.5 + 2;
usb_hub_offset_y   = case_y - 68.5;
usb_audio_offset_x = usb_hub_offset_x + 5;
usb_audio_offset_y = case_y;

//------------------------------------------------------------------------
// Array of push buttons.
//------------------------------------------------------------------------
module buttons_array() {
    x = 32;
    y = 32;
    translate([0,    -y/2, 0]) push_switch_8mm();   // Bottom
    translate([-x/2,    0, 0]) push_switch_8mm();   // Left
    translate([x/2,     0, 0]) push_switch_8mm();   // Right
    translate([0,     y/2, 0]) push_switch_8mm();   // Top
    translate([0,       0, 0]) push_switch_8mm();   // Center
    translate([-x*1.2, -y/2, 0]) push_switch_8mm(); // Lower left
    translate([-x*1.2,  y/2, 0]) push_switch_8mm(); // Upper left
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
module inside_components() {
    usb_hub_z = 24;
    display_x = 80; display_y = 36;
    hd_y = 79;
    translate([usb_hub_offset_x, usb_hub_offset_y, 0])
        rotate(a=90, v=[0, 0, 1])
            usb2_hub_7p_amazon_basics();
    translate([usb_audio_offset_x, usb_audio_offset_y, 0])
        rotate(a=270, v=[0, 0, 1])
            usb_audio_adapter_ugreen();
    translate([2, case_y - 3, usb_hub_z + 2])
        rotate(a=270, v=[0, 0, 1])
            usb_hard_disk_toshiba();
    translate([raspberry_offset_x, raspberry_offset_y, 2])
        rotate(a=90, v=[0, 0, 1])
            board_raspberrypi_3_model_b();
    translate([raspberry_offset_x - 90, raspberry_offset_y + 27.1, 17])
        rotate(a=90, v=[0, 0, 1])
            usb_male_type_a_connector();
    translate([case_x/2, -thick, case_z/2])
        rotate(a=90, v=[1, 0, 0])
            buttons_array();
    //translate([(case_x - display_x)/2, 1.8, (case_z - display_y)/2])
    //    rotate(a=90, v=[1, 0, 0])
    //        lcd_1602a();
}

//------------------------------------------------------------------------
// Case components.
//------------------------------------------------------------------------

//---------------------------------------------------------------
// Make a centered array of (X x Y) holes.
//---------------------------------------------------------------
module vent_holes(x, y, diameter) {
    $fn = 6;
    step = diameter * 2;
    radius = diameter / 1.8;
    offset_x = (step * (x - 1)) / 2;
    offset_y = (step * (y - 1)) / 2;
    for (i = [1:x]) {
        for (j = [1:y]) {
            translate([(i - 1) * step - offset_x, (j -1) * step - offset_y])
                circle(r=radius);
        }
    }
}

//---------------------------------------------------------------
//---------------------------------------------------------------
module side_panel_2d() {
    square(size = [case_z, case_y + (thick + front_edge) * 2]);
}
module side_panel() {
    linear_extrude(height = thick) side_panel_2d();
}

//---------------------------------------------------------------
//---------------------------------------------------------------
module top_panel_2d() {
    difference() {
        square(size = [case_x + (thick + side_edge) * 2, case_y + (thick + front_edge) * 2]);
        translate([ 60, 95]) vent_holes(12, 9, 3.5);
        translate([210, 45]) vent_holes(10, 7, 3.5);
    }
}
module top_panel() {
    linear_extrude(height = thick) top_panel_2d();
}

//---------------------------------------------------------------
//---------------------------------------------------------------
module bottom_panel_2d() {
    difference() {
        square(size = [case_x + (thick + side_edge) * 2, case_y + (thick + front_edge) * 2]);
        translate([200, 105]) vent_holes(10, 6, 3.5);
        // Square hole for USB hub.
        translate([side_edge + thick, front_edge + thick])
            translate([usb_hub_offset_x - 52.6, usb_hub_offset_y + 24.6])
                square([23 + 0.2, 24.5 + 0.2]);
        translate([side_edge + thick, front_edge + thick])
            translate([raspberry_offset_x, raspberry_offset_y, 2])
                rotate(a=90, v=[0, 0, 1])
                    raspberrypi_3_model_b_holes();
    }
}
module bottom_panel() {
    linear_extrude(height = thick) bottom_panel_2d();
}

//---------------------------------------------------------------
//---------------------------------------------------------------
module front_panel_2d() {
    difference() {
        square(size = [case_x, case_z]);
        //translate([case_x / 2, case_z / 2]) square(size = [display_hole_x, display_hole_y], center = true);
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
    bottom_panel();
    //translate([0, 0, case_z + thick]) top_panel();
    translate([thick + side_edge, 0, thick])              rotate(a = 90, v = [0, -1, 0]) %side_panel();
    translate([case_x + side_edge + thick * 2, 0, thick]) rotate(a=90, v=[0, -1, 0])     %side_panel();
    translate([side_edge + thick, front_edge + thick, thick]) rotate(a = 90, v = [1, 0, 0]) front_panel();
    translate([side_edge + thick, front_edge + thick * 2 + case_y, thick]) rotate(a = 90, v = [1, 0, 0]) back_panel();
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
case_assembled();
translate([side_edge + thick, front_edge + thick, thick]) inside_components();
