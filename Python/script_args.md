```python
import optparse

# Create parser object
parser = optparse.OptionParser()

# Set arguments
parser.add_option("-i","--interface",dest="interface",help="Interface to change its MAC address")
parser.add_option("-,","--mac",dest="new_mac",help="New MAC address")
# Where "interface" and "new_mac" is a name of the vairable to which you want to store this arguments value.

# Listen for arguments
(options, arguments) = parser.parse_args()

# Extract arg values
interface = options.interface
new_mac = options.new_mac

```

