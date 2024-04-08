#!/usr/bin/python

# Standard Lib
import sys
import os
import unittest

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Include in path
#
# Recursively include in path:
# https://www.tutorialspoint.com/python/os_walk.htm
for root, dirs, files in os.walk("./src/", topdown=False):
    for name in dirs:
        sys.path.append(root + "/" + name)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Developed
import yaml_reader


##===============================================================================
#
class TestYAMLReaderModule(unittest.TestCase):
    ##---------------------------------------------------------------------------
    #
    def test_open_yaml(self):
        fh = yaml_reader.open_yaml("test/extern_files/test.yaml", "r")
        self.assertEqual(fh['name'], "test")
        self.assertEqual(fh['type'], "float")
        return
