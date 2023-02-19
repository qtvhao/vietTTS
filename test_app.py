import json
import subprocess
from flask import Flask
from unittest import mock
import app

def test_run_synthesizer():
    app.app.testing = True
    with mock.patch('subprocess.check_output') as mock_check_output:
        mock_check_output.return_value = 'hash123\nurl456\n'
        client = app.app.test_client()
        data = {'TEXT': 'Hello, world!'}
        response = client.post('/synthesizer', json=data)
        print(response.data)
        print(response.data)
        print(response.data)
        print(response.data)
        assert response.status_code == 200
        expected_output = {'HASH': 'hash123', 'PRESIGNED-URL': 'url456'}
