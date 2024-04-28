# Modules
import yaml

from typing import TextIO


##==============================================================================
#
def open_yaml(fp: str, access: str) -> TextIO:
    """
    The open YAML function is meant to be a wrapper around the PyYAML package
    when parsing YAML files.

    # Input
    * fp: Path to YAML file
    * access: Character that specifies access rights to the file

    # Output
    * fh: File handle to the YAML file
    """
    try:
        return yaml.load(open(fp, access), Loader=yaml.Loader)
    except yaml.YAMLError as exc:
        print("ERROR - Unable to open YAML file: ", exc)


##==============================================================================
#
def close_yaml(fh: TextIO):
    """
    The close YAML function is meant to be a wrapper around the PyYAML package.

    # Input
    * fh: File handle to the YAML file

    # Output
    * NONE
    """
    return fh.close()
