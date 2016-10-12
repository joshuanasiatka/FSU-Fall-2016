#include<iostream>
#include<vector>
using namespace std;

//Typedefs
typedef vector<char> row;
typedef vector<row> matrix;
void printlcs(matrix B, vector<char> X, int i, int j);
void print_vector(vector<char> X, char which);

int main() {
  vector<char> X(1,'0');
  vector<char> Y(1,'0');
  char next;
  matrix B;
  matrix C;

  cout << "Enter your first sequence. Type # when you are done." << endl;
  do {
    cin >> next;
    if (next != '#')
      X.push_back(next);
  } while (next != '#');

  cout << "Enter your second sequence. Type # when you are done." << endl;
  do {
    cin >> next;
    if (next != '#')
      Y.push_back(next);
  } while (next != '#');

  //Getting sizes of vectors
  const int rowcount = Y.size();
  const int colcount = X.size();

  //Debugging Output
  cout << endl;
  print_vector(X,'X');
  print_vector(Y,'Y');
  cout << endl;

  //Creating the matrix
  B.resize(rowcount);
  for (int j = 0; j < rowcount; j++)
    B[j].resize(colcount);

  C.resize(rowcount);
  for (int j = 0; j < rowcount; j++)
    C[j].resize(colcount);

  //Fill matrices with 0s in every cell in first row of both matrices
  for (int j = 0; j < colcount; j++) {
    B[0][j] = '0';
    C[0][j] = '0';
  }

  //Fill matrices with 0s in every cell in the first column
  for (int j = 0; j < rowcount; j++) {
    B[j][0] = '0';
    C[j][0] = '0';
  }

  //Dress matrices with the LCS algorithm
  for(int i = 1; i < rowcount; i++) {
    for(int j = 1; j < colcount; j++) {
      if(X[j]==Y[i]) {
        C[i][j]=C[i-1][j-1]+1;
        B[i][j]='D';
      }

      if(X[j]!=Y[i]) {
        if(C[i-1][j] >= C[i][j-1]) {
          C[i][j]=C[i-1][j];
          B[i][j]='U';
        } else {
          C[i][j]=C[i][j-1];
          B[i][j]='L';
        }
      }
    }
  }

  //Print the matrix
  for(int i = 0; i < rowcount; i++)
    for(int j = 0; j < colcount; j++) {
      if(j != colcount-1) {
        cout << C[i][j] << " ";
      } else {
        cout << C[i][j] << endl;
      }
    }
  cout << endl;
  for(int i = 0; i < rowcount; i++)
    for(int j = 0; j < colcount; j++) {
      if(j != colcount-1) {
        cout << B[i][j] << " ";
      } else {
        cout << B[i][j] << endl;
      }
    }
  cout << endl;

  //Print the Longest Common Subsequence by calling printlcs function
  cout << "Here is your longest subsequence: ";
  printlcs(B, X, rowcount-1, colcount-1);
  cout << endl;

  return 0;
}

void printlcs(matrix B, vector<char> X, int i, int j) {
  if (i == 0 || j == 0)
    return;

  if (B[i][j] == 'D') {
    printlcs(B, X, i-1, j-1);
    cout << X[j];
  }

  if (B[i][j] == 'U')
    printlcs(B, X, i-1, j);

  if (B[i][j] == 'L')
    printlcs(B, X, i, j-1);

}

void print_vector(vector<char> X, char which) {
  //Debugging Output
  cout << "Vector " << which << " is ";
  for (int i = 0; i < X.size(); i++)
    cout << X[i];
  cout << endl;
}
