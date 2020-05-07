/*
 * OpenSCAD model for tethered multimeter probe caps.
 *
 * Copyright 2020 Tido Klaassen (tido_oscad@4gh.eu).
 * Licensed under terms of Creative Commons Attribution Share Alike 4.0
 * https://creativecommons.org/licenses/by-sa/4.0/
 */

// Inner diameter of leash ring
ring = 9;

// Length of leash
leash = 55;

// Diameter of ring and leash
dia = 1.2;

// Height of tip cap
cap_h = 8;

// Outer diameter of tip cap
cap_d = 5;

// Diameter of tip hole
cap_i = 1.2;
$fn = 32;

// Create ring
difference(){
cylinder(h = dia, d = ring + 2 * dia, center = false);
cylinder(h = dia, d = ring, center = false);
};

// Create tether
translate([-dia / 2, ring / 2, 0])
cube(size = [dia, leash, dia], center = false);

// Create cap
translate([0, ring / 2 + leash + dia, 0])
difference(){
cylinder(h = cap_h, d = cap_d, center = false);
cylinder(h = cap_h * 0.75, d = cap_i, center = false);
}
