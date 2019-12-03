import requests
import json

f= open("random1.txt", "w+")#creating a text file as an output for all log inputs
f1 = open("logs.csv","w+")#creating a csv file as an output for all log inputs
f2 = open ("final_logs.json","w+")#creating a json file as an output for all log inputs
def search(uri,criteria, term):
    json_q = json.dumps({
          "query": {
               "match": {
                        criteria:term}}})# defining our search criteria which can be modified by the user


    headers ={'Content-Type' : 'application/json'}
    res=requests.get(uri, headers=headers,  data = json_q)

    response = requests.get(uri,headers=headers, data=json_q)

    results =json.loads(res.text)
    return results


def format_results(results):

    data = [i for i in results['hits']['hits']]
    for i in data:
        f.write(i['_id'])#publishing the results to txt file
        f.write(json.dumps(i['_source']))
        f1.write(i['_id'])
        f1.write(json.dumps(i['_source']))#publishing the results to csv file
        f2.write(i['_id'])#publishing the results to json file
        f2.write(json.dumps(i['_source']))


if __name__ == '__main__':

    uri_search = input("Enter your index: ")#user inputing their index for ehich they wanna obtain the log files
    print(uri_search)



    results = search(uri_search,"host.name", "sn004")#giving the search term as sn004
    format_results(results)