"""Gigablast Web Search Python Script.
Author: Gilberto Diaz

Application Description:
This application utilizes the Gigablast Search Engine to
search the Internet and download web site's content in
HTML format. The application will save the web page
content to the local hard drive in a text file.
"""

import requests
from bs4 import BeautifulSoup
import re


def main():
    # Reading File
    file_csv = open('query.csv', 'r')
    words = file_csv.read().splitlines()

    # Base Gigablast URL
    base_url = 'https://www.gigablast.com/search?c=main&index=search&sc=1&hacr=1'

    # Building Gigablast Paramaters
    for topics in words:
        term = topics.replace(',', ' ')
        my_params = {'userid': '113', 'code': '359492133', 'format': 'xml',
                     'q': term, 'n': '3', 'dr': '1', 'filetype': 'html',
                     'pss': '10', 'ddu': '1', 'sortby': '0', 'qlang': 'en'}

        # GET Request to Gigablast
        reqst = requests.get(base_url, params=my_params)
        resp = reqst.text

        # Parsing XML from Gigablast object
        xml = BeautifulSoup(resp, 'html.parser')

        # Cleaning URL's
        urls = xml.find_all('url')

        # Creating URL's list
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
                stat_code = str(page.status_code)
                print('Status code = ' + stat_code + '\n')
                if page.status_code == 200:
                    clean_urls.append('http://' + link)
            except requests.exceptions.Timeout:
                print('TIMEOUT ERROR: Web page has not respond in 5 seconds.')

        # Fetching web pages from clean_urls. Saving top 10
        count = 1
        for link in clean_urls[:10]:
            try:
                request_page = requests.get(link, timeout=5)
                page = request_page.text
                soup = BeautifulSoup(page, 'html.parser')

                # Removing JS and CSS
                scripts = soup.findAll(['script', 'style'])
                for match in scripts:
                    match.decompose()
                    file_content = soup.get_text()
                    # Striping 'ascii' code
                    content = re.sub(r'[^\x00-\x7f]', r' ', file_content)
                # Creating 'txt' files
                with open(my_params['q'] + '_' + str(count) + '.txt', 'w+') as webpage_out:
                    webpage_out.write(content)
                    print('The file ' + my_params['q'] + '_' + str(count) + '.txt ' + 'has been created successfully.')
                    count += 1
            except requests.exceptions.Timeout:
                print('TIMEOUT ERROR: Web page has not respond in 5 seconds.')


if __name__ == '__main__':
    main()
