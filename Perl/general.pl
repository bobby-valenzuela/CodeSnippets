#!/usr/bin/perl

# --- REPLACING ----

# In-place replacement all instances of some word with another word in a given file
perl -pi -e 's/replacethis/withthis/g' myfile.txt
# ^ Note: On Windows, replace single quotes with double quotes

# Same as above, but saved a copy of the original file first with the ".bak" extension
perl -pi.bak -e 's/replacethis/withthis/g' myfile.txt

# In-place replacement all instances of some word with another word in a given file on lines where text contains RegEx pattern (e.g. "linetoreplace")
perl -pi -e 's/replacethis/withthis/g if /linetoreplace/' file

# In-place replacement all instances of some word with another word in a given file [Multiple Files]
perl -pi -e 's/replacethis/withthis/g' file2 file2 file3


