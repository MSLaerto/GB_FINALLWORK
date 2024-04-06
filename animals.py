class Animals:
    def __init__(self, name, birthday, commands):
        self._name = name
        self._birthday = birthday
        self._commands = commands

    def get_name(self):
        return self._name

    def get_birthday(self):
        return self._birthday

    def get_commands(self):
        return self._commands


class Pets(Animals):
    def __init__(self, name, birthday, commands):
        super().__init__(name, birthday, commands)

    def assign_commands(self, new_commands):
        self._commands += ", " + new_commands


class PackAnimals(Animals):
    def __init__(self, name, birthday, commands):
        super().__init__(name, birthday, commands)


class Dogs(Pets):
    def __init__(self, name, birthday, commands):
        super().__init__(name, birthday, commands)


class Cats(Pets):
    def __init__(self, name, birthday, commands):
        super().__init__(name, birthday, commands)


class Hamsters(Pets):
    def __init__(self, name, birthday, commands):
        super().__init__(name, birthday, commands)


class Horses(PackAnimals):
    def __init__(self, name, birthday, commands):
        super().__init__(name, birthday, commands)


class Camels(PackAnimals):
    def __init__(self, name, birthday, commands):
        super().__init__(name, birthday, commands)


class Donkeys(PackAnimals):
    def __init__(self, name, birthday, commands):
        super().__init__(name, birthday, commands)