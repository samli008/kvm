import xml.etree.ElementTree as ET
import os

xml=input("pls input vm name: ")
xml='/etc/libvirt/qemu/'+xml+'.xml'

tree=ET.parse(xml)
root=tree.getroot()

for tag in root.iter('cpu'):
  tag.attrib['mode']='host-passthrough'
  print('cpu mode ',tag.attrib['mode'])

tree.write(xml)
os.system("virsh define %s" % (xml))
