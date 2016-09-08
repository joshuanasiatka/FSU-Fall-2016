/**
  * @project BirthdayUnBirthday: Is it your birthday?
  * @version 1.4 - Functional w/ 1 parameter
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
  	void print_output(Date birth);
};

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
	print_output(birth); // what do you pass? Look at function definition

  return 0;
}

void Date::print_output(Date birth) {
  string note;

  // Determine if today is birthday or not
  note = ((today.day == birth.day) && (today.month == birth.month))?"Happy Birthday!":"Happy UnBirthday!";
  cout << note << endl;
}
