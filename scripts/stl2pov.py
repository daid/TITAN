#!/usr/bin/python

import numpy
import os
import sys

from optparse import OptionParser
import stl

def main():
	modelList = []
	col = [1,1,1]
	for arg in sys.argv[1:]:
		if arg[:2] == '-c':
			col = map(float, arg[2:].split(','))
		else:
			m = stl.stlModel().load(arg)
			m.color = col
			modelList.append(m)

	minV = numpy.array([100000,100000,100000])
	maxV = numpy.array([-100000,-100000,-100000])
	for m in modelList:
		m.getMinimumZ()
		minV = numpy.array(map(min, m.getMinimum(), minV))
		maxV = numpy.array(map(max, m.getMaximum(), maxV))
	for m in modelList:
		m.vertexes -= numpy.array([minV[0] + (maxV[0] - minV[0]) / 2, minV[1] + (maxV[1] - minV[1]) / 2, minV[2]])
		m.getMinimumZ()
	
	size = numpy.max(maxV - minV)

	lightPosition = numpy.array([size * -4, size * -3, size * 2])
	lightPosition2 = numpy.array([size * -3, size * 4, size * 3])

	viewPoint = numpy.array([size * -1.6,size * -1.9,size*1.3])
	viewCenter = (m.getMaximum() - m.getMinimum()) / 2
	viewCenter[2] *= 0.6
	
	f = open("export.pov", "w")
	f.write("#include \"colors.inc\"\n")
	f.write("camera { location  %s look_at %s angle 48 }\n" % (v2str(viewPoint), v2str(viewCenter)))
	
	for m in modelList:
		f.write("mesh {\n")
		for idx in xrange(0, m.vertexCount, 3):
			f.write("triangle { %s, %s, %s }\n" % (v2str(m.vertexes[idx]), v2str(m.vertexes[idx+1]), v2str(m.vertexes[idx+2])))
		f.write("texture { pigment { color rgb%s } finish { phong 0.2 ambient 0.3 } } } " % (v2str(m.color)))

	f.write("#declare redBulb = sphere { <0,0,0>, 10 texture {pigment{color Red} finish {ambient .8 diffuse .6}} }");
	#f.write("plane { <0, 1, 0>, 0 pigment { color Blue } finish { reflection {0.3 falloff 10 fresnel} ambient 0.3 diffuse 0.3 } }");
	#f.write("plane { <0, 1, 0>, 0 pigment { color Blue } finish { reflection {0.3 falloff 2} ambient 0.3 diffuse 0.3 } }");
	f.write("""
#declare BlurAmount = .2; // Amount of blurring 
#declare BlurSamples = 10; // How many rays to shoot 
plane { <0, 1, 0>, 0 texture 
  { average texture_map 
    { #declare Ind = 0; 
      #declare S = seed(0); 
      #while(Ind < BlurSamples) 
        [1 // The pigment of the object: 
           pigment { color Blue } 
           // The surface finish: 
           finish { reflection {0.3 falloff 2} ambient 0.3 diffuse 0.3 } 
           // This is the actual trick:
           normal 
           { bumps BlurAmount 
             translate <rand(S),rand(S),rand(S)>*100
             scale 1000 
           } 
        ] 
        #declare Ind = Ind+1; 
      #end 
    } 
  }
}
	""");
	f.write("light_source { %s color rgb <1.0,1.0,1.0> adaptive 1 jitter looks_like { redBulb } }" % (v2str(lightPosition)));
	f.write("light_source { %s color rgb <0.5,0.5,0.5> adaptive 1 jitter looks_like { redBulb } }" % (v2str(lightPosition2)));
	f.close()
		
	#Render and display the image:
	os.system("povray +A +H480 +W640 +P export.pov")
	#Render without displaying it:
	#os.system("povray +A +H480 +W640 -D %s" % (resultFile))

def v2str(v):
	return "<%f, %f, %f>" % (v[0], v[2], v[1])

if __name__ == '__main__':
	main()

