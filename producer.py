import time, cv2, sys
from kafka import SimpleProducer, KafkaClient

# this will be used to "produce, aka send the messages"

# lets connect to the Kafka client
kafka = KafkaClient('localhost:9002')
producer = SimpleProducer(kafka)

# create topic
topic = 'my-test-topic-'


def videoSender(video):

        # opens the video
        video = cv2.VideoCapture(vdeo)

        print('emitting')


        # now we will read in the contents of the file

        while video.isOpened:
                # reads each image in each frame
                success, image = video.read()
                # lets check to see if the file has been read to the end
                if not success: # checks to see if success returned false
                        break # end loop
                # convert images to jp
                ret, jpeg = cv2.imencode('.png', image)
                # convert images to byte send to kafka
                producer.send_message(topic, jpeg.tobytes())
                # to reduce CPU usage create sleep time of 0.2 seconds
                time.sleep(0.2)

        # clear video capture
        video.release()




if len(sys.argv) == 0:
        print('usage:\nproducer.py <video-name>')
        exit()

videoSender(sys.argv[0])
