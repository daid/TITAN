#!/usr/bin/python

import numpy
import os

from optparse import OptionParser
import stl

def main():
	parser = OptionParser(usage="usage: %prog [options] <filename>.stl")
	(options, args) = parser.parse_args()

	for filename in args:
		resultFile = filename[: filename.rfind('.')] + ".pov"
		m = stl.stlModel().load(filename)

		minZ = m.getMinimumZ()
		minV = m.getMinimum()
		maxV = m.getMaximum()
		m.vertexes -= numpy.array([minV[0] + (maxV[0] - minV[0]) / 2, minV[1] + (maxV[1] - minV[1]) / 2, minZ])
		minZ = m.getMinimumZ()
		
		size = numpy.max(m.getMaximum() - m.getMinimum())
		
		lightPosition = numpy.array([size * -3, size * -3, size * 3])
		lightPosition2 = numpy.array([size * -3, size * 3, size * 3])
#		size *= 10
		viewPoint = numpy.array([size * -1.6,size * -1.9,size*1.3])
		viewCenter = (m.getMaximum() - m.getMinimum()) / 2
		viewCenter[2] *= 0.6
		
		f = open(resultFile, "w")
		f.write("#include \"colors.inc\"\n")
		f.write("camera { location  %s look_at %s angle 48 }\n" % (v2str(viewPoint), v2str(viewCenter)))
		f.write("mesh {\n")
		for idx in xrange(0, m.vertexCount, 3):
			f.write("triangle { %s, %s, %s }\n" % (v2str(m.vertexes[idx]), v2str(m.vertexes[idx+1]), v2str(m.vertexes[idx+2])))
		f.write("""
				texture { pigment { color rgb<1,1,1> } finish { phong 0.2 ambient 0.3 } } 
			}
		""")
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
		os.system("povray +A +H480 +W640 +P %s" % (resultFile))
		#Render without displaying it:
		#os.system("povray +A +H480 +W640 -D %s" % (resultFile))

def v2str(v):
	return "<%f, %f, %f>" % (v[0], v[2], v[1])

if __name__ == '__main__':
	main()

