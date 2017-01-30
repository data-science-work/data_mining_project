"""Gigablast Web Search Python Script.
Authors: Gilberto Diaz | Toni Brant | Ash Yenamandra | Jacob Jones | Nick Enko | David Keough
Course: MSDS5163 Data Mining
Professor: Dr. Tim Wallace

Problem:
You are a data scientist with Big Data Science Incorporated (BDSI), and you
are instructed to perform spectral clustering to investigate the hidden
relational objects on the Internet (or later your own intranet) of
interest to your company's research keywords and URL's. The
overall goal is to data mine the Internet to find content
which is invisible to the research team, but that must
discovered by the data scientist in order for
the contracting client company to remain
competitive.

Application Description:
This is a Python application that utilizes the Gigablast Search Engine to
search the Internet and download webstie's information in xml format.
The application will save the xml content to the hard drive in a
.txt file.
"""

# Dependencies
import requests
from bs4 import BeautifulSoup


# Reading File
file_csv = open('query-test-file-2.csv', 'r')
words = file_csv.read().splitlines()

# Base Gigablast URL
base_url = 'https://www.gigablast.com/search?c=main&index=search&sc=1&hacr=1'

# Building Gigablast Paramaters
for topics in words:
    term = topics.replace(',', ' ')
    my_params = {'userid': '113', 'code': '359492133', 'format': 'xml',
    'q': term, 'n': '5', 'dr': '1', 'filetype': 'html',
    'pss': '50', 'ddu': '1', 'sortby': '0', 'qlang': 'en'}

    # GET Request to Gigablast
    gigablast = requests.get(base_url, params=my_params)

    # Parsing xml from gigablast object
    gigablast = gigablast.text
    xml = BeautifulSoup(gigablast, 'xml')

    # Cleaning urls
    urls = xml.find_all('url')
    urls_list = []
    for url in urls:
        url = url.text.replace('<url>', '').replace('</url>', '').replace('https://', '').replace('http://', '')
        urls_list.append(url)

    # Creating a urls_list with status code == 200.
    clean_urls = []
    for link in urls_list:
        print(link)
        try:
            page = requests.get('http://' + link, timeout=5)
            print('Status code = ' + str(page.status_code) + '\n')
            if page.status_code == 200:
                clean_urls.append('http://' + link)
        except:
            pass

    # Fetching top 10 webpages from clean_urls. Saving top 10
    # webpages to hard drive in a .txt file. Each file
    # will be named based on the 'q' parameter
    # of the gigablast request.
    count = 1
    for link in clean_urls[:10]:
        try:
            page = requests.get(link, timeout=5).text
            soup = BeautifulSoup(page, 'html.parser')

            # Removing JS and CSS
            for script in soup(['script', 'style']):
                script.decompose()
                with open(my_params['q'] + '_' + str(count) + '.txt', 'w') as webpage_out:
                    webpage_out.write(soup.get_text())
                    print('The file ' + my_params['q'] + '_' + str(count) + '.txt ' + 'has been created successfully.')
                    count += 1
        except:
            pass

webpage_out.close()

