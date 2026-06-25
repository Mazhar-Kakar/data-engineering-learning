# ====================================================================================
# Day 02 – PYTHON : PYTHON INSTALLATION
# ====================================================================================

# ------------------------------------------------------------------------------------
# STEPS TO DOWNLOAD AND INSTALL PYTHON IN LINUX
# ------------------------------------------------------------------------------------
"""
METHOD 1 (USING PACKAGE MANAGER):
Most Linux systems already have Python installed.

Check Python version:
  - python3 --version

If Python is not installed, install it using package manager:
For Ubuntu:
    sudo apt update
    sudo apt install python3

Verify installation:
  - python3 --version

METHOD 2 (DOWNLOAD FROM PYTHON WEBSITE):
python.org --> Download the latest Python source package --> Extract the downloaded file: [tar -xvf Python-3.13.3.tgz] --> Navigate to the folder: [cd Python-3.13.3] -->
Build and install Python:
    ./configure
    make
    sudo make install

Check installation:
    python3 --version
"""

# ------------------------------------------------------------------------------------
# WHAT DOES PYTHON INSTALLATION CONTAIN
# ------------------------------------------------------------------------------------
"""
When we download and install Python, several components are installed in the system.

1. PYTHON INTERPRETER
   - The interpreter executes Python code.
   - It reads the program line by line and converts it into bytecode.

   Example command:
       python3 program.py


2. PYTHON STANDARD LIBRARY
   - A large collection of built-in modules and functions.
   - These modules help perform many tasks without writing everything from scratch.

   Examples of libraries:
       math       -> mathematical operations
       os         -> interact with operating system
       sys        -> system-level operations
       datetime   -> work with dates and time
       random     -> generate random numbers


3. PIP (PACKAGE INSTALLER FOR PYTHON)
   - pip is used to install external Python packages.

   Example:
       pip install pandas
       pip install numpy

   These packages are widely used in data engineering and data science.


4. IDLE (PYTHON EDITOR)
   - A simple editor that comes with Python.
   - It allows writing and running Python code.


5. PYTHON VIRTUAL MACHINE (PVM)
   - Executes the Python bytecode.
   - Works between the interpreter and the CPU.


6. DOCUMENTATION
   - Python also installs help files and documentation.
   - These explain how Python functions and libraries work.
"""

# ------------------------------------------------------------------------------------
# DOWNLOAD AND INSTALL INTEGRATED DEVELOPMENT ENVIRONMENT (IDE) FOR WRITING PYTHON CODE
# POPULAR IDEs: PYCHARM, JUPYTER NOTEBOOK (INTERACTIVE CELL), VS CODE
# ------------------------------------------------------------------------------------
"""
An IDE (Integrated Development Environment) is software that helps developers
write, run, and debug programs efficiently.

It usually provides:
    - Code editor
    - Debugging tools
    - Syntax highlighting
    - Extension / plugin support
    - Integrated terminal

NOTE:
VS Code is technically a code editor, not a full IDE. However, with extensions
it can be configured to work like a powerful IDE.

Popular IDEs / Editors for Python:
PyCharm
   - A full-featured Python IDE
   - Provides powerful debugging and development tools

Jupyter Notebook
   - Interactive environment used widely in Data Science
   - Code runs in cells and output appears immediately

Visual Studio Code (VS Code)
   - Lightweight and very popular code editor
   - Supports many programming languages through extensions
   - Widely used for Python, Data Engineering, and DevOps

VS Code is one of the most popular editors for Python development.

------------------------------------------------------------------
DOWNLOAD & INSTALL VS CODE IN LINUX (UBUNTU)
------------------------------------------------------------------
METHOD 1 (FROM OFFICIAL WEBSITE):
visualstudio.com --> Download the .deb package (for Ubuntu / Debian systems) --> navigate to Downloads folder: [cd ~/Downloads] --> 
Install VS Code: [sudo dpkg -i code*.deb] --> If dependency error occurs, run: [sudo apt install -f] --> Open VS Code from terminal: [code]

------------------------------------------------------------------
IMPORTANT STEP AFTER INSTALLATION
------------------------------------------------------------------
Install Python Extension in VS Code:

1. Open VS Code
2. Go to Extensions (Ctrl + Shift + X)
3. Search for "Python"
4. Install extension by Microsoft

This extension enables:
    - Running Python code
    - Syntax highlighting
    - Debugging support
NOTE:
Installation in Windows is much easier.
You only need to download the installer from the official website
and follow the setup wizard.
"""