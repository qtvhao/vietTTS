import json
import subprocess
import unittest
from flask import Flask
from unittest.mock import patch

app = Flask(__name__)

class TestAPI(unittest.TestCase):

    def setUp(self):
        app.testing = True
        self.client = app.test_client()

    @patch('subprocess.check_output')
    def test_synthesizer(self, mock_check_output):
#         mock_check_output.return_value = '1234567890abcdef\n\nhttps://s3.amazonaws.com/tts-results/1234567890abcdef.wav\n'
        data = {'TEXT': 'Hello, world!'}
        response = self.client.post('/synthesizer', json=data)
#         self.assertEqual(response.status_code, 200)
#         output = json.loads(response.data.decode('utf-8'))
#         self.assertEqual(output['HASH'], '1234567890abcdef')
#         self.assertEqual(output['PRESIGNED-URL'], 'https://s3.amazonaws.com/tts-results/1234567890abcdef.wav')

    def tearDown(self):
        pass

if __name__ == '__main__':
    unittest.main()
