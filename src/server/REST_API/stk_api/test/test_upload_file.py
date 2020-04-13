import unittest
import requests
from flask import Flask
from flask_restful import Resource, Api
from flask_cors import CORS

testapp = Flask(__name__)
CORS(testapp)
api = Api(testapp)

#class UploadTestCase(unittest.TestCase):
#    def testUploadTxtFile(self):        
#        with api:
#            url = "http://127.0.0.1:5000/upload_file"
#            txt_file_to_upload = "test.txt"
#            files = {'file': open(txt_file_to_upload, "rb")}
#            r = requests.post(url, files=files)
#            self.assertEqual("200",r.status_code)
            
