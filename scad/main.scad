$fs=0.4; $fa=5;
explode = 0.0;
headPosMin = -45; headPosMax = 35; zMoveMax = 70;
headPosX = headPosMin + (headPosMax - headPosMin) * 0.3;
headPosY = headPosMin + (headPosMax - headPosMin) * 0.3;
zStagePos = zMoveMax * 1.05;
laserOffset = 0.1;
enableWoodScrewconnectors = true;
hotendDistance = 13;
caseThickness = 3;
bushingDiameter = 15;

//Display different parts (for rendering)
displayWood = 255;
displayPrinted = 255;
displayMechanics = 255;


rotate([0,0,180]) assembly();
//wood3mm();

module assembly() {
	xyStage();

	translate([40,-69,-110]) rotate([0,90,0]) rotate([0,0,-90]) {
		motorMount();//X motor
		translate([0,0,15]) pulley5mm();
	}
	translate([-69,40,-110]) rotate([-90,0,0]) {
		motorMount();//Y motor
		translate([0,0,15]) pulley5mm();
	}
	//translate([70,-65,-100]) rotate([0,90,0]) NEMA17(35);//Extruder motor

	translate([headPosMin+hotendDistance+(headPosMax-headPosMin)/2,
		headPosMin+hotendDistance+(headPosMax-headPosMin)/2,
		-50-85+caseThickness/2])
			zStage();

//	%translate([headPosMin+hotendDistance, headPosMin+hotendDistance,-52-zMoveMax])
//		cube([headPosMax-headPosMin,headPosMax-headPosMin,zMoveMax]);
//	translate([0,0,-50]) limits();
	translate([0,0,-50]) limits(190,190);

	case();
//%	translate([0,0,180]) case();
}

module wood3mm() {
	caseFront();
	translate([200,   0]) caseBack();
	translate([  0, 200]) caseSide();
	translate([200, 200]) caseSide();
	translate([  0,-200]) caseBottom();
	translate([  0,2*200]) rotate(-90) zBasePlate();
	translate([200,2*200]) zGuideHolder()
	translate([200,-180]) zSidePlate();
	translate([200,-220]) zSidePlate();
	translate([200,-260]) zBackPlate();
	translate([20,0]) headBottomPlate();
	translate([-20,0]) bearingPlate();
	translate([-20,-30]) bearingHolderPlate();
	translate([-20, 40]) zGuideHolderPlate();
}

include<mcad/involute_gears.scad>
include<util.scad>
include<mechanical.scad>
include<extrusionHead.scad>
include<case.scad>
include<xystage.scad>
include<zstage.scad>
include<motormount.scad>
