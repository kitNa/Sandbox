void main() {
  // https://dart.dev/language/typedefs

  // 1. Define "IntList" typedef to be an alias for "List<int>". Create a list
  // of numbers from 1 to 5 using "IntList" alias type.
  typedef IntList = List<int>;
  IntList list = [1, 2, 3, 4, 5];

  // 2. Define "Ages" typedef to be an alias for "Map<String, int>". Create a
  // map of your family members and their ages using "Ages" alias type.
  typedef Ages = Map<String, int>;
  Ages myFamilyAge = [Katya: 32, Sasha: 42, Margosha: 5];
}
