import openai
from dotenv import dotenv_values
import json

config = dotenv_values('.env');
openai.api_key = config["OPENAI_API_KEY"]

prompt = f"""
You are a color palette generating assistant that responds to text prompts for color palettes
Your should generate color palettes that fit the theme, mood, or instructions in the prompt.
The palettes should be between 2 and 8 colors.
Q: Convert the following verbal description of a color palette into a list of colors: The Mediterranean Sea
A: ["#006699", "#66CCCC", "#F0E68C", "#008000", "#F08080"]
Q: Convert the following verbal description of a color palette into a list of colors: sage, nature, earth
A: ["#EDF1D6", "#9DC08B", "#609966", "#40513B"]
Desired Format: a JSON array of hexadecimal color codes
Q: Convert the following verbal description of a color palette into a list of colors: {msg} 
A:
"""

response = openai.Completion.create(
    prompt=prompt,
    model="text-davinci-003",
    max_tokens=200,
)
response = response["choices"][0]["text"]

# Our response will be a string representation of a python list (since thats the format we asked for). 
# Using json.loads (basically like JSON.parse in JS) evaluates out string and converts to a Python data type. In this case, an actual list we can use.
colors = json.loads(response)
