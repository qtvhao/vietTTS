from flask import Flask, request

app = Flask(__name__)

@app.route('/synthesizer', methods=['POST'])
def synthesizer():
    text = request.form['text']
    # Run the synthesizer script
    import subprocess
    command = f'python -m vietTTS.synthesizer --lexicon-file=train_data/lexicon.txt --text="{text}" --output=clip.wav'
    subprocess.run(command, shell=True)
    # Upload the audio file to S3
    import hashlib
    hash_value = hashlib.md5(text.encode()).hexdigest()
    s3_endpoint_url = '<your S3 endpoint URL>'
    s3_bucket_name = '<your S3 bucket name>'
    subprocess.run(f'aws s3 cp clip.wav s3://{s3_bucket_name}/{hash_value}.wav --endpoint-url {s3_endpoint_url}', shell=True)
    # Generate a presigned URL for the audio file
    presigned_url = subprocess.check_output(f'aws s3 presign s3://{s3_bucket_name}/{hash_value}.wav --endpoint-url {s3_endpoint_url}', shell=True)
    return f'Presigned URL: {presigned_url}'

if __name__ == '__main__':
    app.run()
