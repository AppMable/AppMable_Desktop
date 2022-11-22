import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:faker/faker.dart';

Alert alertMockGenerator({
  int? id,
  String? name,
  String? description,
  int? soundLevel,
  int? vibrationLevel,
  int? timeLength,
  DateTime? dateEnabled,
  DateTime? dateDisabled,
  DateTime? dateCreated,
  DateTime? dateUpdated,
  int? idUser,
}) {
  return Alert(
    id: id ?? faker.randomGenerator.integer(9),
    name: name ?? faker.address.person.firstName(),
    description: description ?? faker.lorem.sentence(),
    soundLevel: soundLevel ?? faker.randomGenerator.integer(Alert.maxLevel),
    vibrationLevel: vibrationLevel ?? faker.randomGenerator.integer(Alert.maxLevel),
    timeLength: timeLength ?? faker.randomGenerator.integer(10000),
    dateEnabled: dateEnabled ?? faker.date.dateTime(),
    dateDisabled: dateDisabled ?? faker.date.dateTime(),
    dateCreated: dateCreated ?? faker.date.dateTime(),
    dateUpdated: dateUpdated ?? faker.date.dateTime(),
    idUser: idUser ?? faker.randomGenerator.integer(10),
  );
}

String getAlertHttpString(Alert alert) {
  return '''
  {
    "id": ${alert.id},
    "name": "${alert.name}",
    "description": "${alert.description}",
    "sound_level": "${alert.soundLevel}",
    "vibration_level": "${alert.vibrationLevel}",
    "time_length": "${alert.timeLength}",
    "date_enabled": "${alert.dateEnabled?.toString()}",
    "date_disabled": "${alert.dateDisabled?.toString()}",
    "date_created": "${alert.dateCreated?.toString()}",
    "date_updated": "${alert.dateUpdated?.toString()}",
    "id_user": ${alert.idUser},
  }
 ''';
}

String getAlertsHttpString({
  required List<Alert> alerts,
}) {
  String list = '[';

  final int numOfAlerts = alerts.length;
  int i = 0;

  for (Alert alert in alerts) {
    i++;
    list += getAlertHttpString(alert);
    if (i != numOfAlerts) list += ',';
  }
  list += ']';
  return list;
}
