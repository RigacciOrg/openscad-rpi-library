//------------------------------------------------------------------------
// Author:      Niccolo Rigacci <niccolo@rigacci.org>
// Version:     1.0 2017-12-14
// License:     GNU General Public License v3.0
//------------------------------------------------------------------------

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
// UGREEN USB Audio Adapter.
//------------------------------------------------------------------------
module usb_audio_adapter_ugreen() {
    x = 70; y = 55; z = 22; rca_h = 5.5; rca_d = 8.0;
    color([224/255, 224/255, 224/255]) cube(size = [x, y, z]);
    translate([-rca_h/2,     20, 15]) rotate(a = 90, v = [0, 1, 0]) color("gold") cylinder(r = rca_d/2, h = rca_h, center = true, $fn = 32);
    translate([-rca_h/2, y - 20, 15]) rotate(a = 90, v = [0, 1, 0]) color("gold") cylinder(r = rca_d/2, h = rca_h, center = true, $fn = 32);
    translate([x + 6.5/2, y / 2, z/2]) rotate(a = 90, v = [0, 1, 0]) color("white") cylinder(r = 8/2,   h = 6.5, $fn=32, center=true);
    translate([x + 20/2,  y / 2, z/2]) rotate(a = 90, v = [0, 1, 0]) color("white") cylinder(r = 4.5/2, h = 20,  $fn=32, center=true);
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
