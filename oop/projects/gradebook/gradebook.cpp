/*
 * Gradebook.cpp
 *
 * Using classes, handle students, their information, and their scores, and organize
 * that information in a tabular format, sortable and everything. Store that information
 * in a gradebook.txt file. Upon re-executing the program, import the information
 * from that text file.
 *
 * Version: 2016.10.12.1
 *
 * TO-DO:
 * - Select Student [done]
 * - Add Grade [done]
 * - Average Grades [done]
 * - Print Student Report (full details, grades, average) [done]
 * - Delete Student
 * - Delete Grade
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
vector<string> split(const string &s, char delim);
void printCol(string x);
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
  vector<int> grades; // Grades

  void listGrades();
  void report();
  void publish();
  void pubGrades(ofstream &gradebook);
  void printReportMenu();
  void printInfo();
  void addGrade();
  void removeGrade();
  double getAvg(vector<int> avg);
};

void saveGradebook(vector<Student> students);

class GradeManager {
public:
  void menu() {
    cout << "--- MENU ---" << endl;
    cout << "[1] List Students" << endl;
    cout << "[2] Student Report" << endl;
    cout << "[3] Add Student" << endl;
    cout << "[4] Open GradeBook" << endl;
    cout << "[5] Save to File" << endl;
    cout << "[0] Quit" << endl;
  }
  void parseStudentInfo(string line, Student *s1);
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
        cout << "ID\t\tFirst\t\tLast\t\tTown\t\tState\t\tAge\t\tAvgGrade" << endl;
        cout << "--------\t--------\t--------\t--------\t--------\t--------\t--------" << endl;
        for (int j = 0; j < students.size(); j++) {
          cout << j+1 << "\t\t";
          students[j].printInfo();
        }
      }
    } else if (choice == 2) {
      if (students.size() < 1) {
        cout << "Sorry. No records found." << endl;
      } else {
        int i;
        cout << "Enter Student ID: ";
        cin >> i;
        if ((i > students.size()) || (i < 1)) {
          cout << "Student ID does not exist." << endl;
        } else {
          students[i-1].report();
        }
      }
    } else if (choice == 3) {
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
      students.push_back(Student(s1));
      cout << endl << "Successfully added 1 record." << endl;
    } else if (choice == 4) {
      // Import Gradebook
      ifstream oldGradebook("gradebook.txt");
      if (!oldGradebook)
        cout << "No saved gradebooks." << endl;
      else {
        cout << "Importing gradebook from file..." << endl;
        students.clear();
        string skip, line;
        getline(oldGradebook, skip);
        while (getline(oldGradebook, line)) {
          Student s1;
          GradeManager.parseStudentInfo(line, &s1);
          students.push_back(Student(s1));
        }
        oldGradebook.close();
        cout << "Imported " << students.size() << " record(s)." << endl;
      }
    } else if (choice == 5) {
      saveGradebook(students);
    } else if (choice == 0) {
      cout << "Do you want to save? [Y/n] ";
      char j;
      cin >> j;
      if ((j == 'n') || (j == 'N'))
        running = 0;
      else if ((j == 'y') || (j == 'Y')) {
        saveGradebook(students);
        running = 0;
      }
      else {
        cout << "Invalid option, using default" << endl;
        saveGradebook(students);
        running = 0;
      }
    } else {
      cout << "Invalid menu item." << endl;
    }
    cout << endl;
  }

  return 0;
}

// STUDENT CLASS FUNCTIONS
void Student::report() {
  cout << "First Name:    " << fname << endl;
  cout << "Last Name:     " << lname << endl;
  cout << "Hometown:      " << hometown << endl;
  cout << "State:         " << homestate << endl;
  cout << "Age:           " << age << endl;
  cout << "Average Grade: " << getAvg(grades) << endl;
  cout << "\n---------------\nLIST OF GRADES\n---------------" << endl;
  listGrades();

  char g;

  while (g != '#') {
    printReportMenu();
    cout << "Choice? ";
    cin >> g;
    if (g == '1')       // Add a grade
      addGrade();
    else if (g == '2')  // Remove a grade
      removeGrade();
    else if (g != '#')
      cout << "Invalid menu entry." << endl;
  }
}

void Student::listGrades() {
  const int grade_count = grades.size();
  if (grade_count > 0) {
    for (int j=0; j < grade_count-1; j++) {
      cout << "Grade " << j+1 << ": " << grades[j] << endl;
    }
    cout << "Grade " << grade_count << ": " << grades[grade_count-1] << endl;
    cout << endl;
  } else {
    cout << "No grades recorded.\n" << endl;
  }
}

void Student::printReportMenu() {
  cout << "--- MENU ---\n" << endl;
  cout << "[1] Add a grade" << endl;
  cout << "[2] Remove a grade" << endl;
  cout << "[#] Back\n" << endl;
}

void Student::publish() {
  ofstream gradebook;
  gradebook.open("gradebook.txt", ios::out | ios::app );
  // double avg = 0;
  // avg += avg_grade;
  gradebook << fname << "," << lname << "," << hometown << "," << homestate << "," << age << "," << avg_grade << ",";
  Student::pubGrades(gradebook);
  gradebook << endl;
  gradebook.close();
}

void Student::pubGrades(ofstream &gradebook) {
  const int grade_count = grades.size();
  if (grade_count > 0) {
    for (int j=0; j < grade_count-1; j++) {
      gradebook << grades[j] << ",";
    }
    gradebook << grades[grade_count-1];
  }
}

void Student::printInfo() {
  printCol(fname);
  printCol(lname);
  printCol(hometown);
  printCol(homestate);
  cout << age << "\t\t" << getAvg(grades) << endl;
}

void Student::addGrade() {
  string g;
  cout << "\nType '#' to quit\n" << endl;
  while (g != "#") {
    cout << "Enter Grade: ";
    cin >> g;
    if (g != "#")
      grades.push_back(stoi(g));
  }
  cout << "Task completed." << endl;
  avg_grade = getAvg(grades);
  cout << "\nNew Average: " << avg_grade << endl;
}

void Student::removeGrade() {
  int index, grade_count=grades.size();
  listGrades();
  if (grade_count > 0) {
    cout << "Which grade would you like to remove? ";
    cin >> index;
    grades.erase(grades.begin() + index - 1);
    cout << "\nGrade removed.\n" << endl;
    listGrades();
  } else {
    cout << "\nNo grades to remove.\n" << endl;
  }
}

double Student::getAvg(vector<int> avg) {
  double average,sum=0;
  const double grade_count=avg.size();
  for (int i=0; i < grade_count; i++) {
    sum+=avg[i];
  }
  average=sum/grade_count;
  return average;
}

// GRADE MANAGER CLASS FUNCTIONS
void GradeManager::parseStudentInfo(string line, Student *s1) {
  char delim = ',';
  int gradeCount = 0;

  vector<string> studentInfo;
  vector<int> grades;
  studentInfo = split(line, delim);

  if (line != "") {
    gradeCount = studentInfo.size()-6;
    s1->fname = studentInfo[0];
    s1->lname = studentInfo[1];
    s1->hometown = studentInfo[2];
    s1->homestate = studentInfo[3];
    istringstream(studentInfo[4]) >> s1->age;
    istringstream(studentInfo[5]) >> s1->avg_grade;
    for (int i = 6; i < studentInfo.size(); i++) {
      grades.push_back(stoi(studentInfo[i]));
    }
    if (gradeCount > 0) {
      s1->grades = grades;
      s1->avg_grade = s1->getAvg(grades);
    }
  }
}

// GLOBAL FUNCTIONS
void printInfo() {
  cout << "----------------------" << endl;
  cout << "GradeBook Manager" << endl;
  cout << "Updated 2016.09.27" << endl;
  cout << "Joshua Nasiatka" << endl;
  cout << "----------------------" << endl;
  cout << endl;
}

void saveGradebook(vector<Student> students) {
  cout << "Saving Gradebook" << endl;
  const int studentCount = students.size();

  ofstream newGradebook;
  newGradebook.open("gradebook.txt");
  newGradebook << "fname,lname,hometown,homestate,age,avg_grade" << endl;
  newGradebook.close();

  for (int i = 0; i < studentCount; i++) {
    students[i].publish();
  }
}

void printCol(string x) {
  if (((7 >= x.length()) && (x.length() >= 4)) || (x.length() == 2)) {
    cout << x << "\t\t";
  } else {
    cout << x << "\t";
  }
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
