
module motorMount()
{
	NEMA14();
	if (bitIsSet(displayPrinted, 0)) {
		linear_extrude(height=5) difference() {
			square([36,36], center=true);
			circle(r=12);
			mirrored([13,13]) circle(r=3.2/2);
		}
		translate([0,23,0]) rotate([90,0,0]) translate([0,-18+5/2]) difference() {
			linear_extrude(height=5, convexity=2) {
				difference() {
					square([36,36+5], center=true);
					mirrored([10,10]) circle(r=3.2/2);
				}
			}
			mirrored([10,10]) translate([0,0,2]) cylinder(r=3.2,h=5);
		}
	}
	
	/*
	translate([0,-18,0]) rotate([90,0,0]) linear_extrude(height=5) {
		translate([0,-18+5/2]) square([36,36+5], center=true);
	}
	translate([-18,-18,0]) rotate([0,90,0]) linear_extrude(height=5) difference() {
		translate([36/2-5/2,-25/2]) square([36+5,25], center=true);
		translate([36/2-5/2,-25/2-5/2]) mirrored([12,5]) circle(r=3.2/2);
	}

	linear_extrude(height=5) hull() {
		translate([0,-36/2-5/2]) square([36,5], center=true);
		translate([-36/2+5/2,-36/2-25/2]) square([5,25], center=true);
	}

	translate([0,0,-36]) linear_extrude(height=5) hull() {
		translate([0,-36/2-5/2]) square([36,5], center=true);
		translate([-36/2+5/2,-36/2-25/2]) square([5,25], center=true);
	}

	translate([0,0,-36 / 2]) linear_extrude(height=5) hull() {
		translate([0,-36/2-5/2]) square([36,5], center=true);
		translate([-36/2+5/2,-36/2-25/2]) square([5,25], center=true);
	}
	*/
}
