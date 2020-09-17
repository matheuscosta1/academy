from selenium import webdriver
import time
""" Exemplo de Pagine Object(PO) no google.com"""

class Google:
    def __init__(self, driver):
        self.driver = driver
        self.url = 'http://google.com.br'
        self.search_bar = 'q' #por name
        self.btn_search = 'btnK' #por name
        self.btn_lucky = 'btnI' #por name
 
    def navigate(self):
        self.driver.get(self.url)

    def search(self, word='None'):
        self.driver.find_element_by_name(
                self.search_bar).send_keys(word)
        time.sleep(1)
        self.driver.find_element_by_name(
                self.btn_search).click()

    def lucky(self, word='None'):
        self.driver.find_element_by_name(
                self.search_bar).send_keys(word)
        time.sleep(1)
        self.driver.find_element_by_name(
                self.btn_lucky).click()

ff = webdriver.Firefox()
g = Google(ff)
g.navigate()
g.lucky('Facebook')
#g.search('Live de Python')

