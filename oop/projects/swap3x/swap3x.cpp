/**
  * @project Swap Three Characters
  * @version 1.0
  * @author  Joshua Nasiatka
  * @date    Sept 08 2016
  */

#include<iostream>

using namespace std;

template<class T>
void swap(T&x, T&y, T&z);

int main() {
  char i,j,k;

  // Take input for variable i
  cout << "Enter a character for i: ";
  cin >> i;
  cout << endl;

  // Take input for variable j
  cout << "Enter a character for j: ";
  cin >> j;
  cout << endl;

  // Take input for variable k
  cout << "Enter a character for k: ";
  cin >> k;
  cout << endl;

  cout << i << " " << j << " " << k << endl;
  swap(i,j,k);
  cout << i << " " << j << " " << k << endl;

  return 0;
}

template<class T>
void swap(T&x, T&y, T&z) {
  T temp;

  temp = z;
  z = y;
  y = x;
  x = temp;
}
