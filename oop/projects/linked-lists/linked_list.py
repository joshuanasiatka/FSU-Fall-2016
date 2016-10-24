#! /usr/bin/env python

"""
 linked_list.py

 Author: Joshua Nasiatka (2016)
 Description: Create and modify a singly linked list in Python
 Version: 2016.10.22.1

 TO-DO:
 - Delete specific node
 - Insert at positon
 - Find in list
"""

class node:
    def __init__(self, data = None, next = None):
        self.data = data # this contain the node data
        self.next = None # this is the referende to the next node
    def __str__(self):
        return '[' + str(self.data) + ']'

class linked_list:
    def __init__(self):
        self.head = None    # create the head reference
        self.tail = None    # create the tail reference

    def insert_node(self, data):
        if self.head == None:               # if no head, then
            self.head = node(data, None)    #   set the new node as the head
            self.tail = self.head           #   and set self as tail
        elif self.tail == self.head:        # else if tail is currently head, then
            self.tail = node(data, None)    #   set the new node as the tail
            self.head.next = self.tail      #   and set head->next to self->tail
        else:                               # else
            current_node = node(data, None) #   set current_node to the data
            self.tail.next = current_node   #   create reference to the new tail
            self.tail = current_node        #   move the tail reference to the bottom

    def output_list(self):
        if self.head is not None:
           node = self.head
           while node.next is not None: # while next node is not null
               print(node, "=>", end=" ")
               node = node.next
           print(self.tail,"\n")
        else:
            print ("List is empty")

    def empty(self):
        self.__init__()

# Some test cases
print("\n====================\nSINGLY LINKED LIST\n====================")
print("Initializing new list...         ", end="")
list1 = linked_list()
print("[DONE]")
print("Adding some nodes...             ", end="")
list1.insert_node(3)
list1.insert_node("these")
list1.insert_node("are")
list1.insert_node("nodes")
list1.insert_node(4)
list1.insert_node(5)
list1.insert_node(3.14159265358979)
print("[DONE]")
print("\nPrinting linked list references:")
list1.output_list()
print("Emptying list...                 ", end="")
list1.empty()
print("[DONE]")
list1.output_list()
