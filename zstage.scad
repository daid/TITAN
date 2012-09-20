
module printerBed() {
	difference() {
		roundedSquare([100,100],r=4);
		mirrored([45,45]) circle(r=3/2-laserOffset);
	}
}

module zBasePlate() {
	difference() {
		translate([0,-3]) roundedSquare([114,110],r=4);
		mirrored([45,45]) circle(r=3/2-laserOffset);
		translate([0,-55]) mirrored([-30,0]) woodConnector3();
		translate([0,5]) mirrored([53,30]) rotate(90) woodConnector3(8);

		translate([0,-43]) mirrored([53+6.5,0]) circle(r=12/2);
		
		translate([0,-50]) mirrored([53,0]) square([3,30],center=true);
	}
}

module zBackPlate() {
	translate([0, 30/2]) union() {
		difference() {
			square([103,30], center=true);
			translate([0,-30/2]) square([114,6],center=true);
			translate([0,-30/2+3/2]) mirrored([30,0]) woodConnector2();
			mirrored([53,0]) rotate(90) woodConnector2(8);
		}
		mirrored([53,0]) rotate(90) woodConnector1(8);
		translate([0,-30/2+3/2]) mirrored([30,0]) woodConnector1();
	}
}

module zSidePlate()
{
	translate([0, 30/2]) union() {
		difference() {
			intersection() {
				square([115,30], center=true);
				union() {
					translate([20,-15]) circle(r=30);
					translate([-20,0]) square([80,30], center=true);
				}
			}
			translate([15,-30/2]) square([100,6],center=true);
			translate([5,-30/2+3/2]) mirrored([30,0]) woodConnector2(8);
			translate([-55,0]) rotate(90) woodConnector3(8);
			translate([-43, 0.5]) {
				square([12-laserOffset*2,25-laserOffset*2],center=true);
				translate([ 8.5, 8]) square([1.50,5],center=true);
				translate([-8.5, 8]) square([1.50,5],center=true);
				translate([ 8.5,-8]) square([1.50,5],center=true);
				translate([-8.5,-8]) square([1.50,5],center=true);
			}
		}
		translate([5,-30/2+3/2]) mirrored([30,0]) woodConnector1(8);
	}
}

module zGuideHolder() {
	difference() {
		union() {
			mirrored([53+6.5,0]) difference() {
				roundedSquare([20,35], r=6);
				translate([0,5.5]) circle(r=8/2+laserOffset);
			}
			translate([0,-20]) square([158,30],center=true);
			translate([-(headPosMin+hotendDistance+(headPosMax-headPosMin)/2),-31.5]) {
				square([180-caseThickness*2,30],center=true);
				mirrored([65,0]) translate([0,-15-caseThickness/2]) woodConnector1();
				mirrored([90-caseThickness/2,0]) rotate(90) woodConnector1(8);
			}
		}
		translate([-(headPosMin+hotendDistance+(headPosMax-headPosMin)/2),-31.5])
		{
			mirrored([65,0]) translate([0,-15-caseThickness/2]) woodConnector2();
			mirrored([90-caseThickness/2,0]) rotate(90) woodConnector2(8);
		}
		translate([45,-30]) roundedSquare([15,25],r=2);
	}
}

module zScrewAssembly() {
	%cylinder(r=6/3,h=100);
	translate([  0,0,8]) render() difference() {
		gear(number_of_teeth=9, circular_pitch=500, gear_thickness = 8, rim_thickness = 8, hub_thickness = 8);
		translate([0,0,-1]) cylinder(r=12/2,h=10,$fn=6);
	}
	translate([-25,0,8]) union() {
		render() gear(number_of_teeth=9, circular_pitch=500, gear_thickness = 8, rim_thickness = 8, hub_thickness = 8);
		render() translate([0,0,-8]) difference() {
			import("pulleyAxes5mm.stl");
			translate([0,0,18]) cube([20,20,20],center=true);
		}
	}
	translate([0,0,16]) nutM6();
	
	difference() {
		translate([-14,0,9]) cube([56,36,18],center=true);
		translate([  0,0,6]) cylinder(r=16,h=13);
		translate([-25,0,6]) cylinder(r=16,h=13);
		translate([-25,0,23]) cylinder(r=15,h=11);
		translate([  0,0,-1]) cylinder(r=14/2,h=30);
		translate([-25,0,-1]) cylinder(r=22/2,h=30);
		translate([-25,0,-1]) mirrored([13,13]) cylinder(r=4/2,h=30);
	}
	
	translate([-25,0,18	]) rotate([0,180,0]) NEMA14();
}

module zStage() {
	translate([0,0,zStagePos]) {
		translate([0,0,6]) color([0.8,0.8,0.8,0.5]) linear_extrude(height=6) printerBed();
		%translate([0,0,1.5]) wood(h=3) zBasePlate();
		translate([0,-55,0]) rotate([90,0,0]) wood(h=3) zBackPlate();
		translate([ 53,0,0]) rotate([90,0,90]) wood(h=3) zSidePlate();
		translate([-53,0,0]) rotate([90,0,90]) wood(h=3) zSidePlate();
	
		translate([0,-43,15.5]) mirrored([53+6.5,0]) {
			bearingLM8UU();
			%translate([0,0,-15.5-3-zStagePos]) cylinder(r=8/2,h=zMoveMax+25+7+3+3);
		}
	}
	translate([0,-48.5,zMoveMax+30+3]) wood(h=3) zGuideHolder();
	
	translate([-20,-77,0]) zScrewAssembly();
}
