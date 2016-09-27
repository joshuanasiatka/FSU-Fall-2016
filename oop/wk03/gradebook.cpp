/*
 * Gradebook.cpp
 *
 * Using classes, handle students, their information, and their scores, and organize
 * that information in a tabular format, sortable and everything. Store that information
 * in a gradebook.txt file. Upon re-executing the program, import the information
 * from that text file.
 *
 * Version: 2016.09.27.1
 *
 * TO-DO:
 * - Select Student
 * - Add Grade
 * - Average Grades
 * - Print Student Report (full details, grades, average)
 * - Delete Student
 *
 * Copyright (C) 2016 Joshua Nasiatka.
 *--------------------------------------------------------------------------------------
 */

#include<iostream>
#include<string>
#include<fstream>
#include<sstream>
#include<vector>

using namespace std;

//Typedefs
//typedef vector<Student> students;
vector<string> split(const string &s, char delim);
void split(const string &s, char delim, vector<string> &elems);
void printInfo();

class Student {
public:
  string fname;     // First Name
  string lname;     // Last Name
  string hometown;  // Hometown
  string homestate; // State
  int age;          // Age
  double avg_grade; // Average Grade

  void publish() {
    ofstream gradebook;
    gradebook.open("gradebook.txt", ios::out | ios::app );
    gradebook << fname << "," << lname << "," << hometown << "," << homestate << "," << age << "," << avg_grade << endl;
    gradebook.close();
  }

  void printInfo() {
    cout << fname << "\t" << lname << "\t" << hometown << "\t" << homestate << "\t" << age << "\t" << avg_grade << endl;
  }
};

class GradeManager {
public:
  void menu() {
    cout << "--- MENU ---" << endl;
    cout << "[1] List Students" << endl;
    cout << "[2] Add Student" << endl;
    cout << "[3] Open GradeBook" << endl;
    cout << "[4] Save to File" << endl;
    cout << "[0] Quit" << endl;
  }
  void parseStudentInfo(string line, Student *s1) {
    char delim = ',';

    vector<string> studentInfo;
    studentInfo = split(line, delim);

    if (line != "") {
      s1->fname = studentInfo[0];
      s1->lname = studentInfo[1];
      s1->hometown = studentInfo[2];
      s1->homestate = studentInfo[3];
      istringstream(studentInfo[4]) >> s1->age;
      istringstream(studentInfo[5]) >> s1->avg_grade;
    }
  }
};

int main() {
  vector<Student> students;

  GradeManager GradeManager;

  int running = 1, choice;

  printInfo();

  while (running != 0) {
    GradeManager.menu();
    cout << "Choice? ";
    cin >> choice;
    cout << endl;

    if (choice == 1) {
      if (students.size() < 1) {
        cout << "Sorry. No records found." << endl;
      } else {
        cout << "First\tLast\tTown\tState\tAge\tAvgGrade" << endl;
        for (int j = 0; j < students.size(); j++) {
          students[j].printInfo();
        }
      }
    } else if (choice == 2) {
      // Add Student
      cout << "ADD STUDENT" << endl;
      cout << "-----------" << endl;
      Student s1;
      cout << "First Name: ";
      cin >> s1.fname;
      cout << "Last Name: ";
      cin >> s1.lname;
      cout << "Hometown: ";
      cin >> s1.hometown;
      cout << "Homestate: ";
      cin >> s1.homestate;
      cout << "Age: ";
      cin >> s1.age;
      cout << "Average Grade: ";
      cin >> s1.avg_grade;
      students.push_back(Student(s1));
      cout << endl << "Successfully added 1 record." << endl;
    } else if (choice == 3) {
      // Import Gradebook
      cout << "Importing gradebook from file..." << endl;
      students.clear();
      ifstream oldGradebook("gradebook.txt");
      string skip, line;
      getline(oldGradebook, skip);
      while (getline(oldGradebook, line)) {
        Student s1;
        GradeManager.parseStudentInfo(line, &s1);
        students.push_back(Student(s1));
      }
      oldGradebook.close();
      cout << "Imported " << students.size() << " record(s)." << endl;
    } else if (choice == 4) {
      cout << "Saving Gradebook" << endl;
      const int studentCount = students.size();

      ofstream newGradebook;
      newGradebook.open("gradebook.txt");
      newGradebook << "fname,lname,hometown,homestate,age,avg_grade" << endl;
      newGradebook.close();

      for (int i = 0; i < studentCount; i++) {
        students[i].publish();
      }
    } else if (choice == 0) {
      cout << "Do you want to save? [y/n] ";
      char j;
      cin >> j;
      if ((j == 'n') || (j == 'N'))
        running = 0;
    } else {
      cout << "Invalid menu item." << endl;
    }
    cout << endl;
  }

  return 0;
}

void printInfo() {
  cout << "----------------------" << endl;
  cout << "GradeBook Manager" << endl;
  cout << "Updated 2016.09.27" << endl;
  cout << "Joshua Nasiatka" << endl;
  cout << "----------------------" << endl;
  cout << endl;
}

// From: http://stackoverflow.com/questions/236129/split-a-string-in-c
void split(const string &s, char delim, vector<string> &elems) {
    stringstream ss;
    ss.str(s);
    string item;
    while (getline(ss, item, delim)) {
        elems.push_back(item);
    }
}

vector<string> split(const string &s, char delim) {
    vector<string> elems;
    split(s, delim, elems);
    return elems;
}
// End
