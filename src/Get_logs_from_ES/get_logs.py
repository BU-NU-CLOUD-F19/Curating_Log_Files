import requests
import json
from pprint import pprint

def search(uri, term, criteria):
    json_q = json.dumps({
          "query": {
               "match": {
                        criteria:term}}})#criteria can be host.name or timestamp, message etc which can be modified by the user as these are variables accepting the search criteria


    headers ={'Content-Type' : 'application/json'}
   #res=requests.get(uri, headers=headers,  data = json_q)

    response = requests.get(uri,headers=headers, data=json_q)
    results = json.dumps(response.json(),indent = 4 , sort_keys = True)# indenting and sorting the key value pairs in ascending order to have a readable log file
    pprint(json.loads(json.dumps(results, indent =4,sort_keys = True)))# pretty printing



if __name__ == '__main__':
    uri_search = input("Enter your index: ")# inputing the index value to obtain log files
    print(uri_search)



    results = search(uri_search, "sn004", "host.name")#search term is host name sn004 which can be modified by the user