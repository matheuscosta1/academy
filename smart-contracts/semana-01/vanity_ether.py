from eth_account import Account

import binascii
import threading
from utils import logger, log_to_file

LOGGER = logger(__name__)

log_to_file(LOGGER)


def get_address():
    LOGGER.info('Thread initialized\n')
    i = 0
    while True:

        acct = Account.create('BCC008')
        if 'BCC008' in acct.address[2:8].upper():
            LOGGER.info(acct.address)
            LOGGER.info((binascii.hexlify(acct.key)))
            break
        else:
            print(i)
        i = i+1
    LOGGER.info('Thread initialized finished')


if __name__ == '__main__':
    thread1 = threading.Thread(target=get_address)
    thread2 = threading.Thread(target=get_address)
    thread3 = threading.Thread(target=get_address)
    thread4 = threading.Thread(target=get_address)
    thread5 = threading.Thread(target=get_address)
    thread6 = threading.Thread(target=get_address)
    thread7 = threading.Thread(target=get_address)
    thread8 = threading.Thread(target=get_address)
    thread9 = threading.Thread(target=get_address)
    thread10 = threading.Thread(target=get_address)
    thread11 = threading.Thread(target=get_address)
    thread12 = threading.Thread(target=get_address)
    # Starting the two threads
    thread1.start()
    thread2.start()
    thread3.start()
    thread4.start()
    thread5.start()
    thread6.start()
    thread7.start()
    thread8.start()
    thread9.start()
    thread10.start()
    thread11.start()
    thread12.start()

    thread1.join()
    thread2.join()
    thread3.join()
    thread4.join()
    thread5.join()
    thread6.join()
    thread7.join()
    thread8.join()
    thread9.join()
    thread10.join()
    thread11.join()
    thread12.join()
