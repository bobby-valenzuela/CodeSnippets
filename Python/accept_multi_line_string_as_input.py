print("Enter/Paste your content. Press Enter then Ctrl-D or Ctrl-Z ( windows ) to save it.")
contents = []
while True:
    try:
        line = input()
    except EOFError:
        break
    contents.append(line)

in_code = "".join(contents)
