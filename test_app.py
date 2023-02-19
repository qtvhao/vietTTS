import json
import subprocess
from flask import Flask
from unittest import mock
import app

def test_run_synthesizer():
    app.app.testing = True
#     with mock.patch('subprocess.check_output') as mock_check_output:
#     mock_check_output.return_value = 'hash123\nurl456\n'
    client = app.app.test_client()
    data = {'TEXT': 'Bài kiểm thử đã chạy'}
    response = client.post('/synthesizer', json=data)
    print(f"Response data: {response.data}")
    assert response.status_code == 200
#     expected_output = {'HASH': 'hash123', 'PRESIGNED-URL': 'url456'}
#     assert json.loads(response.data) == expected_output
    assert len(response.data) > 1024, "Response body size is less than 1KB"
