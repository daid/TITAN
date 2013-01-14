module sliderBlock()
{
	if (bitIsSet(displayPrinted, 1)) union() {
		rotate([0,90,0]) bushing();
		
		render() difference() {
			rotate([0,90,0]) linear_extrude(height=20,center=true,convexity=2) {
				difference() {
					hull() {
						circle(r=8);
						translate([-19,0]) roundedSquare([8,16],r=2);
					}
					circle(r=6);
					translate([-15,0]) square([4,6],center=true);
				}
			}
			translate([0,0,17.5]) rotate([90,0,0]) cylinder(r=6.5/2,h=20,center=true);
			translate([-5,-10,16.5]) cube([20,20,0.5]);
			translate([6, 4,7]) cylinder(r=3.5/2,h=25);
			translate([6,-4,7]) cylinder(r=3.5/2,h=25);
			translate([3,-15,8]) cube([7,30,3]);
		}
	}
}

module pulley6mm()
{
	if (bitIsSet(displayPrinted, 2)) translate([0,0,-12]) import("../stl/parts/pulleyAxes6mm.stl");
}
module pulley5mm()
{
	if (bitIsSet(displayPrinted, 2)) translate([0,0,-12]) import("../stl/parts/pulleyAxes5mm.stl");
}
module pulley6mmDual()
{
	if (bitIsSet(displayPrinted, 2)) translate([0,0,-12]) import("../stl/parts/pulleyAxes6mmDualBelt.stl");
}

module bushing(h=20)
{
	$fs=0.1;
	render() difference() {
		linear_extrude(height=h, twist=360/6, center=true) {
			for(i=[0:5]) {
				rotate(i*360/6) translate([0,3+1.0]) circle(r=1.0);
				rotate(i*360/6) translate([0,3+1.2]) rotate(-360/6/2) square([4,0.8]);
				rotate((i+0.5)*360/6) translate([0,3+2.0]) square([1.2,2],center=true);
			}
			difference() {
				circle(r=bushingDiameter/2);
				circle(r=5.8);
			}
		}
		
	}
}

module beltClamp(h=9,w=16) {
	if (bitIsSet(displayPrinted, 4)) difference() {
		linear_extrude(height=h,convexity=2) difference() {
			square([w,12],center=true);
		}
		translate([-w/2+5,0,25.7]) rotate([0,90,0])
			linear_extrude(height=w,convexity=2) T5Belt(length=35);
		translate([-w/2+3,0,h/2]) rotate([90,0,0]) cylinder(r=3.5/2,h=20,center=true);
		translate([ w/2-3,0,h/2]) rotate([90,0,0]) cylinder(r=3.0/2,h=20,center=true);
	}
}

module T5pulleyBelt(length=140,clampsInside=false)
{
	if (bitIsSet(displayMechanics, 3)) {
		color([0.4,0.4,0.4]) translate([0, 7,0]) rotate([180,0,0]) linear_extrude(height=5,center=true) T5Belt(length=length);
		color([0.4,0.4,0.4]) translate([0,-7,0]) linear_extrude(height=5,center=true) T5Belt(length=length);
	}
	if (clampsInside)
	{
		translate([length/2-7, 3,0]) rotate([90,90,0]) beltClamp();
		translate([length/2+7, 3,0]) rotate([90,-90,0]) beltClamp();
	}else{
		translate([length/2-7,-8,0]) rotate([90,90,0]) beltClamp();
		translate([length/2+7,-8,0]) rotate([90,-90,0]) beltClamp();
	}
}

module xyStage() {
	translate([headPosX,0,17.5]) rotate([90,0,0]) smoothRod(6, 150);
	translate([0,headPosY, 2.5]) rotate([0,90,0]) smoothRod(6,150);
	translate([ 0, 70, 0]) rotate([ 0,90,0]) smoothRod(6,180);
	translate([ 0,-70, 0]) rotate([ 0,90,0]) smoothRod(6,180);
	translate([ 70, 0,20]) rotate([90,90,0]) smoothRod(6,180);
	translate([-70, 0,20]) rotate([90,90,0]) smoothRod(6,180);

	translate([-70, 90,20]) rotate([90,90,0]) bearing626();
	translate([-90, 70, 0]) rotate([0,90,0]) bearing626();
	translate([ 70, 90,20]) rotate([90,90,0]) bearing626();
	translate([ 84, 70, 0]) rotate([0,90,0]) bearing626();
	translate([ 70,-84,20]) rotate([90,90,0]) bearing626();
	translate([ 84,-70, 0]) rotate([0,90,0]) bearing626();
	translate([-70,-84,20]) rotate([90,90,0]) bearing626();
	translate([-90,-70, 0]) rotate([0,90,0]) bearing626();
	translate([ 70, 70, 0]) rotate([0,-90,0]) pulley6mm();
	translate([ 70, 70,20]) rotate([90,0,0]) pulley6mm();
	translate([-70, 70, 0]) rotate([0,90,0]) pulley6mm();
	translate([-70, 70,20]) rotate([90,0,0]) pulley6mmDual();
	translate([ 70,-70, 0]) rotate([0,-90,0]) pulley6mmDual();
	translate([ 70,-70,20]) rotate([-90,0,0]) pulley6mm();
	translate([-70,-70, 0]) rotate([0,90,0]) pulley6mm();
	translate([-70,-70,20]) rotate([-90,0,0]) pulley6mm();

	//X/Y square belts
	translate([ 70, 70, 0]) rotate([90,0,-90]) T5pulleyBelt();
	translate([ 70, 70,20]) rotate([-90,0,180]) T5pulleyBelt();
	translate([-70,-70, 0]) rotate([90,0,90]) T5pulleyBelt();
	translate([-70,-70,20]) rotate([-90,0,0]) T5pulleyBelt();
	//X/Y belts to motors
	translate([ 55,-70, 0]) rotate([90,90,90]) T5pulleyBelt(110,true);
	translate([-70, 55,20]) rotate([90,90,0]) T5pulleyBelt(130,true);

	translate([headPosX,70,0]) sliderBlock();
	translate([headPosX,-70,0]) rotate([0,0,180]) sliderBlock();

	translate([ 70,headPosY,20]) rotate([0,180,-90]) sliderBlock();
	translate([-70,headPosY,20]) rotate([0,180, 90]) sliderBlock();

	translate([headPosX,headPosY,2.5]) headDesignPrinted();
}
