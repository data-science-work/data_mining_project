# Web Scrapping Tool For Data Mining

<!-- MarkdownTOC -->

- [What it does?](#what-it-does)
- [What you need to run the app?](#what-you-need-to-run-the-app)
- [Instructions for how to setup running environment.](#instructions-for-how-to-setup-running-environment)
- [HAPPY ANALYZING!!!!](#happy-analyzing)

<!-- /MarkdownTOC -->




### What it does?

The application search the Internet utilizing the Gigablast search engine with terms that the user types to a `csv` file located at the root of the application. After the search is performed, the application creates `txt` files that can be imported to any platform for data mining analysis.

### What you need to run the app?


In order to run the app you need to create a Gigablast account. You can do so at [Gigablast](http://gigablast.com/ "Gigablast's Home Page"). It is a $5.oo fee. Gigablast charges $0.99 per 1000 queries. After you create the account, you need to set your `userid` and your `code` in the `my_params` variable inside `text_mining.py`. You will also need Python3 installed in your computer. You can visit the [Python](https://www.python.org/ "Python Home Page") website for instructions on how to install Python.


### Instructions for how to setup running environment.

Once you have Python3 install in your computer, and Python3 is in your global environment; instructions on how to make Python3 global in your environment [here]('https://github.com/pyenv/pyenv#basic-github-checkout'), you can clone the repo to your computer.

`$ git clone https://github.com/diazgilberto/data_mining_project.git`

After cloning the repo, open your terminal, `cd` to `data_mining_project`, and open the `query.csv`. Modify the file with the terms and/or keywords you want to search, save and close the file. On your terminal run the following command...

`python3 text_mining.py` or `python text_mining.py`

it depends on how you setup python3 in your global environment. Shortly after you start the app, you will see status messages in the terminal. You will also notice that new `.txt` files are getting created in the root of `data_mining_project`. After the process is finished, your files a ready to performed data mining analysis.

### HAPPY ANALYZING!!!!
