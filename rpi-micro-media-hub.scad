//------------------------------------------------------------------------
// OpenSCAD project of an enclosure for a Raspberry Pi media hub.
//
// The enclosure accomodates the following parts:
//   * The Raspberry Pi 3 Model 3
//   * A 7 ports powered USB hub
//   * An USB audio dongle with RCA jacks
//   * An USB external hard disk
//   * Some push buttons on the front panel
//
// Author:      Niccolo Rigacci <niccolo@rigacci.org>
// Version:     2.0 2018-08-28
// License:     GNU General Public License v3.0
//------------------------------------------------------------------------

include <misc_gadgets.scad>;
include <misc_boards.scad>;

// Set greather than zero for an exploded 3D view.
explode = 40;

// Interference for 3D intersections and differences
interf = 0.1;

// Thickness of laser cut.
lcut = 0.2;

// Wall thikness.
thick = 4;
notch_x = 10;

// Inside size.
case_x = 250;
case_y = 150;
case_z =  70;

// Some panels have an overlapping edge.
front_edge = 6;
side_edge = 3;

// Foot diameter.
foot_d = 8;

// Hole for plastic tie, measure 1 x 3.5 mm.
plastic_tie_hole = [1.2, 3.7];

// There are four flanges for top panel screws.
flange_size = 17;
flange_notch = 7;
flange_hole_center = 5;

// Components position into the case
display_hole_x     = 73;
display_hole_y     = 25;
raspberry_offset_x = case_x - 9;
raspberry_offset_y = 7;
usb_hub_offset_x   = 87.5 + 2;
usb_hub_offset_y   = case_y - 68.5;
usb_audio_offset_x = usb_hub_offset_x + 8;
usb_audio_offset_y = case_y;
hd_offset_x        = 10;
hd_offset_y        = 2;

//------------------------------------------------------------------------
// Spacing and position for push buttons.
//------------------------------------------------------------------------
buttons_w = 32;
buttons_h = 32;
buttons_pos = [
  [0, -buttons_h/2, 0],			// Bottom
  [-buttons_w/2, 0, 0],			// Left
  [buttons_w/2,  0, 0],			// Right
  [0,  buttons_h/2, 0],			// Top
  [0,            0, 0],			// Center
  [-buttons_w*1.2, -buttons_h/2, 0],	// Lower left
  [-buttons_w*1.2,  buttons_h/2, 0]	// Upper left
];

//------------------------------------------------------------------------
// Interlocking notches and holes.
//------------------------------------------------------------------------
notch_x_pos = [
    [notch_x * 1.5,          -thick/2],
    [case_x - notch_x * 1.5, -thick/2],
    [case_x/2,               -thick/2]
];

notch_x_hole_pos = [
    [side_edge + thick + notch_x*1.5, front_edge + thick/2],
    [side_edge + thick + case_x/2, front_edge + thick/2],
    [side_edge + thick + case_x - notch_x*1.5, front_edge + thick/2],
    [side_edge + thick + notch_x*1.5, case_y + front_edge + thick*1.5],
    [side_edge + thick + case_x/2, case_y + front_edge + thick*1.5],
    [side_edge + thick + case_x - notch_x*1.5, case_y + front_edge + thick*1.5]
];

notch_z_pos = [
    [-thick/2,                  notch_x*1.5],
    [-thick/2,                  case_z - notch_x*1.5],
    [case_x + thick/2 - interf, case_z - notch_x*1.5],
    [case_x + thick/2 - interf, notch_x*1.5]
];

notch_z_hole_pos = [
    [notch_x*1.5, thick/2 + front_edge],
    [case_z - notch_x*1.5, thick/2 + front_edge],
    [notch_x*1.5, case_y + front_edge + thick * 1.5],
    [case_z - notch_x*1.5, case_y + front_edge + thick * 1.5]
];

//------------------------------------------------------------------------
// Corner coordinates (extreme points) of top and bottom panels.
// A 45 deg cut is made to avoid the 90 deg angle.
//------------------------------------------------------------------------
corner_x0 = 0;
corner_y0 = 0;
corner_x1 = case_x + (thick + side_edge) * 2;
corner_y1 = case_y + (thick + front_edge) * 2;
corner_cut = (side_edge * 2) / sqrt(2);

//------------------------------------------------------------------------
// Holes for plastic cable ties, measure 1 x 3.5 mm.
//------------------------------------------------------------------------
module usb_audio_holes() {
    translate([  -1,  0]) square(size=plastic_tie_hole, center=true);
    translate([55+1,  0]) square(size=plastic_tie_hole, center=true);
    translate([55+1, 30]) square(size=plastic_tie_hole, center=true);
    translate([  -1, 30]) square(size=plastic_tie_hole, center=true);
}

module usb_hd_holes() {
    y1 = 8; y2 = 83;
    translate([  -1, y1]) square(size=plastic_tie_hole, center=true);
    translate([79+1, y1]) square(size=plastic_tie_hole, center=true);
    translate([79+1, y2]) square(size=plastic_tie_hole, center=true);
    translate([  -1, y2]) square(size=plastic_tie_hole, center=true);
}

//------------------------------------------------------------------------
// Array of push buttons and holes.
//------------------------------------------------------------------------
module buttons_array() {
    translate([0, 0, explode])
        for(position = buttons_pos)
            translate(position) push_switch_8mm();
}
module buttons_holes() {
    for(position = buttons_pos)
        translate(position) circle(r=4, $fn=32);
}

//------------------------------------------------------------------------
// Place components inside the case.
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
    translate([hd_offset_x, case_y - 3, usb_hub_z + 2])
        rotate(a=270, v=[0, 0, 1])
            usb_hard_disk_toshiba();
    translate([raspberry_offset_x, raspberry_offset_y, 3])
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
// Side panel, with an eventual slot for inserting the SD-Card.
//---------------------------------------------------------------
module side_panel_2d(sd_slot=false) {
    difference() {
        square(size = [case_z, case_y + (thick + front_edge) * 2]);
        // Holes for interlocking notches.
        for (pos = notch_z_hole_pos)
            translate(pos) square(size=[notch_x - lcut, thick - lcut], center=true);
        // Holes for screw flange notches.
        translate([case_z - thick * 1.5, front_edge +  thick + flange_size/2]) square(size=[thick - lcut, flange_notch - lcut], center=true);
        translate([case_z - thick * 1.5, case_y + front_edge + thick - flange_size/2]) square(size=[thick - lcut, flange_notch - lcut], center=true);
        if (sd_slot) {
            //translate([-interf, front_edge + thick + raspberry_offset_y + 18])
            translate([-interf, front_edge + thick + raspberry_offset_y + 20])
                square(size=[7, 17]);
        }
    }
}
module side_panel(sd_slot=false) {
    linear_extrude(height = thick) side_panel_2d(sd_slot);
}

//---------------------------------------------------------------
// Top panel.
//---------------------------------------------------------------
module top_panel_2d() {
    difference() {
        square(size = [case_x + (thick + side_edge) * 2, case_y + (thick + front_edge) * 2]);
        translate([ 60, case_y-35]) vent_holes(12, 9, 3.5);
        translate([210, 45]) vent_holes(10, 7, 3.5);
        translate([side_edge + thick + flange_hole_center, front_edge + thick + flange_hole_center]) circle(r=1.5, $fn=16);
        translate([side_edge + thick + case_x - flange_hole_center, front_edge + thick + flange_hole_center]) circle(r=1.5, $fn=16);
        translate([side_edge + thick + flange_hole_center, front_edge + thick + case_y - flange_hole_center]) circle(r=1.5, $fn=16);
        translate([side_edge + thick + case_x - flange_hole_center, front_edge + thick + case_y - flange_hole_center]) circle(r=1.5, $fn=16);
        // Cut corners with a 45 deg cut.
        translate([corner_x0, corner_y0]) rotate(a=45, v=[0, 0, 1]) square(size=corner_cut, center=true);
        translate([corner_x1, corner_y0]) rotate(a=45, v=[0, 0, 1]) square(size=corner_cut, center=true);
        translate([corner_x1, corner_y1]) rotate(a=45, v=[0, 0, 1]) square(size=corner_cut, center=true);
        translate([corner_x0, corner_y1]) rotate(a=45, v=[0, 0, 1]) square(size=corner_cut, center=true);
    }
}
module top_panel() {
    linear_extrude(height = thick) top_panel_2d();
}

//---------------------------------------------------------------
// Bottom panel.
//---------------------------------------------------------------
module bottom_panel_2d() {
    hole_r = 1.5;
    $fn = 28;
    difference() {
        square(size = [case_x + (thick + side_edge) * 2, case_y + (thick + front_edge) * 2]);
        translate([ 60,  40]) vent_holes(10, 6, 3.5);
        translate([208, 110]) vent_holes(10, 8, 3.5);
        // Square hole for USB hub.
        translate([side_edge + thick, front_edge + thick])
            translate([usb_hub_offset_x - 52.6, usb_hub_offset_y + 23.5])
                square([23.2 + 0.2, 24.3 + 0.2]);
        // Raspberry Pi screw and vent holes.
        translate([side_edge + thick, front_edge + thick])
            translate([raspberry_offset_x, raspberry_offset_y])
                rotate(a=90, v=[0, 0, 1]) {
                    raspberrypi_3_model_b_holes();
                    translate([56/2, 32]) vent_holes(6, 7, 3.0);
                }
        // Holes for interlocking notches.
        for (pos = notch_x_hole_pos)
            translate(pos) square(size=[notch_x - lcut, thick - lcut], center=true);
        translate([side_edge + thick + usb_audio_offset_x, case_y - 38])
            usb_audio_holes();
        translate([hd_offset_x + side_edge + thick, case_y - 3 + front_edge + thick])
            rotate(a=270, v=[0, 0, 1])
                usb_hd_holes();
        // Holes for plastic ties holding the HDMI cable.
        hdmi_pos = raspberry_offset_x - 43 + thick + side_edge + (21 / 2);
        translate([hdmi_pos + 3.5, case_y + front_edge + thick - 7]) square(size=plastic_tie_hole, center=true);
        translate([hdmi_pos - 3.5, case_y + front_edge + thick - 7]) square(size=plastic_tie_hole, center=true);
        // Cut corners with a 45 deg cut.
        translate([corner_x0, corner_y0]) rotate(a=45, v=[0, 0, 1]) square(size=corner_cut, center=true);
        translate([corner_x1, corner_y0]) rotate(a=45, v=[0, 0, 1]) square(size=corner_cut, center=true);
        translate([corner_x1, corner_y1]) rotate(a=45, v=[0, 0, 1]) square(size=corner_cut, center=true);
        translate([corner_x0, corner_y1]) rotate(a=45, v=[0, 0, 1]) square(size=corner_cut, center=true);
    }
}
module bottom_panel() {
    linear_extrude(height = thick) bottom_panel_2d();
}

//---------------------------------------------------------------
// Front panel.
//---------------------------------------------------------------
module front_panel_2d() {
    difference() {
        square(size = [case_x, case_z]);
        //translate([case_x / 2, case_z / 2]) square(size = [display_hole_x, display_hole_y], center = true);
        translate([case_x/2, case_z/2]) buttons_holes();
        // Holes for screw flanges notches.
        translate([flange_size/2, case_z - thick * 1.5]) square(size=[flange_notch - lcut, thick - lcut], center=true);
        translate([case_x - flange_size/2, case_z - thick * 1.5]) square(size=[flange_notch - lcut, thick - lcut], center=true);
    }
    for (pos = notch_z_pos)
        translate(pos) square(size = [thick+interf, notch_x], center = true);
    for (pos = notch_x_pos)
        translate(pos) square(size=[notch_x, thick+interf], center=true);
}
module front_panel() {
    linear_extrude(height = thick) front_panel_2d();
}

//---------------------------------------------------------------
// Back panel.
//---------------------------------------------------------------
module back_panel_2d() {
    offset_z = 0;
    difference() {
        square(size = [case_x, case_z]);
        translate([usb_hub_offset_x - 35.5, offset_z + 3]) square(size = [28, 22]);	// USB hole
        translate([usb_audio_offset_x + 13.5, offset_z + 7]) square(size = [28, 15]);	// RCA audio hole
        translate([usb_audio_offset_x +  3.5, offset_z + 6]) square(size = [48, 9]);
        translate([raspberry_offset_x-43, -interf]) square(size = [21, 13+interf]);	// HDMI cable hole
        translate([case_x-16, 24]) circle(r=4, $fn=28);					// Power jack hole
        // Holes for screw flanges notches.
        translate([flange_size/2, case_z - thick * 1.5]) square(size=[flange_notch - lcut, thick - lcut], center=true);
        translate([case_x - flange_size/2, case_z - thick * 1.5]) square(size=[flange_notch - lcut, thick - lcut], center=true);
    }
    for (pos = notch_z_pos)
        translate(pos) square(size = [thick+interf, notch_x], center = true);
    for (pos = notch_x_pos)
        translate(pos) square(size=[notch_x, thick+interf], center=true);
}
module back_panel() {
    linear_extrude(height = thick) back_panel_2d();
}

//------------------------------------------------------------------------
// Four feet below the bottom panel.
//------------------------------------------------------------------------
module foot_2d() {
    difference() {
        circle(r=foot_d, $fn=32);
        translate([foot_d, foot_d]) circle(r=foot_d*0.8, $fn=32);
    }
}
module foot() {
    color("grey") linear_extrude(height = thick) foot_2d();
}
module feet_assembled() {
    foot_offset = 5;
    foot_x0 = foot_d + foot_offset;
    foot_y0 = foot_d + foot_offset;
    foot_x1 = case_x + (thick + side_edge)  * 2 - foot_d - foot_offset;
    foot_y1 = case_y + (thick + front_edge) * 2 - foot_d - foot_offset;
    translate([foot_x0, foot_y0, -(thick + explode * 1.3)]) foot();
    translate([foot_x0, foot_y1, -(thick + explode * 1.3)]) rotate(a=270, v=[0, 0, 1]) foot();
    translate([foot_x1, foot_y0, -(thick + explode * 1.3)]) rotate(a=90, v=[0, 0, 1])  foot();
    translate([foot_x1, foot_y1, -(thick + explode * 1.3)]) rotate(a=180, v=[0, 0, 1]) foot();
}

//---------------------------------------------------------------
// There are four flanges to screw the top panel.
//---------------------------------------------------------------
module screw_flange_2d(notch=true) {
    difference() {
        polygon(points=[[0,0],[flange_size,0],[0,flange_size]]);
        translate([flange_hole_center, flange_hole_center]) circle(r=1, $fn=6);
    }
    if (notch) {
        translate([flange_size/2, -thick/2 + interf]) square(size=[flange_notch, thick + interf*2], center=true);
        translate([-thick/2 + interf, flange_size/2]) square(size=[thick + interf*2, flange_notch], center=true);
    }
}
module screw_flange(notch=true) {
    linear_extrude(height = thick) screw_flange_2d(notch);
}
module screw_flange_assembled() {
    pad_x0 = thick + side_edge;
    pad_y0 = thick + front_edge;
    pad_x1 = case_x + (thick + side_edge);
    pad_y1 = case_y + thick + front_edge;
    translate([pad_x0, pad_y0, case_z - thick]) screw_flange();
    translate([pad_x1, pad_y0, case_z - thick]) rotate(a=90, v=[0, 0, 1]) screw_flange();
    translate([pad_x1, pad_y1, case_z - thick]) rotate(a=180, v=[0, 0, 1]) screw_flange();
    translate([pad_x0, pad_y1, case_z - thick]) rotate(a=270, v=[0, 0, 1]) screw_flange();
    translate([pad_x0, pad_y0, case_z]) screw_flange(notch=false);
    translate([pad_x1, pad_y0, case_z]) rotate(a=90, v=[0, 0, 1]) screw_flange(notch=false);
    translate([pad_x1, pad_y1, case_z]) rotate(a=180, v=[0, 0, 1]) screw_flange(notch=false);
    translate([pad_x0, pad_y1, case_z]) rotate(a=270, v=[0, 0, 1]) screw_flange(notch=false);
}

//---------------------------------------------------------------
// The case assembled in 3D layout.
//---------------------------------------------------------------
module case_assembled() {
    translate([0, 0, -explode]) bottom_panel();
    translate([thick + side_edge -explode, 0, thick])     rotate(a = 90, v = [0, -1, 0])       color("red") side_panel();
    translate([case_x + side_edge + thick * 2 + explode, 0, thick]) rotate(a=90, v=[0, -1, 0]) color("red") side_panel(sd_slot=true);
    translate([side_edge + thick, front_edge + thick - (explode * 0.5), thick]) rotate(a = 90, v = [1, 0, 0]) color("skyblue") front_panel();
    translate([side_edge + thick, front_edge + thick * 2 + case_y + (explode * 0.5), thick]) rotate(a = 90, v = [1, 0, 0]) color("skyblue") back_panel();
    //translate([0, 0, case_z + thick + explode]) top_panel();
    screw_flange_assembled();
    feet_assembled();
}

//------------------------------------------------------------------------
// All the pieces layed-out in 2D, for laser cutting.
//------------------------------------------------------------------------
module case_layed_out() {
    translate([0, 0]) bottom_panel_2d();
    translate([0, -case_y - 30]) top_panel_2d();
    translate([0, case_y + 30]) front_panel_2d();
    translate([0, case_y + case_z + 40]) back_panel_2d();
    translate([case_x + 30, 0]) side_panel_2d();
    translate([case_x + 30, -case_y - 30]) side_panel_2d(sd_slot=true);

    for (x = [30, 50, 70, 90]) {
        for (y = [40, 60]) {
            translate([case_x + x, case_y + y]) foot_2d();
        }
    }
    for (x = [20, 40, 60, 80]) {
        translate([case_x + x, case_y + 90]) screw_flange_2d(notch=true);
    }
    for (x = [20, 40, 60, 80]) {
        translate([case_x + x, case_y + 110]) screw_flange_2d(notch=false);
    }
}

//------------------------------------------------------------------------
// The rendering!
//------------------------------------------------------------------------
//case_assembled();
//translate([side_edge + thick, front_edge + thick, thick]) inside_components();

case_layed_out();
