/**
  * @project BirthdayUnBirthday: Is it your birthday?
  * @version 1.3 - Functional w/ 2 parameters outside class
  * @author  Joshua Nasiatka
  * @date    Sept 08 2016
  */

#include<iostream>
#include<string>

using namespace std;

class Date {
  public:
  	int day;
  	int month;
};

void print_output(Date today, Date birth);
int main() {
	Date today, birth;

  cout << "Enter each value as the number representation (e.g. August 3rd is 08 amd 03)" << endl << endl;

  // Prompt for today's day
  cout << "Enter today's day: ";
  cin >> today.day;

  // Prompt for today's month
  cout << "Enter today's month: ";
  cin >> today.month;

  // Prompt for birthdate day
  cout << "Enter birthdate day: ";
  cin >> birth.day;

  // Prompt for birthdate month
  cout << "Enter birthdate month: ";
  cin >> birth.month;

  // Call print output function which determines if birthday or not
	print_output(today, birth);

  return 0;
}

void print_output(Date today, Date birth) {
  string note;

  // Determine if today is birthday or not
  note = ((today.day == birth.day) && (today.month == birth.month))?"Happy Birthday!":"Happy UnBirthday!";
  cout << note << endl;
}
