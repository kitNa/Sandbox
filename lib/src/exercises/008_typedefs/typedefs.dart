typedef IntList = List<int>;
typedef Ages = Map<String, int>;

void main() {
  // https://dart.dev/language/typedefs

  // 1. Define "IntList" B to be an alias for "List<int>". Create a list
  // of numbers from 1 to 5 using "IntList" alias type.
  IntList list = [1, 2, 3, 4, 5];

  // 2. Define "Ages" typedef to be an alias for "Map<String, int>". Create a
  // map of your family members and their ages using "Ages" alias type.
  Ages myFamilyAge = {'Katya': 32, 'Sasha': 42, 'Margosha': 5};
}
