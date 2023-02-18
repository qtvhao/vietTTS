from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/generate-audio', methods=['POST'])
def generate_audio():
    data = request.json
    text = data.get('text')
    script_output = subprocess.check_output(['sh', 'path/to/your/script.sh', text])
    presigned_url = script_output.decode('utf-8').strip()
    return jsonify({'url': presigned_url})

if __name__ == '__main__':
    app.run()
