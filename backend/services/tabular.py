#For tabular data operations (JSON <->Excel/CSV)
import pandas as pd, tempfile as tf
import json
import io
from werkzeug.datastructures import FileStorage

#if not working, try https://stackoverflow.com/questions/15379178/how-to-convert-json-to-xls-in-python

def jsonToExcel(data): #data may be a json body or a json file
    if hasattr(data, 'read'):
        parsed = json.load(data) #reads a json file into a json object
    else:
        parsed = data
    output = io.BytesIO()
    pd.DataFrame(parsed).to_excel(output, index=False)
    output.seek(0)
    return output #xlsx file

def pdfToDocx(data):
    #install pdf library
    print("")