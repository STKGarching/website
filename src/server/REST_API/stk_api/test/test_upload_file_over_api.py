import requests
import json
import os

url = "http://127.0.0.1:5000/upload_file"
txt_file_to_upload = os.path.join(os.getcwd(),"test/files/test.txt")
files = {'file': open(txt_file_to_upload, "rb")}
r = requests.post(url, files=files)
print(r.status_code)
png_file_to_upload = os.path.join(os.getcwd(),"test/files/STK_ERR.png")
files = {'file': open(png_file_to_upload, "rb")}
r = requests.post(url, files=files)
print(r.status_code)


