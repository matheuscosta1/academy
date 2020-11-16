package sensor;

import java.util.concurrent.TimeUnit;

public class TemperatureSensor {
    public static void publish() {
        int max = 46;
        int min = 15;
        int qos = 2;
        String topic = "Temperature Sensor";
        String clientId = "TemperatureSensor";
        String broker = "tcp://mqtt.eclipse.org:1883";
        MemoryPersistence persistence = new MemoryPersistence();
        String random_temperature;

        // Connect
        MqttClient sampleClient = new MqttClient(broker, clientId, persistence);
        MqttConnectOptions connOpts = new MqttConnectOptions();
        connOpts.setCleanSession(true);
        sampleClient.connect(connOpts);

        // Loop
        while(true) {
            try {
                random_temperature = String.valueOf((Math.random() * (max - min + 1) + min));
                MqttMessage message = new MqttMessage(random_temperature.getBytes());
                message.setQos(qos);
                sampleClient.publish(topic, message);
                TimeUnit.SECONDS.sleep(1);
            } catch (InterruptedException ex) {
                sampleClient.disconnect();
                System.exit(0);
            } catch(MqttException me) {
                MqttException me;
            }
        }
    }
}
