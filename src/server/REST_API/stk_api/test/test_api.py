import unittest
import os
from api import app
from test.helper import Helper


class APITestCase(unittest.TestCase):
    @classmethod
    def setUpClass(self):
        self.app = app
        self.client = self.app.test_client()
        Helper.create_test_db
    
    def test_hello(self):       
        resp = self.client.get(path='/')
        self.assertEqual(resp.status_code, 200)
    
    def test_upload_txt_file(self):
        txt_file_to_upload = os.path.join(os.getcwd(),"test/files/test.txt")
        files = {'file': open(txt_file_to_upload, "rb")}
        data={
            "files": files,
        }
        resp = self.client.post(path='/upload_file', data=data)
        self.assertEqual(resp.status_code, 200)

    def test_upload_png_file(self):
        png_file_to_upload = os.path.join(os.getcwd(),"test/files/STK_ERR.png")
        files = {'file': open(png_file_to_upload, "rb")}
        data={
            "files": files,
        }
        resp = self.client.post(path='/upload_file', data=data)
        self.assertEqual(resp.status_code, 200)

