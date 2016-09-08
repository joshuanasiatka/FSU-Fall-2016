/**
  * @project BirthdayUnBirthday: Is it your birthday?
  * @version 1.1 - Not Object-Oriented
  * @author  Joshua Nasiatka
  * @date    Sept 08 2016
  */

#include<iostream>
#include<string>

using namespace std;

int main() {
  int today_day, today_month, birth_day, birth_month;
  string note;

  cout << "Enter each value as the number representation (e.g. August 3rd is 08 amd 03)" << endl << endl;

  // Prompt for today's day
	cout << "Enter today's day: ";
	cin >> today_day;

  // Prompt for today's month
  cout << "Enter today's month: ";
	cin >> today_month;

  // Prompt for birthdate day
  cout << "Enter birthdate day: ";
	cin >> birth_day;

  // Prompt for birthdate month
  cout << "Enter birthdate month: ";
	cin >> birth_month;

  // Determine if today is birthday or not
  note = ((today_day == birth_day) && (today_month == birth_month))?"Happy Birthday!":"Happy UnBirthday!";
  cout << note << endl;

  return 0;
}
