# MSDS5163 Final Project
## Instructions to run the application

<sub>Author: **_Gilberto Diaz_**</sub>

This code attached to the email was built utilizing Jupyter environment. After exporting the code to a .py file, there are few steps to actually run the application successfully.

### Instructions for how to setup running environment.

The following instructions are for Mac users. Slight modifications to the commands for Windows users are needed. Please search the Internet to modify these commands if you are a Windows user.

1. Open the terminal and run the following commands:
    * `brew install python3`
      * With this installation `pip3` will get installed as well. Mac has `Python2` installed by default and `pip` is the command to install modules in `Python2`. `Python3` will use `pip3` to install modules on `Python3`.
    * `sudo -H pip3 install bs4`
    * `sudo -H pip3 install requests`
    * `sudo -H pip3 install lxml`
1. Clone the repository and `cd` to the folder.
1. You can open the `.csv` and change the words for search or... run it with the default words.
1. Before you run the script, open the finder window to see the execution of the script as all the `.txt` files are created or since you are in the current directory, run the following command:
    * `ls` and watch the execution.
1. Run the folling command:
    * `python3 text_mining.py`
1. You sould see a `.txt` file containing the `xml` content of your search.
1. Now you can bring that `.txt` file to RStudio for further analysis.

### HAPPY ANALYZING!!!!
