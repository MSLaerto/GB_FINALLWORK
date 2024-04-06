import animals

class AnimalRegistry:
    def __init__(self):
        self.animals = []
        self.counter = 0

    def add_new_animal(self, animal):
        self.animals.append(animal)
        self.counter += 1

    def identify_animal_class(self, animal):
        if isinstance(animal, animals.Dogs) or isinstance(animal, animals.Cats) or isinstance(animal, animals.Hamsters):
            return "Домашнее животное"
        elif isinstance(animal, animals.Horses) or isinstance(animal, animals.Camels) or isinstance(animal, animals.Donkeys):
            return "Вьючное животное"
        else:
            return "Неопределенный класс животного"

    def show_commands(self, animal):
        if animal.get_commands():
            return animal.get_commands()
        else:
            return "Нет доступных команд для этого животного"

    def teach_new_commands(self, animal, new_commands):
        animal.assign_commands(new_commands)


registry = AnimalRegistry()

# Пример использования

dog1 = animals.Dogs("Шарик", "2018-03-10", "сидеть, лежать")
registry.add_new_animal(dog1)

cat1 = animals.Cats("Барсик", "2017-06-25", "прыгать, спать")
registry.add_new_animal(cat1)

print(registry.identify_animal_class(dog1))
print(registry.identify_animal_class(cat1))

print(registry.show_commands(dog1))
print(registry.show_commands(cat1))

registry.teach_new_commands(dog1, "к бутылке")
print(registry.show_commands(dog1))