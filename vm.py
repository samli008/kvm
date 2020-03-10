import xml.etree.ElementTree as ET
import os

xml=input("pls input vm name: ")
mem=input("pls input mem size: ")
vcpu=input("pls input vcpu size: ")

xml='/etc/libvirt/qemu/'+xml+'.xml'
mem=int(mem)*1024*1024
mem=str(mem)

tree=ET.parse(xml)
root=tree.getroot()

for cpu in root.iter('vcpu'):
  cpu.attrib['current']=vcpu
  cpu.text=vcpu
  print('cpu count ',cpu.attrib['current'])

for mem1 in root.iter('currentMemory'):
  mem1.text=mem
  print('memory size ',mem1.text)

for mem2 in root.iter('memory'):
  mem2.text=mem

tree.write(xml)
os.system("virsh define %s" % (xml))
