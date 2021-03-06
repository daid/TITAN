/*****************************************************/
/* Support modules for none-printed mechanical parts */
/*****************************************************/

/************/
/* Steppers */
/************/

module NEMA8() {
	stepper(size=20.2,length=30,shaftDiameter=4,shaftLength=15,faceplateDiameter=15,screwDistance=16,screwDiameter=2);
}
module NEMA11() {
	stepper(size=28.2,length=45,shaftDiameter=5,shaftLength=20,faceplateDiameter=22,screwDistance=23,screwDiameter=2.5);
}
module NEMA14(l=36) {
	stepper(size=35.2,length=l,shaftDiameter=5,shaftLength=21,faceplateDiameter=22,screwDistance=26,screwDiameter=3);
}
module NEMA17(l=48) {
	stepper(size=42.3,length=l,shaftDiameter=5,shaftLength=24,faceplateDiameter=22,screwDistance=31,screwDiameter=3);
}
module stepper(size=20,length=30,shaftDiameter=4,shaftLength=15,faceplateDiameter=15,screwDistance=16,screwDiameter=2) {
	//Standard model for NEMA steppers. (Note: Up from NEMA23 the design changes at the screw locations, so only use this up to NEMA17)
	if (bitIsSet(displayMechanics, 2)) color([0.8,0.8,0.8,0.8]) render() union() {
		difference() {
			translate([0,0,-length]) linear_extrude(height=length) minkowski() {
				square([size*0.8,size*0.8], center=true);
				circle(r=size*0.1);
			}
			translate([-screwDistance/2,-screwDistance/2,-3.5]) cylinder(r=screwDiameter/2,h=4);
			translate([ screwDistance/2,-screwDistance/2,-3.5]) cylinder(r=screwDiameter/2,h=4);
			translate([-screwDistance/2, screwDistance/2,-3.5]) cylinder(r=screwDiameter/2,h=4);
			translate([ screwDistance/2, screwDistance/2,-3.5]) cylinder(r=screwDiameter/2,h=4);
		}
		translate([0,0,-1]) cylinder(r=shaftDiameter/2,h=shaftLength+1);
		translate([0,0,-1]) cylinder(r=faceplateDiameter/2,h=2.5);
	}
}

/**********************/
/* Hotend (Ultimaker) */
/**********************/

//ptfeCoupling found in the V2 version of the Ultimaker hotend
module ptfeCoupling() {
	if (bitIsSet(displayMechanics, 6)) color([0.9,0.9,0.9,0.9]) translate([0,0,1.25]) difference() {
		union() {
			cylinder(r=6/2,h=5);
			translate([0,0,-1.25]) cylinder(r=11.5/2,h=1.25);
			translate([0,0,-10]) cylinder(r=10/2,h=10);
		}
		translate([0,0,-11]) cylinder(r=3.15/2,h=20);
		translate([0,0,-11]) cylinder(r=6.5/2,h=6+1);
	}
}

//Brass connecting tube found in the V1 version of the Ultimaker hotend
module brassTubeV1() {
	if (bitIsSet(displayMechanics, 4)) color([1,0.9,0,0.9]) difference() {
		translate([0,0,-11]) cylinder(r=4.8/2,h=30);//This length is guessed.
		translate([0,0,-12]) cylinder(r=3.2/2,h=31);
	}
	translate([0,0,-11]) %cylinder(r=6/2,h=30);//#M6 thread#
}

//Brass connecting tube found in the V2 version of the Ultimaker hotend
module brassTubeV2() {
	if (bitIsSet(displayMechanics, 4)) color([1,0.9,0,0.9]) difference() {
		union() {
			cylinder(r=10/2,h=1);
			translate([0,0,-11]) cylinder(r=4.8/2,h=11);
			translate([0,0,-11]) %cylinder(r=6/2,h=11);//#M6 thread#
			translate([0,0,1]) cylinder(r=4.8/2,h=8);
			translate([0,0,3.7]) %cylinder(r=6/2,h=3.6);//#M6 thread#
		}
		translate([0,0,-12]) cylinder(r=3.2/2,h=25);
	}
}

//The ultimaker peek insulator (see: http://wiki.ultimaker.com/PEEK_insulator)
module peekInsulator() {
	if (bitIsSet(displayMechanics, 5)) color([1,0.8,0.3,0.9]) render() difference() {
		union() {
			cylinder(r=16.5/2,h=4.2);
			intersection() {
				cylinder(r=14.0/2,h=13+4.2);
				translate([-12.5/2,-15,0]) cube([12.5,30,20]);
			}
		}
		translate([0,0,-1]) cylinder(r=12/2,h=2);
		cylinder(r=6.4/2,h=5);
		cylinder(r=6/2,h=20);	//#M6 thread#
	}
}

//Ultimaker heater block
module heaterBlock() {
	if (bitIsSet(displayMechanics, 1)) color([0.7,0.7,0.7,0.9]) difference() {
		translate([-5,-25.1/2,0]) cube([16,25.1,12.1]);
		translate([0,0,-1]) cylinder(r=6/2,h=14);	//#M6 thread#
		translate([7,0,8.3]) rotate([90,0,0]) cylinder(r=6/2,h=30,center=true);
		translate([5,0,2]) rotate([90,0,0]) cylinder(r=3/2,h=30,center=true);
		translate([8.5,25.1/2+1,3]) rotate([90,0,0]) cylinder(r=3/2,h=13+1); //#M3 thread#
	}
}

//Ultimaker nozzle, found in the V1 hotend
module nozzleV1() {
	if (bitIsSet(displayMechanics, 4)) color([1,0.9,0,0.9]) difference() {
		union() {
			cylinder(r=11.5/2,h=4,$fn=6);
			translate([0,0,-6]) cylinder(r=4.8/2,h=6);
			%translate([0,0,-6+1.1]) cylinder(r=6/2,h=4);//#M6 thread#
			translate([0,0,4]) intersection()
			{
				cylinder(r=11.5/2,h=8.7,$fn=6);
				cylinder(r1=11.5/2,r2=0.4,h=8.7);
			}
		}
		translate([0,0,-6-1]) cylinder(r=3.2/2,h=11.5+1);
		cylinder(r=0.4/2,h=20);
	}
}

//Ultimaker nozzle, found in the V2 hotend
module nozzleV2() {
	if (bitIsSet(displayMechanics, 4)) color([1,0.9,0,0.9]) difference() {
		union() {
			cylinder(r=11.5/2,h=4,$fn=6);
			translate([0,0,-6]) cylinder(r=4.8/2,h=6);
			%translate([0,0,-6+1.1]) cylinder(r=6/2,h=4);//#M6 thread#
			translate([0,0,4]) intersection()
			{
				cylinder(r=11.5/2,h=5,$fn=6);
				cylinder(r1=11.5/2,r2=0.4,h=5);
			}
		}
		translate([0,0,-6-1]) cylinder(r=3.2/2,h=11.5+1);
		cylinder(r=0.4/2,h=11.5);
	}
}

module hotEndV1() {
	rotate([180,0,0]) {
		translate([0,0,13+4.2]) brassTubeV1();
		peekInsulator();
		translate([0,0,13+4.2]) heaterBlock();
		translate([0,0,13+4.2+12.1]) nozzleV1();
		if (bitIsSet(displayMechanics, 7)) rotate([180,0,0]) color([0.7,0.7,0.7,0.2]) cylinder(r=6.5/2,h=100);//Bowden tube
	}
}
module hotEndV2() {
	rotate([180,0,0]) {
		ptfeCoupling();
		translate([0,0,0.25+13+4.2]) brassTubeV2();
		translate([0,0,0.25+13+4.2+3.7+12.1]) nozzleV2();
		translate([0,0,0.25+13+4.2+3.7]) heaterBlock();
		translate([0,0,0.25]) peekInsulator();
		if (bitIsSet(displayMechanics, 7)) rotate([180,0,0]) color([0.7,0.7,0.7,0.2]) cylinder(r=6.5/2,h=100);//Bowden tube
	}
}

/************/
/* Fan */
/************/
module fan40mm() {
	if (bitIsSet(displayMechanics, 6)) color([0.5,0.5,0.5,0.9]) linear_extrude(height=10) {
		difference() {
			roundedSquare([40,40], r=4);
			translate([ 32/2, 32/2]) circle(r=4/2);
			translate([ 32/2,-32/2]) circle(r=4/2);
			translate([-32/2, 32/2]) circle(r=4/2);
			translate([-32/2,-32/2]) circle(r=4/2);
			
			intersection() {
				circle(r=40/2);
				square([38,38],center=true);
			}
		}
	}
}

module bearingAny(r1, r2, h) {
	if (bitIsSet(displayMechanics, 1)) color([0.8,0.8,0.8,0.8]) render() difference()
	{
		cylinder(r=r1/2,h=h);
		translate([0,0,-1]) cylinder(r=r2/2,h=h+2);
	}
}

module bearing623() { bearingAny(10, 4, 4); }
module bearing106() { bearingAny(10, 6, 3); }
module bearing626() { bearingAny(19, 6, 6); }
module bearing608() { bearingAny(22, 8, 6); }
module bearing688() { bearingAny(16, 8, 5); }

module bearingLM8UU()
{
	if (bitIsSet(displayMechanics, 1)) color([0.8,0.8,0.8,0.8]) linear_extrude(height=25,center=true) difference() {
		circle(r=16/2);
		circle(r=8/2);
	}
}

module nutM6()
{
	if (bitIsSet(displayMechanics, 1)) color([0.8,0.8,0.8,0.8]) linear_extrude(height=6) difference()
	{
		circle(r=11.5/2, $fn=6);
		circle(r=5/2);
	}
}

module smoothRod(d=6,h=150,center=true)
{
	if (bitIsSet(displayMechanics, 0)) color([0.6,0.6,0.6,0.8]) cylinder(r=d/2,h=h,center=center);
}
module threadedRod(d=6,h=150,center=false)
{
	if (bitIsSet(displayMechanics, 0)) color([0.6,0.6,0.6,0.8]) cylinder(r=d/2,h=h,center=center);
}

/* Hobbed sleve which can be fitted on a 5mm motor axes for direct drive */
module hobbedSleve()
{
	if (bitIsSet(displayMechanics, 1)) color([0.6,0.6,0.6,0.8]) {
		cylinder(r=8/2,h=12.5);
		cylinder(r=9/2,h=7.5);
		translate([0,0,10]) rotate([90,0,0]) cylinder(r=3/2,h=8);
	}
}

/* Ultimaker knurledBolt (V2) */
module knurledBolt2() {
	if (bitIsSet(displayMechanics, 0)) translate([0,0,-7.5]) union() {
		color([0.6,0.6,0.6,0.8]) render() {
			cylinder(r=5.5/2,h=38);
			translate([0,0,38-3]) cylinder(r=8.0/2,h=3);
			cylinder(r=8.0/2,h=38-5.2);
			cylinder(r=15/2,h=6.5,$fn=6);
			translate([0,0,6.5]) cylinder(r=17/2,h=1.0);
			translate([0,0,7.5]) cylinder(r=15/2,h=6.5,$fn=6);
			translate([0,0,13.5]) cylinder(r=17/2,h=1.0);
		}
		color([1,0,0,0.3]) translate([0,0,38-10-7]) cylinder(r=9/2,h=7);
	}
}

/**************************************************************/
/* Limits, to show max size of the machine during development */
/**************************************************************/
module limits(s = 180, s2=180) {
	translate([-s/2,-s/2,-s/2]) 
	{
		%cube([s,1,1]);
		%cube([1,s,1]);
		%translate([0,s-1,0]) cube([s,1,1]);
		%translate([s-1,0,0]) cube([1,s,1]);

		%translate([0,0,s2-1]) cube([s,1,1]);
		%translate([0,0,s2-1]) cube([1,s,1]);
		%translate([0,s-1,s2-1]) cube([s,1,1]);
		%translate([s-1,0,s2-1]) cube([1,s,1]);

		%cube([1,1,s2]);
		%translate([s-1,0,0]) cube([1,1,s2]);
		%translate([0,s-1,0]) cube([1,1,s2]);
		%translate([s-1,s-1,0]) cube([1,1,s2]);
	}
	//% translate([s/2,-s/2,-s/2]) cube([230,230,320]);//Tantillus
	//% translate([s/2,-s/2,-s/2]) cube([340,355,390]);//Ultimaker
	//% translate([s/2,-s/2,-s/2]) cube([420,410,350]);//Prusa Mendel
	//% translate([s/2,-s/2,-s/2]) cube([11*25.4,11*25.4,11*25.4]);//Printrbot? (need to figure out the outside dimensions)
}
