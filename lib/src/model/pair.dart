class Pair<K, V> {
  final K i;
  final V j;

  Pair(this.i, this.j);

  K first() => i;
  V second() => j;
}
