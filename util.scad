
module wood(c=1,h=6)
{
	color([0.7,0.5,0.3]) linear_extrude(height=h-0.1,convexity=c,center=true) for (i = [0 : $children-1]) child(i);
}

module mirrored(offset=[])
{
	if (len(offset) == 1)
	{
		if (offset[0] != 0)
		{
			translate([ offset[0], 0, 0]) for (i = [0 : $children-1]) child(i);
			translate([-offset[0], 0, 0]) for (i = [0 : $children-1]) child(i);
		}else{
			for (i = [0 : $children-1]) child(i);
		}
	}
	if (len(offset) == 2)
	{
		if (offset[0] != 0 && offset[1] != 0)
		{
			translate([ offset[0], offset[1], 0]) for (i = [0 : $children-1]) child(i);
			translate([-offset[0], offset[1], 0]) for (i = [0 : $children-1]) child(i);
			translate([ offset[0],-offset[1], 0]) for (i = [0 : $children-1]) child(i);
			translate([-offset[0],-offset[1], 0]) for (i = [0 : $children-1]) child(i);
		}else if (offset[0] != 0)
		{
			translate([ offset[0], 0, 0]) for (i = [0 : $children-1]) child(i);
			translate([-offset[0], 0, 0]) for (i = [0 : $children-1]) child(i);
		}else if (offset[1] != 0)
		{
			translate([0, offset[1], 0]) for (i = [0 : $children-1]) child(i);
			translate([0,-offset[1], 0]) for (i = [0 : $children-1]) child(i);
		}else{
			for (i = [0 : $children-1]) child(i);
		}
	}
}

module roundedSquare(pos=[10,10],r=2) {
	minkowski() {
		square([pos[0]-r*2,pos[1]-r*2],center=true);
		circle(r=r);
	}
}

//The wood connector has 3 parts. The first is unioned to the wood, the 2nd is differenced from the wood. And the last is differenced from the other wooden plate.
module woodConnector1(d=15) {
	s = d*2/3;
	translate([d,0]) square([s+laserOffset*2,caseThickness+laserOffset*2],center=true);
	translate([-d,0]) square([s+laserOffset*2,caseThickness+laserOffset*2],center=true);
}
module woodConnector2() {
	if (enableWoodScrewconnectors) {
		square([2.7,26],center=true);
		translate([0,-10.5]) square([5.5,2.2],center=true);
		translate([0, 10.5]) square([5.5,2.2],center=true);
	}
}
module woodConnector3(d=15) {
	s = d*2/3;
	translate([d,0]) square([s-laserOffset*2,caseThickness-laserOffset],center=true);
	translate([-d,0]) square([s-laserOffset*2,caseThickness-laserOffset],center=true);
	if (enableWoodScrewconnectors) circle(r=3/2-laserOffset);
}

module T5BeltTooth(c=0.1) {
	f = tan(20) * 1.2;
	polygon([[-c,-c],[-c,1+c],[f-c,2.2+c],[2.65-f+c,2.2+c],[2.65+c,1+c],[5+c,1+c],[5+c,-c]]);
}
module T5Belt(length=10,c=0.1)
{
	intersection() {
		union() {
			for(i=[0:length/5])
				translate([i*5,-1]) T5BeltTooth(c=c);
		}
		translate([-c,-2]) square([length+c*2,10]);
	}
}

module TITAN()
{
	translate([-2.5,0]) difference() {
		union() {
			polygon([[-25,16],[-15,16],[-15,14],[-18,14],[-18,0],[-22,0],[-22,14],[-25,14]]);
			polygon([[-13,16],[-13,0],[-9,0],[-9,16]]);
			polygon([[-7,16],[-7,14],[-4,14],[-4,0],[0,0],[0,14],[3,14],[3,16]]);
			polygon([[5,0],[5,16],[16,16],[16,0],[12,0],[12,8],[9,8],[9,0]]);
			polygon([[18,16],[18,0],[22,0],[22,14],[25,14],[25,0],[29,0],[29,16]]);
		}
		polygon([[9,10],[12,10],[12,14],[9,14]]);
	}
}
