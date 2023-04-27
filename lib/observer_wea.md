// Шаблон спостерігача можна реалізувати в Dart для метеорологічної програми

// У цьому прикладі ми маємо клас WeatherData, який зберігає поточні значення
// температури, вологості та тиску.
// Методи addObserver та removeObserver використовуються для керування списком
// об'єктів Observer, які зацікавлені у погодних даних.
// Метод setMeasurements оновлює погодні дані і повідомляє про це всіх
// спостерігачів, викликаючи їх метод оновлення. Метод notifyObservers
// використовується для ітераційного перебору всіх спостерігачів і виклику
// їхніх методів оновлення.

class WeatherData {
  final List<Observer> _observers = [];
  double _temperature = 0.0;
  double _humidity = 0.0;
  double _pressure = 0.0;

  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  void setMeasurements(double temperature, double humidity, double pressure) {
    _temperature = temperature;
    _humidity = humidity;
    _pressure = pressure;

    notifyObservers();
  }

  void notifyObservers() {
    for (final observer in _observers) {
      observer.update(_temperature, _humidity, _pressure);
    }
  }
}

// У нас також є абстрактний клас Observer з єдиним методом update, який приймає
// поточні значення температури, вологості та тиску як параметри.

abstract class Observer {
  void update(double temperature, double humidity, double pressure);
}

// Нарешті, у нас є два класи, які реалізують інтерфейс Observer:
// CurrentConditionsDisplay та StatisticsDisplay. Об'єкт CurrentConditionsDisplay
// цікавиться поточними показниками температури та вологості і буде сповіщений
// про їх зміну. У цьому прикладі метод update просто зберігає показники
// температури та вологості і викликає метод display для виведення поточних умов.

class CurrentConditionsDisplay implements Observer {
  double _temperature = 0.0;
  double _humidity = 0.0;

  @override
  void update(double temperature, double humidity, double pressure) {
    _temperature = temperature;
    _humidity = humidity;

    display();
  }

  void display() {
    print(
        'Current conditions: ${_temperature}F degrees and ${_humidity}% humidity');
  }
}

// Об'єкт StatisticsDisplay цікавиться середніми значеннями температури та
// вологості з плином часу. У цьому прикладі метод update зберігає показники
// температури і вологості та відстежує кількість зчитувань. Метод display
// обчислює середні значення температури і вологості та виводить їх на друк.

class StatisticsDisplay implements Observer {
  double _temperatureSum = 0.0;
  double _humiditySum = 0.0;
  int _numReadings = 0;

  @override
  void update(double temperature, double humidity, double pressure) {
    _temperatureSum += temperature;
    _humiditySum += humidity;
    _numReadings++;

    display();
  }

  void display() {
    final averageTemperature = _temperatureSum / _numReadings;
    final averageHumidity = _humiditySum / _numReadings;

    print('Average temperature: $averageTemperature F degrees');
    print('Average humidity: $averageHumidity %');
  }
}

// Ось приклад того, як ми можемо використовувати ці класи:

void main(List<String> args) {
  final weatherData = WeatherData();
  final currentConditionsDisplay = CurrentConditionsDisplay();
  final statisticsDisplay = StatisticsDisplay();

  weatherData.addObserver(currentConditionsDisplay);
  weatherData.addObserver(statisticsDisplay);

  weatherData.setMeasurements(80.0, 65.0, 30.4);
  weatherData.setMeasurements(82.0, 70.0, 29.2);
  weatherData.setMeasurements(78.0, 90.0, 29.2);
}



// Цей код створює об'єкт `WeatherData` і два об'єкти `Observer`:
// `CurrentConditionsDisplay` і `StatisticsDisplay`. Спостерігачі додаються до
// об'єкта `WeatherData` за допомогою методу `addObserver`. Потім тричі
// викликається метод `setMeasurements` з різними значеннями температури,
// вологості та тиску. Кожного разу об'єкт `WeatherData` оновлює свій внутрішній
// стан і повідомляє про це всіх спостерігачів, викликаючи їх метод `update`.
// Спостерігачі оновлюють свій стан і роздруковують відповідну інформацію.
// У цьому прикладі `CurrentConditionsDisplay` виводить поточну температуру і
// вологість, а `StatisticsDisplay` виводить середню температуру і вологість за
// всіма показаннями.

// Це простий приклад того, як паттерн "Спостерігач" може бути використаний для
// відокремлення моделі даних програми від її інтерфейсу користувача. Дозволяючи
// декільком спостерігачам реєструвати інтерес до певної моделі даних, ми можемо
// уникнути необхідності жорсткого кодування специфічної поведінки у нашому
// додатку. Замість цього ми можемо визначити набір спостерігачів загального
// призначення, які можна повторно використовувати у різних додатках.
