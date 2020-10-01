import json
import logging
import math
import sys
import os
import traceback 
import argparse
from concurrent import futures
import datetime
import snowflake.connector
from snowflake_db import SnowflakeDB
import yaml
from datetime import datetime,timedelta
import itertools as it
from operator import itemgetter
file_path = os.path.dirname(os.path.realpath(__file__))
sys.path.append(file_path + "/..")


def read_config( config_file):

    """Read JSON config file, parses it"""
    with open(config_file) as json_config_file:
        config = json.load(json_config_file)
    return config


def parse_args():
    """Parses the arguments and returns them"""
    parser = argparse.ArgumentParser(description='Run the acquisition load')
    parser.add_argument('load_config', type=str, action='store',   help='load name ' ) 
    return parser.parse_args()


def main():
    args = parse_args()
    (len(vars(args)))
    print("file_path-->",file_path)
    if len(vars(args)) > 0 :
        load_config=f'{file_path}/{args.load_config}' 
        print ("load_config-->",load_config)
        #config=read_config(load_config)
        with open(load_config) as file:
            object_list=yaml.load(file,Loader=yaml.FullLoader)
         
        for items in object_list['operation']:
             print("------")
             print(items['script'])
             os.system(items['script'])

    else:
        print("No parameter supplied")
   
if __name__ == '__main__': main()


