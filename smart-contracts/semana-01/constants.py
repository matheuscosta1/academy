import os

FORMAT_DATE_Y_m_d = '%Y-%m-%d'
FORMAT_DATE_TIMESTAMP = '%Y-%m-%d %H:%M:%S'
FORMAT_DATE_LOGSTASH = '%Y.%m.%d'
FORMAT_TIMESTAMP_DATE = '%Y-%m-%d'
FORMAT_TIMESTAMP_HOUR = '%H:%M:%S'
SUFFIX_ISO_DATE = 'T00:00:00Z'
TIMEZONE = 'America/Sao_Paulo'

PROJECT_ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
os.chdir(PROJECT_ROOT_DIR)
PROPERTIES_PATH = os.path.join(PROJECT_ROOT_DIR, 'src/resources/config/properties.cfg')
CUSTOMER_CSV_PATH = os.path.join(PROJECT_ROOT_DIR, 'csv/affected_customers.csv')
CATALOG_PROFILE_CSV_PATH = os.path.join(PROJECT_ROOT_DIR, 'csv/catalog_profiles.csv')
LOGS_PATH = os.path.join(PROJECT_ROOT_DIR, 'logs/')
