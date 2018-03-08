//------------------------------------------------------------------------
// OpenSCAD models of miscellaneous components and devices:
// Pin headers, SD-Card, Edimax WiFi nano dongle, etc.
//
// Author:      Niccolo Rigacci <niccolo@rigacci.org>
// Version:     1.0 2017-12-14
// License:     GNU General Public License v3.0
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Rocker switch.
//------------------------------------------------------------------------
module rocker_switch() {
    x1 = 19.0; y1 = 12.0; z1 = 10.5;
    x2 = 21.5; y2 = 15.0; z2 =  2.0;
    x3 = 0.75; y3 =  4.9; z3 =  8.5;
    x4 = 15;   y4 =  10;  z4 =  4;
    step = 6.8;
    pin = 3;
    union() {
        color("brown") translate([-(x1 / 2), -(y1 / 2), -z1]) cube([x1, y1, z1]);
        color("brown") translate([-(x2 / 2), -(y2 / 2), 0])   cube([x2, y2, z2]);
        color("brown") rotate(a=10, v=[0, 1, 0]) translate([-(x4 / 2), -(y4 / 2), 0]) cube([x4, y4, z4]);
        for(i = [0 : (pin -1)]) {
            translate([-(((pin - 1) * step / 2)) + (step * i) - (x3 / 2), -(y3 / 2), -(z1 + z3)])
                color("silver") cube([x3, y3, z3]);
        }
    }
}

//------------------------------------------------------------------------
// Coaxial power plug 5.0 mm.
//------------------------------------------------------------------------
module coax_power_plug() {
    $fn = 32;
    rotate(a=270, v=[1, 0, 0]) {
    translate([0, 0, -4]) color("silver") cylinder(r=5/2, h=8, center=true);
        color([82/255, 82/255, 82/255]) {
            translate([0, 0, 5])    cylinder(r1=8/2,  r2=10/2, h=10, center=true);
            translate([0, 0, 19])   cylinder(r1=10/2, r2=7/2,  h=18, center=true);
            translate([0, 0, 35.5]) cylinder(r=4/2, h=15, center=true); // Cable
            translate([0, 0, -9])   cylinder(r=5/2, h=2,  center=true); // Tip
        }
    }
}

//------------------------------------------------------------------------
// Coaxial power plug 3.5 mm.
//------------------------------------------------------------------------
module coax_power_plug_3p5() {
    $fn = 32;
    rotate(a=270, v=[1, 0, 0]) {
    translate([0, 0, -4.5]) color("silver") cylinder(r=3.5/2, h=9, center=true);
        color([82/255, 82/255, 82/255]) {
            translate([0, 0, 6])    cylinder(r1=7/2,  r2=10/2, h=12, center=true);
            translate([0, 0, 20])   cylinder(r1=10/2, r2=7/2,  h=16, center=true);
            translate([0, 0, 35.5]) cylinder(r=4/2,   h=15, center=true); // Cable
            translate([0, 0, -9.5]) cylinder(r=3.5/2, h=1,  center=true); // Tip
        }
    }
}


//------------------------------------------------------------------------
// Coaxial power plug socket, with 2.1 mm pin.
//------------------------------------------------------------------------
module coax_power_socket() {
    r1 = 5.00; h1 = 4;
    r2 = 4.00; h2 = 8.0;
    r3 = 2.75; h3 = 10;  // Hole
    r4 = 6.50; h4 = 2.2; // Bolt
    r5 = 1.05; h5 = 3.0; // Center pin
    x1 = 2.2; y1 = 0.3; z1 = 5;
    step = 4.5;
    color([0.15, 0.15, 0.15]) difference() {
        union() {
            cylinder(r=r1, h=h1, $fn=18);
            translate([0, 0, -h2]) cylinder(r=r2, h=h2, $fn=18);
        }
        translate([0, 0, -h3 + h1 ]) cylinder(r=r3, h=(h3 + 0.1), $fn=18);
    }
    color("silver") cylinder(r=r5, h=h5, $fn=18);
    translate([0, 0, -(h4 + 2)]) color("gray") cylinder(r=r4, h=h4, $fn=6);
    translate([-(x1 / 2), (step - y1) / 2, -(h2 + z1)])  color("gold") cube([x1, y1, z1]);
    translate([-(x1 / 2), -(step + y1) / 2, -(h2 + z1)]) color("gold") cube([x1, y1, z1]);
}

//------------------------------------------------------------------------
// Metal momentary push switch 8 mm.
//------------------------------------------------------------------------
module push_switch_8mm() {
    $fn = 32;
    h1 = 3.3;
    h2 = 9.0;
    h3 = h2 + 1.0;
    x1 = 1.5; y1 = 0.5; z1 = 4.5;
    step = 3;
    translate([0, 0,   0]) color("silver") cylinder(r=12/2,  h=h1);
    translate([0, 0,  h1]) color("silver") cylinder(r=7.5/2, h=1.5);
    translate([0, 0, -h2]) color("silver") cylinder(r=7.8/2, h=h2);
    translate([0, 0, -h3]) color("white")  cylinder(r=4.8/2, h=1.1);
    translate([0, 0,  -6]) color("gray")   cylinder(r=11.3/2, h=2.4, $fn=6);
    translate([-(x1 / 2),  (step - y1) / 2, -(h3 + z1)]) color("gold") cube([x1, y1, z1]);
    translate([-(x1 / 2), -(step + y1) / 2, -(h3 + z1)]) color("gold") cube([x1, y1, z1]);
}

//------------------------------------------------------------------------
// Mini push button.
//------------------------------------------------------------------------
module push_button() {
    $fn = 24;
    r1 = 2.0; h1 = 4;
    r2 = 3.1; h2 = 6.5;
    r3 = 5.0; h3 = 8.0;
    r4 = 4.5; h4 = 1.8;  // Nut.
    x1 = 2.5; y1 = 0.3; z1 = 6;
    step = 5;
    translate([0, 0, h2])  color("black")  cylinder(r=r1, h=h1);
    translate([0, 0, 0])   color("silver") cylinder(r=r2, h=h2);
    translate([0, 0, -h3]) color("gray")   cylinder(r=r3, h=h3);
    translate([0, 0, 2])   color("gray")   cylinder(r=r4, h=h4, $fn=6);
    translate([-(x1 / 2), (step - y1) / 2, -(h3 + z1)])  color("gold") cube([x1, y1, z1]);
    translate([-(x1 / 2), -(step + y1) / 2, -(h3 + z1)]) color("gold") cube([x1, y1, z1]);
}

//------------------------------------------------------------------------
// Matrix of 2.54 mm dupont female connectors.
//------------------------------------------------------------------------
module dupont_female(cols, rows, wire_v) {
    w = 2.54; h = 14;
    wire_d = 1.2;
    z = 2.74; // Stay 0.2 mm above the pin connector.
    for(x = [0 : (cols -1)]) {
        for(y = [0 : (rows  - 1)]) {
            translate([w * x, w * y, z]) {
                color([0.2, 0.2, 0.2]) cube ([w, w, h]);
                translate([w / 2, w / 2, h]) {
                    color("red") cylinder(r=wire_d / 2, h=2.5);
                        translate([0, 0, 2.5]) rotate(a=90, v=wire_v)
                            color("red") cylinder(r=wire_d / 2, h=10, $fn=12);
                }
            }
        }
    }
}

//------------------------------------------------------------------------
// Matrix of 2.54 mm female connectors.
//------------------------------------------------------------------------
module pin_female(cols, rows=1) {
    w = 2.54; h = 8.5; p = 0.65;
    for(x = [0 : (cols -1)]) {
        for(y = [0 : (rows  - 1)]) {
            translate([w * x, w * y, 0]) {
                union() {
                    color([0.2, 0.2, 0.2]) difference() {
                        cube([w, w, h]);
                        translate([(w - p) / 2,(w - p) / 2,h - 6]) cube([p, p, 6.1]);
                    }
                    color("gold")  translate([(w - p) / 2, (w - p) / 2, -3]) cube([p, p, 3]);
                }
            }
        }
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
// Pin header, 2.54 mm, right angle, low profile.
//------------------------------------------------------------------------
module pin_right_angle_low(cols) {
    w = 2.54; p = 0.65;
    d = (w - p) / 2;
    for(x = [0 : (cols -1)]) {
        translate([w * x, 0, 0]) {
            color("black") translate([0, 2 + d, 0]) cube([w, w, w]);
            color("gold")  translate([d, d, -3]) cube([p, p, 3 + w / 2]);
            color("gold")  translate([d, d + 8 + w, d]) rotate(a=90, v=[1, 0, 0]) cube([p, p, 6 + w + 2]);
        }
    }
}

module pin_right_angle_low_custom(cols) {
    w = 2.54; p = 0.65;
    d = (w - p) / 2;
    for(x = [0 : (cols -1)]) {
        translate([w * x, 0, 0]) {
            color("black") translate([0, 0, 0]) cube([w, w, w]);
            color("gold")  translate([d, d, -3]) cube([p, p, 3 + w + p]);
            color("gold")  translate([d, 7.3 + d, w + 0.1]) rotate(a=90, v=[1, 0, 0]) cube([p, p, 7.3]);
        }
    }
}

 
//------------------------------------------------------------------------
// Pin header, 2.54 mm, right angle, high profile.
//------------------------------------------------------------------------
module pin_right_angle_high(cols) {
    w = 2.54; p = 0.65;
    d = (w - p) / 2;
    for(x = [0 : (cols -1)]) {
        translate([w * x, 0, 0]) {
            color("black") cube([w, w, w]);
            color("gold")  translate([d, d, -3]) cube([p, p, 9]);
            color("gold")  translate([d, d + 8, 9 - 3 - p]) rotate(a=90, v=[1, 0, 0]) cube([p, p, 8]);
        }
    }
}
 
//------------------------------------------------------------------------
// Pin hreader, 2.54 mm, right angle, double line.
//------------------------------------------------------------------------
module pin_right_angle_double(cols) {
    w = 2.54; p = 0.65;
    d = (w - p) / 2;
    for(x = [0 : (cols -1)]) {
        translate([w * x, 0, 0]) {
            color("black") translate([0, 2 + d + w, 0]) cube([w, w, w]);
            color("black") translate([0, 2 + d + w, w]) cube([w, w, w]);
            color("gold")  translate([d, d, -3]) cube([p, p, 3 + w / 2 + w]);
            color("gold")  translate([d, d + w, -3]) cube([p, p, 3 + w / 2]);
            color("gold")  translate([d, d + 8 + w + w, d + w]) rotate(a=90, v=[1, 0, 0]) cube([p, p, 6 + w + 2 + w]);
            color("gold")  translate([d, d + 8 + w + w, d]) rotate(a=90, v=[1, 0, 0]) cube([p, p, 6 + w + 2]);
        }
    }
}

//------------------------------------------------------------------------
// Secure Digital Memory Card 24x32 mm.
//------------------------------------------------------------------------
module sd_card() {
    color("blue")
        linear_extrude(height=2.1)
            polygon([[0, 0], [24, 0], [24, 32], [4.5, 32], [0, (32 - 4.5)]]);
}

//------------------------------------------------------------------------
// USB male Type-A connector.
//------------------------------------------------------------------------
module usb_male_type_a_connector() {
    $fn = 32;
    translate([0, -12/2, 0]) color("silver") cube(size=[12, 12, 4], center=true);
    color([82/255, 82/255, 82/255]) {
        translate([0, 22/2, 0]) cube(size=[16, 22, 8], center=true);
        translate([0, 22 + 4/2, 0]) cube(size=[7,  4,  7], center=true);
        translate([0, 22 + 4 + 15/2, 0]) rotate(a=90, v=[1, 0, 0]) cylinder(r=4/2, h=15, center=true);
    }
}

//------------------------------------------------------------------------
// USB male Micro-B connector.
//------------------------------------------------------------------------
module usb_male_micro_b_connector() {
    x1 = 6.85; y1 = 6.70; z1 = 1.80; // Metal part
    x2 = 10.5; y2 = 19;   z2 = 7;    // Plastic part
    r1 = 3.2;  r2 = 2.4; h = 10;     // Plastic cone part
    $fn = 32;
    translate([0, -y1/2, 0]) color("silver") cube([x1, y1, z1], center = true);
    color([82/255, 82/255, 82/255]) {
        translate([0, y2/2, 0]) cube([x2, y2, z2], center = true);
        translate([0, y2 + h/2, 0]) rotate(a=270, v=[1, 0, 0]) cylinder(r1=r1, r2=r2, h=h, center=true);
        translate([0, y2 + h + 5, 0]) rotate(a=90, v=[1, 0, 0]) cylinder(r=3.5/2, h=10, center=true);
    }
}

//------------------------------------------------------------------------
// USB male Type-B plug.
//------------------------------------------------------------------------
module usb_male_type_b_connector() {
    x1 = 8.0; y1 = 12.5; z1 = 7.5;  // Metal part
    x2 = 12; y2 = 31;   z2 = 11;    // Plastic part
    r1 = 4;  r2 = 3.5; h = 12;      // Plastic cone part
    $fn = 32;
    color("silver") difference() {
        translate([0, -y1/2, 0]) cube([x1, y1, z1], center = true);
        translate([ x1/2, -y1/2, z1/2]) rotate(a=45, v=[0,1,0]) cube([2, y1 + 0.2, 2], center = true);
        translate([-x1/2, -y1/2, z1/2]) rotate(a=45, v=[0,1,0]) cube([2, y1 + 0.2, 2], center = true);
    }
    color([82/255, 82/255, 82/255]) {
        translate([0, y2/2, 0]) cube([x2, y2, z2], center = true);
        translate([0, y2 + h/2, 0]) rotate(a=270, v=[1, 0, 0]) cylinder(r1=r1, r2=r2, h=h, center=true);
        translate([0, y2 + h + 5, 0]) rotate(a=90, v=[1, 0, 0]) cylinder(r=4/2, h=10, center=true);
    }
}

//------------------------------------------------------------------------
// Nano WiFi USB dongle by Edimax (EW-7811UN).
//------------------------------------------------------------------------
module wifi_usb_edimax() {
    x1 = 12.0; y1 = 12.0; z1 = 4.5;
    x2 = 15.0; y2 =  5.5; z2 = 7.0;
    color("gold") cube([x1, y1, z1]);
    translate([(x1 - x2) / 2, y1, (z1 - z2) / 2])
        color("black") cube([x2, y2, z2]);
}
