#!/usr/bin/python
from bs4 import BeautifulSoup
from bs4 import NavigableString
import urllib2
import sys

#this is a python script that extracts all the fasta urls on array express page

url = sys.argv[1]

#soupify the html
content = urllib2.urlopen(url).read()
soup = BeautifulSoup(content)

#open text file to store urls in
f=open('urls.txt', 'a')

#find all hyperlinks
for div in soup.find_all('a'):

    try:
        candidate = div.contents[0]
    except:
        continue
        
    candidate = str(candidate)

    if candidate.startswith("SRR"):

       #make the url and write it to file
       url = "ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/" + candidate[0:6] + "/" + candidate + "/" + candidate + ".sra"
       f.write(url)
       f.write('\n')


f.close()
