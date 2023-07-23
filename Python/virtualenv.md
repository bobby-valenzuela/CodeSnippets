# Creating a virtual Environment

## Method 1: Setup your virtual environment
Make sure you have the virtual environment package installed:
```bash
sudo apt install python3.8-venv
```
```bash
sudo apt install python3-venv
```

<br />

Create environment 
```bash
python3 -m venv env
```
```bash
virtualenv env
```
_Where 'env' is the name of your environment_

<br />

Source environment
```bash
source env/bin/activate
```

<br />

## Method 2: Setup your virtual environment
_Make sure you have the virtual environment package installed_
```bash
sudo apt install python3-dev libffi-dev build-essential virtualenvwrapper -y
```


Configure/Activate Virtual Envinronment Wrapper (source it)
```bash
. /usr/share/virtualenvwrapper/virtualenvwrapper.sh
```

<br />

# Working with requirements.txt file

<br />

## Creating a requirements.txt file
Install pipreqs (used to create requirements.txt file)  
```bash
pip3 install pipreqs
```

<br />

Create requirements.txt file
```bash
pipreqs .
```

<br />

## Installing packages from a requirements.txt file

```bash
pip3 install -r requirements.txt
```

<br />

Creating a virtual end and installing from requirements.txt in one go:
```bash
virtualenv env && source env/bin/activate && pip3 install -r requirements.txt
```

