from flask import Flask, jsonify, request, send_file
from flask_restful import Resource, Api, reqparse, fields, marshal_with, abort
from flask_cors import CORS

import json, csv, os, requests

from services import tabular
import pandas

app = Flask(__name__)
CORS(app) #https://pypi.org/project/flask-cors/
api = Api(app)

conversion_args = reqparse.RequestParser()
conversion_args.add_argument('source', type=str, required=True, help='Source format')
conversion_args.add_argument('target', type=str, required=True, help='Output format')

CONVERTERS = {
        ("json", "xlsx"): tabular.jsonToExcel,
        #("csv", "xlsx"): CsvToExcelConverter(),
        #("xlsx", "json"): ExcelToJsonConverter(),
        #("xlsx", "csv"): ExcelToCsvConverter(),
}
def get_converter(source, target):
    return CONVERTERS.get((source.lower(), target.lower()))
    

class Conversion(Resource):

    def post(self):
        print("request received")
        if request.is_json:
            body = request.get_json()
            source = body["source"]
            target = body["target"]
            data = body["data"]

        elif request.content_type.startswith("multipart/form-data"):
            print("in elif")
            source = request.form["source"]
            target = request.form["target"]
            data = request.files["file"]
            print("parsed data")
        else:
            print("unsupported content")
            return {
                "error": "Unsupported content type"
            }, 400

        converter = get_converter(source, target) #returns a function
        if converter is None:
            return {"error: Unsupported conversion"}, 400
        result = converter(data)
        return send_file(result, download_name=(f'output.{target}'), as_attachment=True)
       


api.add_resource(Conversion, '/api/tabular')

@app.route("/")
def home():
    return "<h1>Flask Rest API</h1>"


if __name__ == '__main__':
    app.run(debug=True)