const foo = '';

void misbehave() {
  try {
    foo = '1';
  } catch (e) {
    print(2);
    rethrow;
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print(3);
  }
}