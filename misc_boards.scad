//------------------------------------------------------------------------
// OpenSCAD models of miscellaneous components and devices:
// various Raspberry Pi models, SainSmart Relays, PCD8544 LCD, etc.
//
// Author:      Niccolo Rigacci <niccolo@rigacci.org>
// Version:     1.0 2017-12-14
// License:     GNU General Public License v3.0
//------------------------------------------------------------------------

include <misc_parts.scad>;

// Interference for 3D union(), difference() and intersection();
// used to avoid the manifold problem.
interf = 0.1;

//------------------------------------------------------------------------
// 1602A LCD panel 16x2 characters.
//------------------------------------------------------------------------
module lcd_1602a() {
    $fn = 32;
    translate([4.5, 5.5, 1.8])  color([64/255, 64/255, 128/255]) cube([71, 24, 7]);
    color("green") linear_extrude(height = 1.8) difference() {
        square(size=[80, 36]);
        translate([3, 3])           circle(r=3.2/2, center = true);
        translate([80 - 3, 3])      circle(r=3.2/2, center = true);
        translate([80 - 3, 36 - 3]) circle(r=3.2/2, center = true);
        translate([3, 36 - 3])      circle(r=3.2/2, center = true);
    }
}

//------------------------------------------------------------------------
// Matrix of 2.54 mm pins.
//------------------------------------------------------------------------
module pin_headers(cols, rows) {
    w = 2.54; h = 2.54; p = 0.65;
    for(x = [0 : (cols -1)]) {
        for(y = [0 : (rows  - 1)]) {
            translate([w * x, w * y, 0]) {
                union() {
                    color("black") cube([w, w, h]);
                    color("gold")  translate([(w - p) / 2, (w - p) / 2, -3]) cube([p, p, 11.54]);
                }
            }
        }
    }
}

//------------------------------------------------------------------------
// Two-relays module manufactured by SainSmart (or alike).
//------------------------------------------------------------------------
module board_2relays_sainsmart() {
    // Board with 3.0 mm holes.
    pcb_thick = 1.6;
    difference() {
        color("darkgreen") cube([39.0, 51.0, pcb_thick]);
        translate([2.75, 2.75, -interf]) {
            translate([   0,    0, 0]) cylinder(r=1.5, h=(2 + interf * 2), $fn=16);
            translate([33.5,    0, 0]) cylinder(r=1.5, h=(2 + interf * 2), $fn=16);
            translate([   0, 45.5, 0]) cylinder(r=1.5, h=(2 + interf * 2), $fn=16);
            translate([33.5, 45.5, 0]) cylinder(r=1.5, h=(2 + interf * 2), $fn=16);
        }
    }
    translate([ 3.8, 12.2, pcb_thick])  color("blue") cube([15, 19, 16]);
    translate([20.2, 12.2, pcb_thick])  color("blue") cube([15, 19, 16]);
    translate([ 3.8,    4, pcb_thick])  color("blue") cube([15, 8, 10.2]);
    translate([20.2,    4, pcb_thick])  color("blue") cube([15, 8, 10.2]);
    translate([ 9, 46.5, 1.6]) pin_headers(4, 1);
    translate([ 9, 46.5, 1.6]) dupont_female(4, 1, [-1, 1, 0]);
    translate([24, 46.5, 1.6]) pin_headers(3, 1);
}

//------------------------------------------------------------------------
// Two-relays module manufactured by Keyes.
//------------------------------------------------------------------------
module board_2relays_keyes() {
    // Board with 3.6 mm holes.
    difference() {
        color("red") cube([45.5, 55, 2]);
        translate([3.5, 9, -interf]) {
            translate([ 0,  0, 0]) cylinder(r=1.8, h=(2 + interf * 2), $fn=16);
            translate([38,  0, 0]) cylinder(r=1.8, h=(2 + interf * 2), $fn=16);
            translate([0,  40, 0]) cylinder(r=1.8, h=(2 + interf * 2), $fn=16);
            translate([38, 40, 0]) cylinder(r=1.8, h=(2 + interf * 2), $fn=16);
        }
    }
    translate([7.5, 15, 2])  color("blue") cube([15, 19, 16]);
    translate([23, 15, 2])   color("blue") cube([15, 19, 16]);
    translate([14.5, 48, 2]) pin_headers(6, 1);
}

//------------------------------------------------------------------------
// PCD8544 LCD module (from Nokia 5110/3310 phones), blue PCB.
// Pin on bottom, 3.2 mm holes spaced 34.5 x 41
//------------------------------------------------------------------------
module board_pcd8544_blue() {
    difference() {
        color("darkblue") cube([43, 45.5, 1.2]);
        translate([4.25, 2.25, -interf]) {
            translate([ 0.0,  0, 0]) cylinder(r=1.6, h=(1.2 + interf * 2), $fn=16);
            translate([34.5,  0, 0]) cylinder(r=1.6, h=(1.2 + interf * 2), $fn=16);
            translate([ 0.0, 41, 0]) cylinder(r=1.6, h=(1.2 + interf * 2), $fn=16);
            translate([34.5, 41, 0]) cylinder(r=1.6, h=(1.2 + interf * 2), $fn=16);
        }
    }
    // Frame and LCD screen.
    difference() {
        translate([1.5, 6.0, 1.2])
            color("silver") cube([40, 34, 4]);
        translate([3.25, 7.5, 1.2 + 4 - 0.5])
            cube([36.5, 26, 0.6]);
    }
    translate([10.5, 2 + 2.54, 0])
        rotate(a=180, v=[1, 0, 0]) {
            pin_headers(8, 1);
            dupont_female(8, 1, [1, 1, 0]);
        }
}

//------------------------------------------------------------------------
// PCD8544 LCD module (from Nokia 5110/3310 phones), red PCB.
// Pin on top, 2.5 mm holes spaced 40 x 39
//------------------------------------------------------------------------
module board_pcd8544_red() {
    difference() {
        color("red") cube([43.5, 43.0, 1.2]);
        translate([1.75, 2.0, -interf]) {
            translate([ 0,  0, 0]) cylinder(r=1.25, h=(1.2 + interf * 2), $fn=16);
            translate([40,  0, 0]) cylinder(r=1.25, h=(1.2 + interf * 2), $fn=16);
            translate([ 0, 39, 0]) cylinder(r=1.25, h=(1.2 + interf * 2), $fn=16);
            translate([40, 39, 0]) cylinder(r=1.25, h=(1.2 + interf * 2), $fn=16);
        }
    }
    // Frame and LCD screen.
    difference() {
        translate([1.75, 5, 1.2])
            color("silver") cube([40, 34, 4]);
        translate([3.5, 7, 1.2 + 4 - 0.5])
            cube([36.5, 26, 0.6]);
    }
    translate([11.5, 42.5, 0])
        rotate(a=180, v=[1, 0, 0]) {
            pin_headers(8, 1);
            dupont_female(8, 1, [-1, 1, 0]);
        }
}

//------------------------------------------------------------------------
// Sub-models for the Raspberry Pi Models
//------------------------------------------------------------------------
module video_rca() {
    x = 10; y = 9.8; z = 13;
    d = 8.3; h = 9.5;
    color("yellow") cube([x, y, z]);
    translate([-h, y / 2, (d / 2) + 4])
        rotate(a=90, v=[0, 1, 0])
            color("silver") cylinder(r=(d / 2), h=h);
}
module audio_jack() {
    x = 11.4; y = 12; z = 10.2;
    d = 6.7; h = 3.4;
    color("blue") cube([x, y, z]);
    translate([-h, y / 2, (d / 2) + 3])
        rotate(a=90, v=[0, 1, 0])
            color("blue") cylinder(r=(d / 2), h=h);
}
module ethernet_connector(x, y, z) {
    color("silver") cube([x, y, z]);
}
module usb_connector(x, y, z) {
    f = 0.6; // Flange
    color("silver") cube([x, y, z]);
    translate([-f, y - f, -f])
        color("silver") cube([x + f * 2, f, z + f * 2]);
}
module hdmi_connector(x, y, z) {
    color("silver") cube([x, y, z]);
}
module microusb_connector(x, y, z) {
    color("silver") cube([x, y, z]);
}
module capacitor(d, h) {
    color("silver") cylinder(r=(d / 2), h=h);
}
module micro_sd_card() {
    color("silver")   translate([0,  0.0, -1.5]) cube([14, 13, 1.5]);
    color("darkblue") translate([2, -3.2, -1.0]) cube([11, 15, 1.0]);
}
module audio_video(size_x) {
    color([58/255, 58/255, 58/255]) {
        cube([size_x, 7, 5.6]);
        translate([size_x, 7 / 2, 5.6 / 2]) rotate([0,90,0]) cylinder(d=5.6, h=2.6);
    }
}

//------------------------------------------------------------------------
// Raspberry Pi Model B v.2
//------------------------------------------------------------------------
module board_raspberrypi_model_b_v2() {

    $fn = 32;
    x  = 56;     y = 85;    z =  1.6;	// Official PCB size
    ex = 15.40; ey = 21.8; ez = 13.0;	// Official Ethernet offset
    ex = 16.00; ey = 21.3; ez = 13.5;	// Measured Ethernet offset
    ux = 13.25; uy = 17.2; uz = 15.3;	// Official USB connector size
    hx = 11.40; hy = 15.1; hz = 6.15;	// Official HDMI connector size
    mx =  7.60; my =  5.6; mz = 2.40;	// Official micro USB power connector size

    // The origin is the lower face of PCB.
    translate([0, 0, z]) {
        translate([x - 2 - ex, y - ey + 1, 0])     ethernet_connector(ex, ey, ez);
        translate([1.5, 1.0, 0])                   pin_headers(2, 13);
        //translate([1.5, 1.0, 0])                 dupont_female(1, 6, [-1, -1, 0]);
        translate([2.1, 40.6, 0])                  video_rca();
        translate([0, 59.0, 0])                    audio_jack();
        translate([18.8, 85 - uy + 7.7, 0])        usb_connector(ux, uy, uz);
        translate([x - hx + 1.2, 37.5, 0])         hdmi_connector(hx, hy, hz);
        translate([x - mx - 3.6, -0.5, 0])         microusb_connector(mx, my, mz);
        translate([14, -18, -4.4])                 sd_card();     // Inserted
        //translate([14, -32, -4.4])               sd_card();     // Extracted
        translate([x - mx, -3, 1.2])               rotate(a=180, v=[0, 0, 1]) usb_male_micro_b_connector();
        translate([49.35, 12.75])                  capacitor(6.5, 8);
        translate([18.8 + 0.625, 83, 10.4])        wifi_usb_edimax();
        translate([0, 0, -z]) {
            color("green") linear_extrude(height=z)
                difference() {
                    square([x, y]);
                    raspberrypi_model_b_v2_holes();
                }
        }
    }
}

//------------------------------------------------------------------------
// Holes for the Raspberry Pi Model B v.2.
//------------------------------------------------------------------------
module raspberrypi_model_b_v2_holes() {
    x = 56; y = 85;
    translate([(x - 18), 25.5]) circle(r=(2.9 / 2), $fn=16);
    translate([12.5, (y - 5)])  circle(r=(2.9 / 2), $fn=16);
}

//------------------------------------------------------------------------
// Raspberry Pi Model A+ rev.1.1
//------------------------------------------------------------------------
module board_raspberrypi_model_a_plus_rev1_1() {

    $fn = 32;
    x  = 56;     y = 65;    z = 1.60;  // Measured PCB size
    hx = 11.40; hy = 15.1; hz = 6.15;  // Measured HDMI connector size
    ux = 13.25; uy = 13.8; uz = 6.0;   // Measured USB connector size
    mx =  5.60; my =  7.6; mz = 2.40;  // Measured micro USB power connector size

    // The origin is the lower face of PCB.
    translate([0, 0, z]) {
        translate([1.0, 7.1, 0])                    pin_headers(2, 20);
        translate([x - hx + 1, 32.0 - (hy / 2), 0]) hdmi_connector(hx, hy, hz);
        translate([x - mx + 1, 10.6 - (my / 2), 0]) microusb_connector(mx, my, mz);
        translate([18, y - 12, 0.8])                usb_connector(ux, uy, uz);
        translate([20.5, 0.8, -z])                  micro_sd_card();
        translate([x - 12.8, 50, 0])                audio_video(12.8);
        translate([18.6, y - 6, 1.4])               wifi_usb_edimax();
        translate([x + 2.2, 10.55, 1.2])            rotate(a=270, v=[0, 0, 1]) usb_male_micro_b_connector();
        translate([0, 0, -z]) {
            color("green") linear_extrude(height=z)
                difference() {
                    hull() {
                        translate([  3,   3]) circle(r=3);
                        translate([x-3,   3]) circle(r=3);
                        translate([x-3, y-3]) circle(r=3);
                        translate([  3, y-3]) circle(r=3);
                    }
                    raspberrypi_model_a_plus_rev1_1_holes();
                }
        }
    }
}

//------------------------------------------------------------------------
// Holes for the Raspberry Pi Model A+ rev.1.1.
//------------------------------------------------------------------------
module raspberrypi_model_a_plus_rev1_1_holes() {
    x = 56;
    translate([3.5, 3.5])            circle(r=(2.75 / 2), $fn=16);
    translate([(x - 3.5), 3.5])      circle(r=(2.75 / 2), $fn=16);
    translate([3.5, 3.5 + 58])       circle(r=(2.75 / 2), $fn=16);
    translate([(x - 3.5), 3.5 + 58]) circle(r=(2.75 / 2), $fn=16);
}


//------------------------------------------------------------------------
// Raspberry Pi 3 Model B v.1.2.
//------------------------------------------------------------------------
module board_raspberrypi_3_model_b() {
    x  = 56;     y = 85;    z = 1.60;  // Measured PCB size
    ex = 15.9; ey = 21.5; ez = 13.5;   // Ethernet measure
    ux = 13.1; uy = 17.1; uz = 15.5;   // Measured USB connector size
    hx = 11.40; hy = 15.1; hz = 6.15;  // Measured HDMI connector size
    mx =  5.60; my =  7.6; mz = 2.40;  // Measured micro USB power connector size
    // The origin is the lower face of PCB.
    translate([0, 0, z]) {
        translate([1.0, 7.1, 0])                    pin_headers(2, 20);
        translate([x - ex - 2.3, y - ey + 2.1, 0])  ethernet_connector(ex, ey, ez);
        translate([ 2.5, 85 - uy + 2.1, 0])         usb_connector(ux, uy, uz);
        translate([20.5, 85 - uy + 2.1, 0])         usb_connector(ux, uy, uz);
        translate([x - hx + 1.8, 25, 0])            hdmi_connector(hx, hy, hz);
        translate([x - 12.8, 50, 0])                audio_video(12.8);
        translate([20.5, 0.8, -z])                  micro_sd_card();
        translate([x - mx + 1, 7, 0])               microusb_connector(mx, my, mz);
        translate([x + 2.2, 10.55, 1.2])            rotate(a=270, v=[0, 0, 1]) usb_male_micro_b_connector();
        translate([0, 0, -z]) {
            color("green") linear_extrude(height=z)
                difference() {
                    hull() {
                        translate([  3,   3]) circle(r=3);
                        translate([x-3,   3]) circle(r=3);
                        translate([x-3, y-3]) circle(r=3);
                        translate([  3, y-3]) circle(r=3);
                    }
                    raspberrypi_3_model_b_holes();
                }
        }
    }
}

//------------------------------------------------------------------------
// Holes for Raspberry Pi 3 Model B v.1.2.
//------------------------------------------------------------------------
module raspberrypi_3_model_b_holes() {
    x = 56;
    translate([3.5, 3.5])            circle(r=(2.75 / 2), $fn=16);
    translate([(x - 3.5), 3.5])      circle(r=(2.75 / 2), $fn=16);
    translate([3.5, 3.5 + 58])       circle(r=(2.75 / 2), $fn=16);
    translate([(x - 3.5), 3.5 + 58]) circle(r=(2.75 / 2), $fn=16);
}

//------------------------------------------------------------------------
// GPS u-blox NEO-6M.
//------------------------------------------------------------------------
module ublox_neo6m_gps() {
    x = 24; y = 36; z = 0.80;
    holes_x = 18;
    holes_y = 30;
    hole_off_x = (x - holes_x) / 2;
    hole_off_y = (y - holes_y) / 2;
    pin_off_x = (x - 2.54 * 5) / 2;
    color([239/255, 32/255, 64/255]) linear_extrude(height=z) {
        difference() {
           square(size = [x, y]);
           translate([hole_off_x, hole_off_y]) circle(r=1.5, center=true, $fn=24);
           translate([hole_off_x + holes_x, hole_off_y]) circle(r=1.5, center=true, $fn=24);
           translate([hole_off_x, hole_off_y + holes_y]) circle(r=1.5, center=true, $fn=24);
           translate([hole_off_x + holes_x, hole_off_y + holes_y]) circle(r=1.5, center=true, $fn=24);
        }
    }
    translate([2, 12, z]) color("silver") cube(size=[15, 12, 2.4]);
    translate([9, 33, z+0.7]) color("gold") cylinder(r=1.3, h=1.4, center=true, $fn=24);
    //translate([pin_off_x, 3.54, 0]) rotate(a=180, v=[1, 0, 0]) pin_headers(5, 1);
    translate([pin_off_x, 3.54, 0]) rotate(a=180, v=[1, 0, 0]) pin_right_angle_low(5, 1);
}

//------------------------------------------------------------------------
// GYBMEP: BME280 pressure, humidity and temperature sensor.
//------------------------------------------------------------------------
module bme280_gybmep() {
    x = 10.5; y = 14; z = 1.5;
    pin_off_x = (x - 2.54 * 4) / 2;
    color([134/255, 49/255, 117/255]) linear_extrude(height=z) {
        difference() {
            square(size = [x, y]);
            translate([2.8, 10.9]) circle(r=1.5, center=true, $fn=24);
        }
    }
    translate([6.0, 9.6, z]) color("silver") cube(size=[2.5, 2.5, 0.93]);
    //translate([pin_off_x, 2.54, 0]) rotate(a=180, v=[1, 0, 0]) pin_headers(4, 1);
    translate([pin_off_x, 2.54, 0]) rotate(a=180, v=[1, 0, 0]) pin_right_angle_low(4, 1);
}

//------------------------------------------------------------------------
// GY-521: MPU-6050 Accelerometer and Gyroscope.
//------------------------------------------------------------------------
module mpu6050_gy521() {
    x = 21; y = 15.6; z = 1.2;
    color([30/255, 114/255, 198/255]) linear_extrude(height=z) {
        difference() {
            square(size = [x, y]);
            translate([3, y-3]) circle(r=1.5, center=true, $fn=24);
            translate([x-3, y-3]) circle(r=1.5, center=true, $fn=24);
        }
    }
    translate([8.3, 5.6, z]) color([60/255, 60/255, 60/255]) cube(size=[4.0, 4.0, 0.9]);
    //translate([0.34, 2.54, 0]) rotate(a=180, v=[1, 0, 0]) pin_headers(8, 1);
    translate([0.34, 2.54, 0]) rotate(a=180, v=[1, 0, 0]) pin_right_angle_low(8, 1);
}

//------------------------------------------------------------------------
// GY-273: QMC5883L 3-Axis Magnetic Sensor.
//------------------------------------------------------------------------
module qmc5883l_gy273() {
    x = 13.6; y = 18.5; z = 1.15;
    pin_off_x = (x - 2.54 * 5) / 2;
    color([30/255, 114/255, 198/255]) linear_extrude(height=z) {
        difference() {
            square(size = [x, y]);
            translate([2.5, y-3]) circle(r=1.5, center=true, $fn=24);
            translate([x-2.5, y-3]) circle(r=1.5, center=true, $fn=24);
        }
    }
    translate([5.1, 8.3, z]) color([60/255, 60/255, 60/255]) cube(size=[3.0, 3.0, 0.9]);
    //translate([pin_off_x, 2.54, 0]) rotate(a=180, v=[1, 0, 0]) pin_headers(5, 1);
    translate([pin_off_x, 2.54, 0]) rotate(a=180, v=[1, 0, 0]) pin_right_angle_low(5, 1);
}
