#!/usr/bin/python3

import requests

img_url = ""
res = requests.get(img_url)
# res.content is the hex data of the image

with open("new_image.png","wb") as f:
  print(res.content)
  f.write(res.content)

