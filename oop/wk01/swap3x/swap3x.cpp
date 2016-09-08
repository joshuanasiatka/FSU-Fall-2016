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
  int i=3, j=4, k=5;

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
