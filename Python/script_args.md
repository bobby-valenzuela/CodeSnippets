```python
import optparse

# Create parser object
parser = optparse.OptionParser()

# Set arguments
parser.add_option("-i","--interface",dest="interface",help="Interface to change its MAC address")

# Listen for arguments
parser.parse_args()
```
^ Where "interface" is a name of the vairable to which you want to store this arguments value.
