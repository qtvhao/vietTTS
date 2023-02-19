import os
import subprocess
import json
from flask import Flask, request, make_response, send_file

app = Flask(__name__)

@app.route('/synthesizer', methods=['POST'])
def run_synthesizer():
    payload = request.json
    text = payload.get('TEXT')
    if not text:
        return 'Missing TEXT field in payload', 400
    try:
        cmd = f"python3 -m vietTTS.synthesizer --text '{text}' --output /output/clip.wav --lexicon-file assets/infore/lexicon.txt --silence-duration 0.2"
        output = subprocess.check_output(cmd, shell=True, text=True)
        output_path = '/output/clip.wav'
        if os.path.exists(output_path):
            response = make_response(send_file(output_path, mimetype='audio/wav'))
            response.headers.set('Content-Disposition', 'attachment', filename='clip.wav')
            return response, 200
        else:
            return f'{output} Output file not found', 500
    except subprocess.CalledProcessError as e:
        print(str(e))
        return 'Error synthesizing speech', 500

if __name__ == '__main__':
    print(app.url_map)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
