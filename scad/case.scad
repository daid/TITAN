module bearingHole() {
	rotate(45) {
		circle(r=19/2-laserOffset);
		translate([-14,0]) circle(r=3/2);
		translate([ 14,0]) circle(r=3/2);
	}
}

module casePanel() {
	difference() {
		translate([ 5,0]) roundedSquare([190+laserOffset*2,180+4*2+laserOffset*2],r=4);
		hull() {
			translate([100,0]) mirrored([0, 50]) circle(r=10);
			translate([115,0]) mirrored([0, 70]) circle(r=5);
		}
	}
}

module caseFrontBack() {
	difference() {
		casePanel();
		translate([ 50, (180/2-caseThickness/2)]) woodConnector3();
		translate([-65, (180/2-caseThickness/2)]) woodConnector3();
		translate([ 50,-(180/2-caseThickness/2)]) woodConnector3();
		translate([-65,-(180/2-caseThickness/2)]) woodConnector3();
		translate([-70, 70]) bearingHole();
		translate([-70,-70]) scale([1,-1]) bearingHole();
		translate([ 85, 65]) rotate(90) woodConnector3();
		translate([ 85,-65]) rotate(90) woodConnector3();
	}
}
module caseFront(logo=true)
{
	difference() {
		caseFrontBack();
		//The titan text should actually be engraved, but is shown as removed in OpenSCAD. It's easier to change this to engrave in post-processing after you exported to DXF.
		roundedSquare([100,145],r=4);
		if (logo) translate([ 70,  0]) rotate(90) TITAN();
	}
}
module caseBack()
{
	difference() {
		caseFrontBack();
		translate([-19.5,14]) mirrored([0,50]) rotate(90) woodConnector3();
		/*
		//This is a happy face, you could cut this out of the back.
		translate([-25, 30]) roundedSquare([50,20],r=4);
		translate([-25,-30]) roundedSquare([50,20],r=4);
		difference()
		{
			circle(r=50);
			translate([-20,0]) circle(r=50);
		}
		*/
	}
}
module caseSide() {
	difference() {
		union() {
			intersection() {
				square([300,180-caseThickness*2+laserOffset*2],center=true);
				casePanel();
			}
			translate([ 50, (180/2-caseThickness/2)]) woodConnector1();
			translate([-65, (180/2-caseThickness/2)]) woodConnector1();
			translate([ 50,-(180/2-caseThickness/2)]) woodConnector1();
			translate([-65,-(180/2-caseThickness/2)]) woodConnector1();
		}
		translate([-50, 70]) bearingHole();
		translate([-50,-70]) scale([1,-1]) bearingHole();
		translate([ 50, (180/2-caseThickness/2)]) woodConnector2();
		translate([-65, (180/2-caseThickness/2)]) woodConnector2();
		translate([ 50,-(180/2-caseThickness/2)]) woodConnector2();
		translate([-65,-(180/2-caseThickness/2)]) woodConnector2();
		translate([-3,5]) roundedSquare([115,100],r=4);

		translate([ 85, 55]) rotate(90) woodConnector3();
		translate([ 85,-55]) rotate(90) woodConnector3();

		translate([-19.5,-66.25]) rotate(90) woodConnector3(10);
	}
}

module caseSideRight() {
	difference() {
		union() {
			caseSide();
			translate([50,-40]) roundedSquare([50,50],8);
		}
		translate([45.5,-59.5]) roundedSquare([17,20],4);
		translate([45.5,-59.5]) roundedSquare([17,20],4);
		#translate([10,-69]) mirrored([26/2,26/2]) circle(r=3/2);

		translate([28.8,-38.3]) {
			translate([5,14]) circle(r=3.5/2);
			translate([5,-14]) circle(r=3.5/2);
			translate([35,15]) circle(r=3.5/2);
			translate([37,-20]) hull() {
				circle(r=3.5/2);
				translate([0,-15]) circle(r=3.5/2);
			}
			translate([12,0]) circle(r=16/2-laserOffset);

			hull() {
				translate([25, 3]) circle(r=3);
				translate([25,-2]) circle(r=3);
				translate([55, 8]) circle(r=3);
				translate([55,-7]) circle(r=3);
			}
		}
	}
}

module caseBottom() {
	difference() {
		union() {
			square([180-caseThickness*2+laserOffset*2,180-caseThickness*2+laserOffset*2],center=true);
			mirrored([ 65, (180/2-caseThickness/2)]) woodConnector1();
			rotate(90) mirrored([ 55, (180/2-caseThickness/2)]) woodConnector1();
		}
		mirrored([ 65, (180/2-caseThickness/2)]) woodConnector2();
		rotate(90) mirrored([ 55, (180/2-caseThickness/2)]) woodConnector2();
		translate([-90,-38]) roundedSquare([10,20]);
		translate([headPosMin+hotendDistance+(headPosMax-headPosMin)/2, headPosMin+hotendDistance+(headPosMax-headPosMin)/2])
		{
			//Holes to access the screws for Z bed leveling
			mirrored([45,45]) circle(r=5);
			//Holes for the Z guides
			translate([0,-43]) mirrored([59.5,0]) {
				circle(r=8/2+laserOffset);
				translate([0,-12]) circle(r=3/2-laserOffset);
				translate([0, 12]) circle(r=3/2-laserOffset);
			}
		}

		//X,Y motor mount screw holes
		translate([24.5,-69]) mirrored([10,10]) circle(r=3/2-laserOffset);
		translate([-69,24.5]) mirrored([10,10]) circle(r=3/2-laserOffset);
		//Z motor mount screw holes
		translate([-42,-69]) mirrored([13,13]) circle(r=3/2-laserOffset);
		translate([-42,-69]) circle(r=12);
		translate([-17,-69]) circle(r=7);
	}
}

module bearingPlate() {
	rotate(45) difference() {
		hull() {
			circle(r=22/2);
			translate([-14,0]) circle(r=10/2);
			translate([ 14,0]) circle(r=10/2);
		}
		translate([-14,0]) circle(r=3/2);
		translate([ 14,0]) circle(r=3/2);
	}
}

module bearingHolderPlate() {
	difference() {
		rotate(45) hull() {
			circle(r=26/2);
			translate([-14,0]) circle(r=10/2);
			translate([ 14,0]) circle(r=10/2);
		}
		bearingHole();
	}
}

module case() {
	translate([0, (90-caseThickness/2),-50]) rotate([0,90,90]) wood(h=caseThickness) caseFront();
	translate([0, (90-caseThickness/2),-50]) rotate([0,90,90]) wood(h=caseThickness*0.5, type=1) caseFront(false);
	%translate([0,-(90-caseThickness/2),-50]) rotate([0,90,90]) wood(h=caseThickness) caseBack();
	translate([ (90-caseThickness/2),0,-50]) rotate([0,90,0]) wood(h=caseThickness) caseSide();
	%translate([-(90-caseThickness/2),0,-50]) rotate([0,90,0]) wood(h=caseThickness) caseSideRight();
	translate([0,0,-50-85]) wood(h=caseThickness) caseBottom();
	
	translate([ (90+caseThickness/2), 70,0]) rotate([0,90,0]) wood(h=caseThickness, type=1) bearingPlate();
	translate([ (90+caseThickness/2),-70,0]) rotate([0,-90,0]) wood(h=caseThickness, type=1) bearingPlate();
	translate([-(90+caseThickness/2), 70,0]) rotate([0,90,0]) wood(h=caseThickness, type=1) bearingPlate();
	translate([-(90+caseThickness/2),-70,0]) rotate([0,-90,0]) wood(h=caseThickness, type=1) bearingPlate();
	
	translate([ 70, (90+caseThickness/2),20]) rotate([0,-90,90]) wood(h=caseThickness, type=1) bearingPlate();
	translate([-70, (90+caseThickness/2),20]) rotate([0,90,90]) wood(h=caseThickness, type=1) bearingPlate();
	translate([ 70,-(90+caseThickness/2),20]) rotate([0,-90,90]) wood(h=caseThickness, type=1) bearingPlate();
	translate([-70,-(90+caseThickness/2),20]) rotate([0,90,90]) wood(h=caseThickness, type=1) bearingPlate();

	translate([ (90-caseThickness*1.5), 70,0]) rotate([0,90,0]) wood(h=caseThickness, type=1) bearingHolderPlate();
	translate([ (90-caseThickness*1.5),-70,0]) rotate([0,-90,0]) wood(h=caseThickness, type=1) bearingHolderPlate();
	translate([-(90-caseThickness*1.5), 70,0]) rotate([0,90,0]) wood(h=caseThickness, type=1) bearingHolderPlate();
	translate([-(90-caseThickness*1.5),-70,0]) rotate([0,-90,0]) wood(h=caseThickness, type=1) bearingHolderPlate();

	translate([ 70, (90-caseThickness*1.5),20]) rotate([0,-90,90]) wood(h=caseThickness, type=1) bearingHolderPlate();
	translate([-70, (90-caseThickness*1.5),20]) rotate([0,90,90]) wood(h=caseThickness, type=1) bearingHolderPlate();
	translate([ 70,-(90-caseThickness*1.5),20]) rotate([0,-90,90]) wood(h=caseThickness, type=1) bearingHolderPlate();
	translate([-70,-(90-caseThickness*1.5),20]) rotate([0,90,90]) wood(h=caseThickness, type=1) bearingHolderPlate();
}
