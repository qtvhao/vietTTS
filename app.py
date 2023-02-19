import subprocess
import json
from flask import Flask, request

app = Flask(__name__)

@app.route('/synthesizer', methods=['POST'])
def run_synthesizer():
    payload = request.json
    text = payload.get('TEXT')
    if not text:
        return 'Missing TEXT field in payload', 400
    try:
        cmd = f"python -m vietTTS.synthesizer --lexicon-file=train_data/lexicon.txt --text='{text}' --output=/output/clip.wav"
        result = subprocess.check_output(cmd, shell=True, text=True)
        output = {}
        output['HASH'] = result.split('\n')[0]
        output['PRESIGNED-URL'] = result.split('\n')[2]
        return json.dumps(output), 200
    except Exception as e:
        return str(e), 500
if __name__ == '__main__':
    print(app.url_map)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
