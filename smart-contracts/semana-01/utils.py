import configparser
import distutils.util
import logging
import os
from datetime import datetime
from enum import Enum

from constants import PROPERTIES_PATH, FORMAT_DATE_Y_m_d, LOGS_PATH


def date_year_month_day(str_dt):
    """ Convert string to date in format '%Y-%m-%d' """
    return datetime.strptime(str_dt, FORMAT_DATE_Y_m_d)


def iso8601_format(str_dt):
    """ Convert date string in format '%Y-%m-%d' to format iso8601 '%Y-%m-%dT00:00:00Z' """
    return date_year_month_day(str_dt).isoformat() + 'Z'


def get_date_time():
    return datetime.today().strftime('%Y-%m-%d %H:%M:%S')


def logger(name):
    get_logger = logging.getLogger(name)
    logging.basicConfig(format='[%(asctime)s] %(levelname)s %(filename)s: %(message)s', datefmt='%Y-%m-%d %H:%M:%S.%s',
                        level=logging.INFO)
    return get_logger


def log_to_file(log):
    file_handle = logging.FileHandler(LOGS_PATH + datetime.now().strftime("%Y-%m-%d %H:%M:%S") + '.log')
    log.addHandler(file_handle)


class Environment(Enum):
    LOCAL = 'LOCAL',
    HML = 'HML',
    PROD = 'PROD',
    QA = 'QA'

    @classmethod
    def get(cls):
        """Return enumeration enviroment name.

            If the profile was defined in the parameters.

        """
        profile = os.environ.get('PROFILE', 'LOCAL').upper()
        if profile == 'HML':
            return cls.HML.name
        elif profile == 'PROD':
            return cls.PROD.name
        elif profile == 'QA':
            return cls.QA.name

        return cls.LOCAL.name

    @classmethod
    def get_logging_level(cls):
        if Environment.get() == 'LOCAL':
            return logging.DEBUG
        return logging.INFO


class PropertiesUtils:
    """ Utility to manipulate environment properties.cfg. """

    @staticmethod
    def get(key: str):
        """Returns property by key.

            Defined by environment and module name.

        :param key:

        :return:
        """
        config = configparser.ConfigParser()

        if not os.path.isfile(PROPERTIES_PATH):
            raise FileNotFoundError(PROPERTIES_PATH)

        config.read(PROPERTIES_PATH)
        env = Environment.get()
        try:
            return config[env][key]
        except KeyError:
            logger(__name__).error(' key=\'{}\' not found in \'{}\' '.format(key, PROPERTIES_PATH))
            return ''

    @staticmethod
    def get_environment(key: str):
        """Returns environment property by key.

            Defined in environment.

        :param key:

        :return:
        """
        return os.environ.get(key, '')


class StringUtils:
    """ Utility to manipulate strings. """

    @staticmethod
    def to_bool(value):
        return distutils.util.strtobool(value)
