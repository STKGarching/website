from setuptools import setup

setup(
   name='stk_api',
   version='1.0',
   description='STK Garching API',
   author='Miro',
   author_email='miro@example.com',
   packages=['stk_api'], 
   install_requires=['flask_swagger_ui', 'flask-mysql', 'flask-cors', 'flask_restful']
)
