module leg(diameter, far = 5, height = 9, lift = 12, magnetDiameter, magnetThickness) {
    translate([diameter / 2 + far, 0, -diameter / 2 - lift]) {
        colwidth = (magnetDiameter / 2) + 2;

        difference() {
            cylinder(h = diameter / 5 + height, r = colwidth);
            cylinder(h = magnetThickness + 0.1, r = ((magnetDiameter / 2) + 0.3));
        }
    }  
}

module sensor() {
    hull() {              
        translate([2.75, 1.75, -4])
        cylinder(h = 2, r = 8.25);

        translate([2.75, -1.75, -4])
        cylinder(h = 2, r = 8.25);

        translate([-2.75, 1.75, -4])
        cylinder(h = 2, r = 8.25);

        translate([-2.75, -1.75, -4])
        cylinder(h = 2, r = 8.25);
    }

    hull() {
        translate([2.75, 1.75, -19.0])
        cylinder(h = 15, r = 10);

        translate([2.75, -1.75, -19.0])
        cylinder(h = 15, r = 10);

        translate([-2.75, 1.75, -19.0])
        cylinder(h = 15, r = 10);

        translate([-2.75, -1.75, -19.0])
        cylinder(h = 15, r = 10);

        translate([0, 0, -19.0])
        cube([40, 40, 30], center = true);
    }

    translate([12.5, 0, -12]) 
    cylinder(r = 1.25, h = 12);

    translate([-12.5, 0, -12]) 
    cylinder(r = 1.25, h = 12);

    hull() {
        translate([-0.5, 0, -2.5])
        cylinder(h = 2.5, r1 = 3.5, r2 = 2.5);

        translate([2, 0, -2.5])
        linear_extrude(height = 2.5, scale = 0.66) 
        square([6.5, 6.5], center = true); 
    }
}

function bearingDepth(bearingVersion) = 
    bearingVersion == 1 ? -4.25 :
    bearingVersion == 2 ? -3 :
    bearingVersion == 3 ? -3.9 :
    0;

module bearing(diameter, is_ball = false) {
    bearingDepth = bearingDepth(bearingVersion);

    if (is_ball) {
        translate([0, 0, -diameter / 2 - bearingDepth]) 
        sphere(r = 4, $fn = 30);
    } else {
        height = 18;

        translate([0, 0, -diameter / 2 - 1]) {
            translate([0, 0, bearingDepth]) 
            cylinder(h = 7, r = 7.90);

            translate([0, 0, -height]) 
            cylinder(h = height, r = 6.5);
        }
    }
}

module bearings(diameter, shift = 0) {
    rotate([65, 0, 0 + shift]) bearing(diameter);
    rotate([65, 0, 120 + shift]) bearing(diameter);
    rotate([65, 0, 240 + shift]) bearing(diameter);
}

function topLift(diameter) = 
    diameter == 34 ? 2 :
    diameter == 44 ? 8 :
    diameter == 52 ? 8 :
    0;

function height(diameter) = 
    diameter == 34 ? 13.1 :
    diameter == 44 ? 22 :
    diameter == 52 ? 22 :
    0;

function aperture(diameter) = 
    diameter == 34 ? 3 :
    diameter == 44 ? 0 :
    diameter == 52 ? 0 :
    0;

module cup(diameter, dispBall = false) {
    topLift = topLift(diameter);
    height = height(diameter);
    aperture = aperture(diameter);

    if (dispBall) {
        color("red") 
        sphere(r = diameter / 2, $fn = 50);
    }

    color("gray") difference() {
        sphere(r = diameter / 2 + (diameter == 34 ? 10.5 : 8.5), $fn = 50);
        sphere(r = diameter / 2 + 1.00, $fn = 50);

        translate([0, 0, 0]) 
        linear_extrude(50) 
        circle(r = diameter / 2 + 0.5, $fn = 100);

        translate([0, 0, topLift]) 
        linear_extrude(50) 
        circle(r = diameter / 2 + (diameter == 34 ? 15 : 10));

        translate([0, 0, -diameter / 2 - 10]) 
        difference() { 
            cylinder(h = diameter / 2 + height, r = diameter / 2 + (diameter == 34 ? 11 : 10));
            cylinder(h = diameter / 2 + height, r1 = diameter / 2 + (diameter == 34 ? 30 : 20), r2 = diameter / 2 + aperture);
        }
    }
}

function lift(diameter) = 
    diameter == 34 ? 13 :
    diameter == 44 ? 13 :
    diameter == 52 ? 10.5 :
    10.5;  

function topCutMove(diameter) = 
    diameter == 34 ? 4.5 :
    diameter == 44 ? 5 :
    diameter == 52 ? 3 :
    0;

function topCutDepth(diameter) = 
    diameter == 34 ? 5 :
    diameter == 44 ? 13 :
    diameter == 52 ? 13 :
    0;

function primarySideCutMove(diameter) = 
    diameter == 34 ? 25 :
    diameter == 44 ? 30 :
    diameter == 52 ? 30 :
    0;

function primarySideCutDepth(diameter) = 
    diameter == 34 ? 13 :
    diameter == 44 ? 19 :
    diameter == 52 ? 16.5 :
    0;

function primarySideCutHeight(diameter, useHexaLegs) = 
    diameter == 34 ? (useHexaLegs ? 5 : 100) :
    diameter == 44 ? (useHexaLegs ? 36.4 : 100) :
    diameter == 52 ? (useHexaLegs ? 38 : 100) :
    0;

function secondarySideCutMove(diameter) = 
    diameter == 34 ? 5 :
    diameter == 44 ? 32 :
    diameter == 52 ? 34.2 :
    0;

function secondarySideCutDepth(diameter) = 
    diameter == 34 ? 5 :
    diameter == 44 ? 17 :
    diameter == 52 ? 16.5 :
    0;

function primaryChamferMove(diameter) = 
    diameter == 34 ? -18 :
    diameter == 44 ? -20 :
    diameter == 52 ? -21 :
    0;

function primaryChamferCutDepth(diameter) = 
    diameter == 34 ? 5 :
    diameter == 44 ? 5 :
    diameter == 52 ? 5 :
    0;

function primaryChamferCutAngle(diameter) = 
    diameter == 34 ? 135 :
    diameter == 44 ? 135 :
    diameter == 52 ? 135 :
    0;

function secondaryChamferMove(diameter) = 
    diameter == 34 ? -16 :
    diameter == 44 ? -17 :
    diameter == 52 ? -18 :
    0;

function secondaryChamferCutDepth(diameter) = 
    diameter == 34 ? 4 :
    diameter == 44 ? 4 :
    diameter == 52 ? 4 :
    0;

function secondaryChamferCutAngle(diameter) = 
    diameter == 34 ? 130 :
    diameter == 44 ? 130 :
    diameter == 52 ? 130 :
    0;

function legOutwardMove(diameter) = 
    diameter == 34 ? 8 :
    diameter == 44 ? 2.25 :
    diameter == 52 ? 0 :
    0;   

function legHeight(diameter) = 
    diameter == 34 ? 8 :
    diameter == 44 ? 8 :
    diameter == 52 ? 8 :
    0;   

function sensorPCBCutMove(diameter) = 
    diameter == 34 ? -26 :
    diameter == 44 ? -31 :
    diameter == 52 ? 0 :
    0;  

function sensorPCBCutRadius(diameter) = 
    diameter == 34 ? ((diameter / 2) + 3) :
    diameter == 44 ? ((diameter / 2) - 3) :
    diameter == 52 ? 0 :
    0;

module cupBase(diameter, bottomHeight, isBottom = false, column = false, bearing_shift = 60, magnetDiameter = 8, magnetThickness = 3, useHexaLegs = false) {
    lift = lift(diameter);

    topCutMove = topCutMove(diameter);
    topCutDepth = topCutDepth(diameter);

    primarySideCutMove = primarySideCutMove(diameter);
    primarySideCutDepth = primarySideCutDepth(diameter);
    primarySideCutHeight = primarySideCutHeight(diameter, useHexaLegs);

    secondarySideCutMove = secondarySideCutMove(diameter);
    secondarySideCutDepth = secondarySideCutDepth(diameter);

    primaryChamferMove = primaryChamferMove(diameter); 
    primaryChamferCutDepth = primaryChamferCutDepth(diameter); 
    primaryChamferCutAngle = primaryChamferCutAngle(diameter); 

    secondaryChamferMove = secondaryChamferMove(diameter); 
    secondaryChamferCutDepth = secondaryChamferCutDepth(diameter); 
    secondaryChamferCutAngle = secondaryChamferCutAngle(diameter);

    legOutwardMove = legOutwardMove(diameter);
    legHeight = legHeight(diameter);
    legRotationBase = (useHexaLegs ? 0 : 30);
    legRotationIncrement = (useHexaLegs ? 60 : 120);    

    sensorPCBCutMove = sensorPCBCutMove(diameter);
    sensorPCBCutRadius = sensorPCBCutRadius(diameter);

    translate([0, 0, diameter / 2 + lift]) {
        if (!isBottom) {
            difference() {
                cup(diameter, dispBall = false);
                bearings(diameter, bearing_shift);
                // Sensor
                translate([0, 0, -diameter / 2 - 10]) cylinder(h = bottomHeight, r = diameter);
                translate([0, 0, -diameter / 2]) sensor();

                translate([0, 0, topCutMove])
                cube([100, 100, topCutDepth], true);

                for (i = [0:2]) {
                    rotate([0, 0, 90 + (i * 120)])
                    translate([primarySideCutMove, 0, 0])
                    cube([primarySideCutDepth, 100, primarySideCutHeight], true);

                    if (useHexaLegs) {           
                        rotate([0, 0, 90 + (i * 120)])
                        translate([secondarySideCutMove, 0, 0])
                        cube([secondarySideCutDepth, 100, 100], true);
                    }
                }

                // Chamfers. There are two for each bearing, to remove a bit more material than I could manage with one cut. 
                for (i = [0:2]) {
                    rotate([0, primaryChamferCutAngle, 30 + (120 * i)])
                    translate([primaryChamferMove, 0, 0])
                    cube([primaryChamferCutDepth, 100, 100], true);

                    rotate([0, secondaryChamferCutAngle, 30 + (120 * i)])
                    translate([secondaryChamferMove, 0, 0])
                    cube([secondaryChamferCutDepth, 100, 100], true);
                }
            }
        }
        difference() {
            union() {            
                for (i = [0:(useHexaLegs ? 5 : 2)]) {
                    rotate([0, 0, legRotationBase + (legRotationIncrement * i)])
                    translate([legOutwardMove, 0, 0]) 
                    leg(diameter, -3, height = legHeight, lift = lift, magnetDiameter = magnetDiameter, magnetThickness = magnetThickness);
                }                       

            }

            sphere(r = diameter / 2 + 1.25, $fn = 50);
            bearings(diameter, bearing_shift);

            translate([0, 0, sensorPCBCutMove]) 
            linear_extrude(5) 
            circle(r = sensorPCBCutRadius);
        }
    }
}

detail = 100;
