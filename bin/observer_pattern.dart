// У цьому прикладі ми маємо клас Scoreboard, який зберігає поточний рахунок
// спортивної гри. Методи addObserver та removeObserver використовуються для
// керування списком об'єктів Observer, які цікавляться рахунком. Метод
// updateScores оновлює рахунок і повідомляє про це всіх спостерігачів,
// викликаючи їх метод оновлення.

class Scoreboard {
  final List<Observer> _observers = [];
  int _homeScore = 0;
  int _awayScore = 0;

  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  void updateScores(int homeScore, int awayScore) {
    _homeScore = homeScore;
    _awayScore = awayScore;

    for (final observer in _observers) {
      observer.update(_homeScore, _awayScore);
    }
  }
}

// У нас також є абстрактний клас Observer з єдиним методом update, який приймає
// поточний домашній рахунок і рахунок на виїзді в якості параметрів

abstract class Observer {
  void update(int homeScore, int awayScore);
}

// Нарешті, у нас є клас Fan, який реалізує інтерфейс Observer. Об'єкт Fan
// цікавиться рахунком і буде сповіщений про його зміну. У цьому прикладі метод
// update просто виводить повідомлення про те, що вболівальник вболіває за
// команду з поточним рахунком.

class Fan implements Observer {
  final String _name;

  Fan(this._name);

  @override
  void update(int homeScore, int awayScore) {
    print(
        '$_name is cheering as the score is Home:$homeScore, Away:$awayScore');
  }
}

// Ось приклад того, як ми можемо використовувати ці класи:
void main() {
  final scoreboard = Scoreboard();
  final fan1 = Fan('John');
  final fan2 = Fan('Mary');

  scoreboard.addObserver(fan1);
  scoreboard.addObserver(fan2);

  scoreboard.updateScores(1, 0);
  scoreboard.updateScores(2, 1);

  scoreboard.removeObserver(fan2);

  scoreboard.updateScores(3, 1);
}

// У цьому прикладі ми створюємо новий об'єкт Scoreboard і два об'єкти Fan,
// fan1 і fan2. Ми додаємо обох вболівальників як спостерігачів табло за
// допомогою методу addObserver.

// Потім ми двічі оновлюємо рахунок за допомогою методу updateScores,
// який запускає метод update для кожного спостерігача. Обидва вболівальники
// будуть вболівати за команду з поточним рахунком.

// Потім ми видаляємо fan2 як спостерігача за допомогою методу removeObserver.
// Це означає, що fan2 не буде повідомлено про подальші оновлення рахунку.

// Нарешті, ми знову оновлюємо рахунок за допомогою методу updateScores.
// Про це оновлення буде повідомлено тільки fan1, оскільки fan2 було видалено
// як спостерігача.