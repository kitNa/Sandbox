void main() {
  // https://dart.dev/language/functions#lexical-closures

  // 1. Create a function deleteButtonHandler(String app) which creates a
  // functions which prints "app $app deleted".
  // Call this function with "Facebook" and "Instagram" as arguments - it will
  // generate two functions (handlers). Call each of them.

  // стан вхідного парамету на момент ініціалізації фіксується для усіх подальших використань
  var deleteFacebook = deleteButtonHandler('Facebook');
  var deleteInstagram = deleteButtonHandler('Instagram');
  deleteFacebook(3);
  deleteInstagram(6);
}

void Function(int) deleteButtonHandler(String app) {
  return (int i) => print("app $app was deleted for $i seconds");
}
