#!/usr/bin/env python3
import os
from csv import reader

# Go through list of csvs in current dur and sum something


query_total = ''

for csv in os.listdir('.'):
    if csv.endswith(".csv"):

        with open(csv) as file:

            csv_reader = reader(file)

            for row in csv_reader:

                query_total += f"'{row[0]}',\n" 

            query_total = query_total[:-1] # Optional - remove last char

print(query_total)
