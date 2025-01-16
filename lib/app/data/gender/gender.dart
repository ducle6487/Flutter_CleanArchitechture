enum Gender {
  male(true, "male"),
  female(false, "female");

  final bool value;
  final String name;

  const Gender(this.value, this.name);
}
