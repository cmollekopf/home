#!/bin/python2.7

import glob

for file in glob.glob('../*/*.h'):
    if '_p.h' in file or 'test' in file:
        continue;
    # print file
    # print file.split('/')[-1]
    for line in open(file, 'r'):
         if "class" in line and "EXPORT" in line:
                # print line
                fragments = line.split(' ')
                classname = ""
                try:
                    indexAfterName = fragments.index(':')
                    classname = fragments[indexAfterName - 1]
                except:
                    classname = fragments[-1]
                classname = classname.strip()
                print classname
                outfile = open('KDE/' + classname, 'w')
                outfile.write("#include \"../%s\"" % (file))
                outfile.close()
