//------------------------------------------------------------------------
// Author:      Niccolo Rigacci <niccolo@rigacci.org>
// Version:     1.0 2017-12-14
// License:     GNU General Public License v3.0
//------------------------------------------------------------------------

include <misc_parts.scad>;

//------------------------------------------------------------------------
// Powered USB 3.0 Hub 4 ports, Amazon Basics.
//------------------------------------------------------------------------
module usb_hub_4p_amazon_basics() {
    x = 91; y = 41; z = 16;
    h1 = 6;
    color([92/255, 92/255, 92/255]) {
        cube(size = [x, y, z]);
        rotate(a = 90, v = [0, 1, 0]) {
            translate([-z/2, y/2, x + h1/2]) cylinder(r1 = 7/2, r2 = 6/2, h = h1, center = true, $fn = 32);
            translate([-z/2, y/2, x + 20/2]) cylinder(r = 4/2, h = 20, center = true, $fn = 32);
            }
    }
    for (x_pos = [15, 35, 55, 75])
        translate([x_pos, -2, 9]) rotate(a = 180, v = [1, 0, 0]) usb_male_type_a_connector();
    translate([x + 1, 31, z/2]) rotate(a=270, v=[0, 0, 1]) coax_power_plug();
}

//------------------------------------------------------------------------
// Powered USB 2.0 Hub 7 ports, Amazon Basics.
//------------------------------------------------------------------------
module usb2_hub_7p_amazon_basics() {
    x = 68.5; y = 87; z = 24.5;
    color([92/255, 92/255, 92/255]) {
      linear_extrude(height=z)
        union() {
            polygon(points=[[0,0],[x,0],[x,53.5],[42,83.3],[0,y],[0,82.5],[5,81],[5,6.5],[0,4.5]]);
            translate([x-30, 53.5]) circle(r=30, center=true, $fn=64);
        }
      translate([36, 41, -5])
        linear_extrude(height=5 + interf)
            difference() {
                square([24.3,23.2],center=true);
                square([18.3,16.6],center=true);
                square([5.7, 23.2 + interf * 2],center=true);
            }
    }
    for (y_pos = [36, 45.25, 54.50, 63.75, 73])
        translate([3, y_pos, 14]) rotate(a=90, v=[0,0,1]) rotate(a=90, v=[0, 1, 0]) usb_male_type_a_connector();
    for (y_pos = [17.0, 26.25])
        translate([70.5, y_pos, 14]) rotate(a=270, v=[0,0,1]) rotate(a=90, v=[0, 1, 0]) usb_male_type_a_connector();
    translate([1.5, 16.5, 12.5]) rotate(a=90, v=[0,0,1]) usb_male_type_b_connector();
    translate([1.5, 28.0,  9.0]) rotate(a=90, v=[0, 0, 1]) coax_power_plug_3p5();
}

//------------------------------------------------------------------------
// UGREEN USB Audio Adapter.
//------------------------------------------------------------------------
module usb_audio_adapter_ugreen() {
    x = 70; y = 55; z = 22; rca_h = 5.5; rca_d = 8.4;
    color([224/255, 224/255, 224/255]) difference() {
        cube(size = [x, y, z]);
        translate([-interf,   7.5, 10]) rotate(a=90, v=[0, 1, 0]) cylinder(r=(3.5/2), h=20, $fn=24);
        translate([-interf, y-7.5, 10]) rotate(a=90, v=[0, 1, 0]) cylinder(r=(3.5/2), h=20, $fn=24);
    }
    translate([-rca_h/2,   20.2, 14.8]) rotate(a = 90, v = [0, 1, 0]) color("gold") cylinder(r = rca_d/2, h = rca_h, center = true, $fn = 32);
    translate([-rca_h/2, y-20.2, 14.8]) rotate(a = 90, v = [0, 1, 0]) color("gold") cylinder(r = rca_d/2, h = rca_h, center = true, $fn = 32);
    translate([x + 6.5/2,  y / 2, z/2]) rotate(a = 90, v = [0, 1, 0]) color("white") cylinder(r = 8/2,   h = 6.5, $fn=32, center=true);
    translate([x + 20/2,   y / 2, z/2]) rotate(a = 90, v = [0, 1, 0]) color("white") cylinder(r = 4.5/2, h = 20,  $fn=32, center=true);
}

//------------------------------------------------------------------------
// Toshiba external USB 2.5" hard disk.
//------------------------------------------------------------------------
module usb_hard_disk_toshiba() {
    x = 79; y = 119; z = 16;
    color([92/255, 92/255, 92/255]) cube(size = [x, y, z]);
    translate([(x - 5) / 2, 110, z]) color("white") cube(size = [5, 2, 0.1]);
    color([64/255, 64/255, 64/255]) {
        // USB connector.
        translate([40, y, 4.5]) cube(size = [16, 18, 6]);
        translate([40 + 3.5, y + 18, 4.5]) cube(size = [9, 15, 6]);
        translate([40 + 8, y + 40.5, 7.5]) rotate(a = 90, v = [-1, 0, 0]) cylinder(r = 3.5/2, h = 15, center = true, $fn = 32);
    }
}
