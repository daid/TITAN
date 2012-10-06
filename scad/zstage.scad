
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
			translate([-19,10]) mirrored([7,0]) circle(r=3/2);
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

module zGuideHolderPlate() {
	difference() {
		roundedSquare([20,35], r=6);
		translate([0, 12]) circle(r=3/2-laserOffset);
		translate([0,-12]) circle(r=3/2-laserOffset);
	}
}

module zGuideHolder() {
	difference() {
		union() {
			translate([0,5.5]) mirrored([53+6.5,0]) difference() {
				roundedSquare([20,35], r=6);
				circle(r=8/2-laserOffset);
			}
			translate([-(headPosMin+hotendDistance+(headPosMax-headPosMin)/2),-25.75]) {
				square([180-caseThickness*2,41.5],center=true);
				translate([-14,0]) mirrored([50,0]) translate([0,-41.5/2-caseThickness/2]) woodConnector1();
				mirrored([90-caseThickness/2,0]) rotate(90) woodConnector1(10);
			}
		}
		translate([-(headPosMin+hotendDistance+(headPosMax-headPosMin)/2),-25.75])
		{
			translate([-14,0]) mirrored([50,0]) translate([0,-41.5/2-caseThickness/2]) woodConnector2();
			mirrored([90-caseThickness/2,0]) rotate(90) woodConnector2(8);
		}
		translate([47,-30]) roundedSquare([25,25],r=2);
		translate([0,5.5]) mirrored([53+6.5,12]) {
			circle(r=3/2-laserOffset);
			circle(r=3/2-laserOffset);
		}
	}
}

module zStagePlatformGuide() {
	nutM6();
	render() difference() {
		linear_extrude(height=10) difference() {
			hull() {
				roundedSquare([13,20]);
				translate([6,15.5]) roundedSquare([25,10]);
			}
			circle(r=6/2);
		}
		translate([0,0,-1]) cylinder(r=12/2, h=8, $fn=6);
		translate([6,23,5]) mirrored([7,0]) {
			rotate([90,0,0]) cylinder(r=3.5/2,h=16);
			translate([0,-8,0]) {
				rotate([90,0,0]) cylinder(r=6.5/2,h=4,$fn=6,center=true);
				translate([0,0,5]) cube([6.5,4,10],center=true);
			}
		}
	}
}

module zScrewAssembly() {
	//M6 threaded rod
	threadedRod(6,100);
	translate([0,0,10]) nutM6();
	translate([0,0,2]) nutM6();
	
	if (displayPrinted) {
		translate([  0,0,8]) render() difference() {
			gear(number_of_teeth=9, circular_pitch=500, gear_thickness = 8, rim_thickness = 8, hub_thickness = 8);
			translate([0,0,2]) cylinder(r=12/2,h=8,$fn=6);
		}
		translate([-25,0,8]) union() {
			render() gear(number_of_teeth=9, circular_pitch=500, gear_thickness = 8, rim_thickness = 8, hub_thickness = 8);
			render() translate([0,0,-8]) difference() {
				import("pulleyAxes5mm.stl");
				translate([0,0,18]) cube([20,20,20],center=true);
			}
		}
	}
	
	if (displayPrinted) difference() {
		translate([-14,0,9]) cube([56,36,18],center=true);
		translate([  0,0,6]) cylinder(r=16,h=13);
		translate([-25,0,6]) cylinder(r=16,h=13);
		translate([-25,0,23]) cylinder(r=15,h=11);
		translate([  0,0,-1]) cylinder(r=14/2,h=30);
		translate([-25,0,-1]) cylinder(r=22/2,h=30);
		translate([-25,0,-1]) mirrored([13,13]) cylinder(r=4/2,h=30);
	}
	
	translate([0,0,20+zStagePos]) zStagePlatformGuide();
	
	translate([-25,0,18	]) rotate([0,180,0]) NEMA14();
}

module zStage() {
	translate([0,0,zStagePos]) {
		translate([0,0,6]) color([0.8,0.8,0.8,0.5]) linear_extrude(height=6) printerBed();
		translate([0,0,1.5]) wood(h=3) zBasePlate();
		translate([0,-55,0]) rotate([90,0,0]) wood(h=3) zBackPlate();
		translate([ 53,0,0]) rotate([90,0,90]) wood(h=3) zSidePlate();
		translate([-53,0,0]) rotate([90,0,90]) wood(h=3) zSidePlate();
	
		translate([0,-43,15.5]) mirrored([53+6.5,0]) {
			bearingLM8UU();
			translate([0,0,-15.5-3-zStagePos]) smoothRod(d=8,h=zMoveMax+25+7+3+3,center=false);
			translate([0,0,zMoveMax+20-zStagePos]) wood(h=3) zGuideHolderPlate();
		}
	}
	translate([0,-48.5,zMoveMax+30+3]) wood(h=3) zGuideHolder();
	
	translate([-25,-77,0]) zScrewAssembly();
}
