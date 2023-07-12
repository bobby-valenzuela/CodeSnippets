# Saving values from .env file

# METHOD #1
from dotenv import dotenv_values

config = dotenv_values('.env');
openai.api_key = config["OPENAI_API_KEY"]


# METHOD #2
from dotenv import load_dotenv

load_dotenv() #  Looks for ./.env file by default and saves values an environment variable which you can access with os.getenv("MY_VAR")  
openai.api_key = os.getenv("OPENAI_API_KEY")
