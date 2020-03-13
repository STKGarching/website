from flask_restful import Resource, Api
from flask import request

class HelloAPI(Resource):
    def get(self):
        return """
          <html>
            <head>
              Welcome to STK Garching API.
            </head>
            <body>
              For more information check this link:{0}/swagger
            </body></html>"
        """.format(request.url)