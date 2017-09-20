# Dashbase-Kafka-Template

### Docker Compose
1. Fill out the `kafka_config.env` file with the relevant information.
2. Pull the latest images with `docker-compose pull`
3. `docker-compose up -d`


### Dashbase CLI
1. Change the env section for the `table` service to match the relevant information.
```
env:
  KAFKA_BROKER: localhost:9092
  KAFKA_GROUPID: my-groupid
  KAFKA_TOPIC: my-topic
```
2. Navigate to ./config-template
3. `dashbase-cli start`

#### Notice:
- Make sure Docker 1.10.0+, Compose 1.6.0+.
- Ensure CLI version is > 1.0.0rc9
- Make sure the specified Kafka broker host can be reached, otherwise Dashbase will be unable to consume from it.
