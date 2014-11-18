#!/usr/bin/env python
import os
import socket
import string
import random
import glob
import re
#import shutil #shutil.move # in case Ineed
import time

def random_str(size=10, chars=string.ascii_uppercase + string.digits):
    return "".join(random.choice(chars) for x in range(size))

outDirectory= "files"
resolveFile="resolve"
allFile=outDirectory+"/all.csv"

hostname = socket.gethostname()
rndm=random_str()
tm=time.strftime("%Y%m%d%H%M%S")
print "Info about this load:\n\tHostname:"+hostname+"\n\tTime now(yyyymmddHHMMSS):"+tm+"\n\tRandom associate to this test:"+rndm

if not os.path.exists(outDirectory):
    os.makedirs(outDirectory)

fResolve = None
if not os.path.isfile(resolveFile):
    fResolve = open(resolveFile,"w")
    fResolve.write("Random,Host,Time")
else:
    fResolve = open(resolveFile,"a+")
fResolve.write("\n"+rndm+","+hostname+","+tm)

fAll = None
if not os.path.isfile(allFile):
    fAll = open(allFile,"w")
    fAll.write("appconnect_time,connect_time,namelookup_time,num_connects,pretransfer_time,redirect_count,redirect_time,request_size,size_download,size_upload,speed_download,speed_upload,starttransfer_time,total_time\n")

else:
    fAll = open(allFile,"a+")

for csv in glob.glob('*Thread-1.csv'):
    folderForTest = re.search(r'(.*)-Thread.*',csv).group(1)
    dire = outDirectory+"/"+folderForTest
    if not os.path.exists(dire):
        os.makedirs(dire)

    for fl in glob.glob(folderForTest+'*.csv'):
        thrd=re.search(r'.*-(Thread.*).csv',fl).group(1)
        with open(fl,'r') as f:
            with open(dire+"/"+rndm+"_"+thrd+".csv",'w') as f1:
                # skip header lines and rewrite the file in the organized structure of folders
                f.next()
                f.next()
                f.next()
                f.next()
                first = True
                for line in f:
                    f1.write(line)
                    if not first:
                        fAll.write(line)
                    first = False
        os.remove(fl)
