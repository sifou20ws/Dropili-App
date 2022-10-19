int getIn(bool h1, bool h2, bool h3) {
  int sum = 0;

  sum = h1 ? sum + 1 : sum;
  sum = h2 ? sum + 1 : sum;
  sum = h3 ? sum + 1 : sum;
  return sum;
}

int getInlis(List<bool> h) {
  int sum = 0;

  h.forEach((element) {
    sum = element ? sum + 1 : sum;
  });

  return sum;
}
