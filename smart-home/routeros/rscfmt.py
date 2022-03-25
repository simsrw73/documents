#!/usr/bin/env python

"""rscfmt.py: Format a ROS script file for easy reading"""

from typing import List, Set, Dict
import sys
import argparse
import glob
from tempfile import NamedTemporaryFile
import os
import shutil
from pprint import pp
from dataclasses import dataclass

section_names: List[str] = [
    "/system identitys",
    "/port",
    "/interface lte apn",
    "/interface ethernet",
    "/interface bridge",
    "/interface bridge port",
    "/interface bridge vlan",
    "/interface vlan",
    "/interface list",
    "/interface list member",
    "/interface wireless cap",
    "/interface wireless security-profiles",
    "/interface wireless",
    "/interface wireless access-list",
    "/ip dns",
    "/ip dhcp-client",
    "/ip address",
    "/ip pool",
    "/ip dhcp-server",
    "/ip dhcp-server network",
    "/ip dhcp-server lease",
    "/ip route",
    "/ip firewall address-list",
    "/ip firewall filter",
    "/ip firewall nat",
    "/ip neighbor discovery-settings",
    "/tool mac-server",
    "/tool mac-server mac-winbox",
    "/ip ssh",
    "/ip service",
    "/ip settings",
    "/ipv6 firewall address-list",
    "/ipv6 firewall filter",
    "/ipv6 settings",
    "/system clock",
    "/ip cloud",
    "/system ntp client",
    "/system ntp client servers",
    "/system ntp server",
    "/system routerboard settings",
    "/ip smb shares",
    "/ip smb users",
    "/system scheduler",
    "/system script"
]

@dataclass
class ROSScript:
    header: List[str]
    sections: Dict[str, List[str]]

def write_file(filename: str, script: ROSScript) -> None:
    f = NamedTemporaryFile(mode='w')
    f.write("\n".join(script.header))
    for section_name in section_names:
        if section_name in script.sections:
            f.write("\n\n")
            f.write(section_name)
            f.write("\n")
            f.write("\n".join(script.sections[section_name]))
    f.write("\n")
    f.close()

    os.remove(filename)
    shutil.copy(f.name, filename)

def parse_file(filename: str) -> ROSScript:
    script: ROSScript
    with open(filename) as f:
        section_name: str = ""
        current_section: List[str] = []
        # sections: Dict[str, List[str]] = {}
        # header: List[str] = []
        for line in f:
            line = line.rstrip()
            if not line:
                # Empty line
                continue
            elif line.startswith("#"):
                # Comment
                if not section_name:
                    # This is a comment-line
                    # and we have not encountered any sections yet,
                    # so this must be the File Header
                    script.header
                    script.header.append(line)
                continue
            elif line.startswith("/"):
                # Section name (command-space)

                if section_name:
                    # We don't know about or care about this section
                    if not section_name in section_names:
                        print(f"Unknown section: {section_name}\n\tfrom: {line}")
                        continue

                    # finish the previous section
                    if section_name in sections:
                        # if we've already seen this section, append to it
                        sections[section_name].extend(current_section)
                    else:
                        sections[section_name] = current_section
                    current_section = []
                section_name = line
            else:
                # Section content (command)
                current_section.append(line)

        # finish the last section
        sections[section_name] = current_section

    write_file(filename, header, sections)

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('files', nargs='+', default=sys.stdin, help='files to process')
    args = parser.parse_args()

    files: List[str] = []
    for globs in args.files:
        for g in glob.glob(globs):
            files.append(g)

    for filename in files:
        content: Dict[str, List] = parse_file(filename)



if __name__ == '__main__':
    main()

