#! /usr/bin/env python

"""
 gradebook.py

 Author: Joshua Nasiatka (2016)
 Description: Using classes, handle students, their information, and their scores, and organize
    that information in a tabular format, sortable and everything. Store that information in a
    gradebook.csv file. Upon re-executing the program, import the information from that csv file.
 Version: 2016.11.02.1

 TO-DO:
 - Adding grades
 - Student reporting
 - Sorting records
 - Delete specific student
 - Insert at positon
 - File manipulation
"""

class node:
    def __init__(self, fname, lname, hometown, homestate, age, next = None):
        self.next = None # this is the referende to the next node
        self.fname = fname
        self.lname = lname
        self.hometown = hometown
        self.homestate = homestate
        self.age = age
        self.avg_grade = 0.0
        grades = linked_list()

    def __str__(self):
        return str(self.fname) + ' ' + str(self.lname)

class linked_list:
    def __init__(self):
        self.head = None    # create the head reference
        self.tail = None    # create the tail reference

    def insert_node(self, fname, lname, hometown, homestate, age):
        if self.head == None:               # if no head, then
            self.head = node(fname, lname, hometown, homestate, age, None)    #   set the new node as the head
            self.tail = self.head           #   and set self as tail
        elif self.tail == self.head:        # else if tail is currently head, then
            self.tail = node(fname, lname, hometown, homestate, age, None)    #   set the new node as the tail
            self.head.next = self.tail      #   and set head->next to self->tail
        else:                               # else
            current_node = node(fname, lname, hometown, homestate, age, None) #   set current_node to the data
            self.tail.next = current_node   #   create reference to the new tail
            self.tail = current_node        #   move the tail reference to the bottom

    def output_list(self):
        print("\nPrinting list of students:")
        if self.head is not None:
           node = self.head
           index = 0
           while node.next is not None: # while next node is not null
               print(str(index), " => ", node)
               node = node.next
               index+=1
           print(str(index), " => ", self.tail)
        else:
            print ("List is empty")

    def empty(self):
        sure = input("\n** There is NO UNDO! **\nAre you sure you want to shred records? yes/no ")
        if sure.lower() == "yes":
            self.__init__()
            print("Gradebook emptied.")
        else:
            print("Aborting.")

class GradeManager:
    def __init__(self):
        print("----------------------")
        print("GradeBook Manager")
        print("Updated 2016.11.02")
        print("Joshua Nasiatka")
        print("----------------------")

    def menu(self):
        print("\n--- MENU ---")
        print("[1] List Students")
        print("[2] Student Report")
        print("[3] Add Student")
        print("[4] Open GradeBook")
        print("[5] Save to File")
        print("[6] Obliterate Records")
        print("[0] Quit")
        return int(input("Choice? "))

    def add_students(self, gradebook):
        fname = input("First Name: ")
        lname = input("Last Name: ")
        hometown = input("Hometown: ")
        homestate = input("Homestate: ")
        age = int(input("Age: "))
        gradebook.insert_node(fname,lname,hometown,homestate,age)
        cont = input("\nContinue? Y/n ")
        if cont.lower() == "y":
            self.add_students(gradebook)

def main():
    gmanager = GradeManager()
    gradebook = linked_list()
    running = "Y"
    opt = gmanager.menu()

    while running.lower() != "n":
        if opt == 1:
            gradebook.output_list()
        elif opt == 3:
            print("\n**************\n ADD STUDENTS\n**************")
            gmanager.add_students(gradebook)
        elif opt == 2 or opt == 4 or opt == 5:
            print("\n********************\nFUNCTION UNAVAILABLE\n********************")
        elif opt == 6:
            gradebook.empty()
        elif opt == 0:
            running = "n"
        else:
            print("INVALID OPTION")
        if running.lower() != "n":
            opt = gmanager.menu()

main()
