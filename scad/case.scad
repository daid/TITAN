module bearingHole() {
	circle(r=19/2-laserOffset);
	translate([-14,0]) circle(r=3/2);
	translate([ 14,0]) circle(r=3/2);
}

module caseFrontBack() {
	difference() {
		union() {
			roundedSquare([180+laserOffset*2,180+4*2+laserOffset*2],r=4);
			translate([ 85, 0]) mirrored([0, 85]) roundedSquare([20+laserOffset*2,18+laserOffset*2],r=5);
		}
		translate([ 50, (180/2-caseThickness/2)]) woodConnector3();
		translate([-65, (180/2-caseThickness/2)]) woodConnector3();
		translate([ 50,-(180/2-caseThickness/2)]) woodConnector3();
		translate([-65,-(180/2-caseThickness/2)]) woodConnector3();
		translate([-70, 70]) bearingHole();
		translate([-70,-70]) bearingHole();
		translate([ 85, 65]) rotate(90) woodConnector3();
		translate([ 85,-65]) rotate(90) woodConnector3();
	}
}
module caseFront()
{
	difference() {
		caseFrontBack();
		//The titan text should actually be engraved, but is shown as removed in OpenSCAD. It's easier to change this to engrave in post-processing after you exported to DXF.
		roundedSquare([100,145],r=4);
		translate([ 70,  0]) rotate(90) TITAN();
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
			square([180+laserOffset*2,180-caseThickness*2+laserOffset*2],center=true);
			intersection() {
				square([300,180-caseThickness*2+laserOffset*2],center=true);
				translate([ 85, 0]) mirrored([0, 85]) roundedSquare([20+laserOffset*2,18+laserOffset*2],r=5);
			}
			translate([ 50, (180/2-caseThickness/2)]) woodConnector1();
			translate([-65, (180/2-caseThickness/2)]) woodConnector1();
			translate([ 50,-(180/2-caseThickness/2)]) woodConnector1();
			translate([-65,-(180/2-caseThickness/2)]) woodConnector1();
		}
		translate([-50, 0]) mirrored([0, 70]) bearingHole();
		translate([ 50, (180/2-caseThickness/2)]) woodConnector2();
		translate([-65, (180/2-caseThickness/2)]) woodConnector2();
		translate([ 50,-(180/2-caseThickness/2)]) woodConnector2();
		translate([-65,-(180/2-caseThickness/2)]) woodConnector2();
		translate([-3,0]) roundedSquare([115,90],r=4);

		translate([ 85, 55]) rotate(90) woodConnector3();
		translate([ 85,-55]) rotate(90) woodConnector3();

		translate([-19.5,-66.25]) rotate(90) woodConnector3(10);
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
		translate([headPosMin+hotendDistance+(headPosMax-headPosMin)/2, headPosMin+hotendDistance+(headPosMax-headPosMin)/2])
		{
			//Holes to access the screws for Z bed leveling
			mirrored([45,45]) circle(r=5);
			//Holes for the Z guides
			translate([0,-43]) mirrored([59.5,0]) {
				circle(r=8/2+laserOffset);
				translate([0,-14]) circle(r=3/2+laserOffset);
				translate([0, 14]) circle(r=3/2+laserOffset);
			}
		}

		//X,Y motor mount screw holes
		translate([24.5,-69]) mirrored([10,10]) circle(r=3/2+laserOffset);
		translate([-69,24.5]) mirrored([10,10]) circle(r=3/2+laserOffset);
		//Z motor mount screw holes
		translate([-42,-69]) mirrored([13,13]) circle(r=3/2+laserOffset);
		translate([-42,-69]) circle(r=12);
		translate([-17,-69]) circle(r=7);
	}
}

module bearingPlate() {
	difference() {
		hull() {
			circle(r=22/2);
			translate([-14,0]) circle(r=10/2);
			translate([ 14,0]) circle(r=10/2);
		}
		translate([-14,0]) circle(r=3/2);
		translate([ 14,0]) circle(r=3/2);
	}
}

module case() {
	translate([0, (90-caseThickness/2),-50]) rotate([0,90,90]) wood(h=caseThickness) caseFront();
	translate([0,-(90-caseThickness/2),-50]) rotate([0,90,90]) wood(h=caseThickness) caseBack();
	translate([ (90-caseThickness/2),0,-50]) rotate([0,90,0]) wood(h=caseThickness) caseSide();
	translate([-(90-caseThickness/2),0,-50]) rotate([0,90,0]) wood(h=caseThickness) caseSide();
	translate([0,0,-50-85]) wood(h=caseThickness) caseBottom();
	
	translate([ (90+caseThickness/2), 70,0]) rotate([0,90,0]) wood(h=caseThickness) bearingPlate();
	translate([ (90+caseThickness/2),-70,0]) rotate([0,90,0]) wood(h=caseThickness) bearingPlate();
	translate([-(90+caseThickness/2), 70,0]) rotate([0,90,0]) wood(h=caseThickness) bearingPlate();
	translate([-(90+caseThickness/2),-70,0]) rotate([0,90,0]) wood(h=caseThickness) bearingPlate();
	
	translate([ 70, (90+caseThickness/2),20]) rotate([0,90,90]) wood(h=caseThickness) bearingPlate();
	translate([-70, (90+caseThickness/2),20]) rotate([0,90,90]) wood(h=caseThickness) bearingPlate();
	translate([ 70,-(90+caseThickness/2),20]) rotate([0,90,90]) wood(h=caseThickness) bearingPlate();
	translate([-70,-(90+caseThickness/2),20]) rotate([0,90,90]) wood(h=caseThickness) bearingPlate();
}
