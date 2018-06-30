#!/bin/bash
# File:    html_link.sh
# Version: Bash 3.2.57(1)
# Author:  Nicholas Russo (http://njrusmc.net)
# Purpose: First-stage CI check to ensure markdown READMEs and device
#          configurations are free from defects, or common styling errors
#          (including attribution). It prints out when linting starts
#          and ends, plus the name of each file discovered for linting.
#          Only files ending in '.md' are candidates for markdown linting,
#          and only files ending in '.txt' are candidates for config checking.
#          One integer CLI argument is supplied which identifies the expected
#          number of configuration files, to ensure none were forgotten.
#
rc=0 # Return code used to sum the rc from individual lint tests.
nf=0 # Number of files seen. Normal 'array length' isn't working.
#
echo "Markdown linting started"
for f in $(find . -name "*.md"); do
  # Print the filename, then run 'markdownlint'
  echo "checking $f"
  markdownlint $f
  # Sum the rc from markdownlint with the sum
  rc=$((rc + $?))
done
echo "Markdown linting complete"
#
#
echo "Config checking started"
for f in $(find . -name "R*.txt"); do
  # Print the filename, then use 'grep' to check for key information.
  echo "checking $f"
  # Make sure the author's name and email are clearly shown.
  grep -q "By Nicholas Russo <nickrus@cisco.com>" $f
  rc=$((rc + $?))
  # Make sure the router's hostname matches the file name.
  # Note that since the lab is built on a Windows machine, must match
  # \r\n Windows newline (Ctrl+V, Ctrl+M) at the end of the hostname.
  filename=$(basename -- "$f")
  filename="${filename%.*}"
  grep -Uq "^hostname $filename" $f
  rc=$((rc + $?))
  # Increment counter which counts the number of text files.
  ((nf++))
done
# After counting the text files, ensure it matches the CLI argument.
echo "Comparing $nf files seen versus $1 files expected"
test $nf -eq $1
rc=$((rc + $?))
echo "Config checking complete"
echo "All validation complete, rc=$rc"
# Exit using the total rc computed. 0 means success, any else is failure
exit $rc
