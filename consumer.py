from flask import Flask, Response
from kafka import kafkaConsumer

# The consumer listens, and consumes the messages from the Kafka broker and will listen for messages of a specific topic and display them.

# Connect to the kafka consumer  we must specify the topic we want to consume
consumer = kafkaConsumer('my-topic', group_id='view' bootstrap_servers=['0.0.0.0:9092'])

# This will let us continuously listen to the connect and print messages as received

app = Flask(__name__)

# anytime the website is accessed without specify anything after root directory run this
@app.route('/')
def index():
    # lets return a multipart response
    return Response(kafkastream(), mimetype='multipart/x-mixed-replace; boundary=frame')

def kafkastream():
    for msg in consumer:
        yield (b'--frame\r\n'
               b'Content-Type: image/png\r\n\r\n' + msg.value + b'\r\n\r\n')



if __name__ == '__main__':
    app.run(host='0.0.0.0:6666', debug=True)