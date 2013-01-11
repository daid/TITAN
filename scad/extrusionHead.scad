headWallThickness = 7;
headBushingExtend = 10;

module headDesignPrinted() {
	bushingMinHeight = bushingDiameter + headWallThickness * 2;
	screwHoleDistance = (bushingMinHeight + headBushingExtend)/2 - (headWallThickness/2);
	
	if (bitIsSet(displayPrinted, 3)) {
		translate([0,headBushingExtend/2,15+1*explode]) rotate([90,0,0]) bushing(h=bushingMinHeight + headBushingExtend);
		translate([headBushingExtend/2,0,  -1*explode]) rotate([0,90,0]) bushing(h=bushingMinHeight + headBushingExtend);
	
		//Center block
		difference() {
			translate([headBushingExtend/2,headBushingExtend/2,15/2]) linear_extrude(height=15-0.2,center=true) roundedSquare([bushingMinHeight + headBushingExtend,bushingMinHeight + headBushingExtend],r=3);
			//Bushing openings
			translate([0,headBushingExtend/2,15]) rotate([90,0,0]) cylinder(h=bushingMinHeight + headBushingExtend+1,r=bushingDiameter/2,center=true);
			translate([headBushingExtend/2,0, 0]) rotate([0,90,0]) cylinder(h=bushingMinHeight + headBushingExtend+1,r=bushingDiameter/2,center=true);
			//Screw holes
			translate([headBushingExtend/2-screwHoleDistance,headBushingExtend/2-screwHoleDistance,0]) cylinder(h=45,r=3.5/2,center=true);
			translate([headBushingExtend/2-screwHoleDistance,headBushingExtend/2+screwHoleDistance,0]) cylinder(h=45,r=3.5/2,center=true);
			translate([headBushingExtend/2+screwHoleDistance,headBushingExtend/2-screwHoleDistance,0]) cylinder(h=45,r=3.5/2,center=true);
			translate([headBushingExtend/2+screwHoleDistance,headBushingExtend/2+screwHoleDistance,0]) cylinder(h=45,r=3.5/2,center=true);
		
			translate([hotendDistance, hotendDistance,-1]) cylinder(r=7/2,h=100);//Bowden tube
		}

		//Bottom block
		translate([0,0,-2*explode]) difference() {
			translate([headBushingExtend/2,headBushingExtend/2,-bushingMinHeight/2]) linear_extrude(height=bushingMinHeight/2) roundedSquare([bushingMinHeight + headBushingExtend,bushingMinHeight + headBushingExtend],r=3);
			//Bushing openings
			translate([headBushingExtend/2,0,0]) rotate([0,90,0]) cylinder(h=bushingMinHeight + headBushingExtend+1,r=bushingDiameter/2,center=true);
			//Screw holes
			translate([headBushingExtend/2-screwHoleDistance,headBushingExtend/2-screwHoleDistance,0]) cylinder(h=35,r=3.5/2,center=true);
			translate([headBushingExtend/2-screwHoleDistance,headBushingExtend/2+screwHoleDistance,0]) cylinder(h=35,r=3.5/2,center=true);
			translate([headBushingExtend/2+screwHoleDistance,headBushingExtend/2-screwHoleDistance,0]) cylinder(h=35,r=3.5/2,center=true);
			translate([headBushingExtend/2+screwHoleDistance,headBushingExtend/2+screwHoleDistance,0]) cylinder(h=35,r=3.5/2,center=true);
		
			translate([hotendDistance, hotendDistance,-bushingMinHeight]) cylinder(r=11/2,h=100);
			translate([hotendDistance, hotendDistance,-bushingMinHeight]) cylinder(r=18/2,h=bushingMinHeight/2+3);
	
			//translate([hotendDistance,0,-25]) cube([50,50,50]);
		}

		//Top block
		translate([0,0,15+2*explode]) difference() {
			translate([headBushingExtend/2,headBushingExtend/2,0]) linear_extrude(height=bushingMinHeight/2) roundedSquare([bushingMinHeight + headBushingExtend,bushingMinHeight + headBushingExtend],r=3);
			//Bushing openings
			translate([0,headBushingExtend/2,0]) rotate([90,0,0]) cylinder(h=bushingMinHeight + headBushingExtend+1,r=bushingDiameter/2,center=true);
			//Screw holes
			translate([headBushingExtend/2-screwHoleDistance,headBushingExtend/2-screwHoleDistance,0]) cylinder(h=35,r=3.5/2,center=true);
			translate([headBushingExtend/2-screwHoleDistance,headBushingExtend/2+screwHoleDistance,0]) cylinder(h=35,r=3.5/2,center=true);
			translate([headBushingExtend/2+screwHoleDistance,headBushingExtend/2-screwHoleDistance,0]) cylinder(h=35,r=3.5/2,center=true);
			translate([headBushingExtend/2+screwHoleDistance,headBushingExtend/2+screwHoleDistance,0]) cylinder(h=35,r=3.5/2,center=true);
		
			translate([hotendDistance, hotendDistance,]) rotate_extrude(convexity=2) {
				translate([0,-1]) square([7/2,100]);
				translate([0,bushingMinHeight/2]) polygon([[0,1],[4.5,1],[4.5,-2],[6,-5],[6,-20],[0,-20]]);
			}
		}
	}

	//Bottom wood plate
	translate([0,0,-4*explode-bushingMinHeight/2-3-1]) wood() headBottomPlate();
	
	translate([hotendDistance, hotendDistance,-bushingMinHeight/2+3-3*explode]) hotEndV2();
}

module headBottomPlate() {
	bushingMinHeight = bushingDiameter + headWallThickness * 2;
	screwHoleDistance = (bushingMinHeight + headBushingExtend)/2 - (headWallThickness/2);

	difference() {
		translate([headBushingExtend/2,headBushingExtend/2]) roundedSquare([bushingMinHeight + headBushingExtend,bushingMinHeight + headBushingExtend],r=3);
		//Screw holes
		translate([headBushingExtend/2-screwHoleDistance,headBushingExtend/2-screwHoleDistance]) circle(r=3.1/2);
		translate([headBushingExtend/2-screwHoleDistance,headBushingExtend/2+screwHoleDistance]) circle(r=3.1/2);
		translate([headBushingExtend/2+screwHoleDistance,headBushingExtend/2-screwHoleDistance]) circle(r=3.1/2);
		translate([headBushingExtend/2+screwHoleDistance,headBushingExtend/2+screwHoleDistance]) circle(r=3.1/2);
		translate([hotendDistance, hotendDistance]) circle(r=14/2);
	}
}

