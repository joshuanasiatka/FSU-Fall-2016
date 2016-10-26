/*
 * Skater_2.cpp
 *
 * Using the theme of figure skaters, store skater information and scores
 * in a linked list (currently using arrays).
 *
 * Version: 2016.10.25.1
 *
 * Completed:
 * - Make the given code function
 * - File read/write error handling
 * - Console output for debugging
 *
 * In Progress:
 * - Convert to linked-list
 *
 * TO-DO:
 * - Allow for any number of scores
 *
 * Copyright (C) 2016 Joshua Nasiatka.
 *--------------------------------------------------------------------------------------
 */

#include<iostream>
#include<fstream>
#include<string>
using namespace std;

const int max_number_skaters = 7;

class Skater {
    public:
        char first_name[15];  // Max first/last name char count is 15+1
        char last_name[15];
        double avg;
        double scores[10];
        void get_data(ifstream& instream);
        void print_data(ofstream& outstream);
};

class Node {
    public:
        Skater next;
        Skater prev;
};

void sort_data(Skater array[], int number_of_skaters);

int main() {
    Node head, tail;
    Skater competitor[max_number_skaters];
    ifstream instream;
    ofstream outstream;
    int number_of_skaters=0;

    cout << endl;
    cout << "Opening in/out files...\t\t\t";

    instream.open("infile.txt");
    outstream.open("outfile.txt");
    if (instream != 1) {
        cout << "[FAIL]" << endl;
        cout << "[FATAL ERROR] Input file not found." << endl;
        exit(-1);
    } else if (outstream != 1) {
        cout << "[FAIL]" << endl;
        cout << "[FATAL ERROR] Unable to open file for writing." << endl;
        exit(-1);
    } else {
        cout << "[DONE]" << endl;
    }

    cout << "Retrieving data..." << endl;
    for (int j=0; j < max_number_skaters &&!instream.eof(); j++) {   // For each line in file until EOF
        competitor[j].get_data(instream);                            //   get skater data and put in competitor array,
        number_of_skaters++;                                         //   increment skater count
    }
    cout<<endl;
    cout << "Importing " << number_of_skaters << " skater(s)...\t\t";
    cout << "[DONE]" << endl;

    cout << "Sorting skaters by average score...\t";
    sort_data(competitor,  number_of_skaters);                       // Call sort function to sort by average score
    cout << "[DONE]" << endl;

    cout << "Writing results to file...\t\t";
    outstream << "Figure Skating Competition Results" << endl;
    outstream << "---------------------------------- \n";

    for(int i=0; i < number_of_skaters; i++) {                       // For each skater
        outstream << "  " << i + 1 << "    ";                        //   write the rank to file,
        competitor[i].print_data(outstream);                         //   then write the average to file via
    }                                                                //   competitor.print_data
    cout << "[DONE]" << endl;
    cout << endl;
    cout << "Results located at .\\outfile.txt" << endl;
    //print_data(competitor, number_of_skaters,  outstream);
    return 0;
}

void Skater::get_data(ifstream& instream) {
    double total = 0;
    double max   = 0;
    double min   = 6.0;               // Need to init the min as 6 as that is the highest score

    instream >> first_name;           // Parses first item in line as first name
    cout << first_name << " ";
    instream >> last_name;            // Parses the second as last name
    cout << last_name << endl;

    for(int j=0; j < 10; j++) {       // Currently the program only supports max of 10 scores
        instream >> scores[j];        // Read in the next score to an array of scores
        // cout<<scores[j]<<" ";
        if(scores[j] > max)           // Trying to find the max score, if greater than max,
            max = scores[j];          //   it is now the max
        if(scores[j] < min)           // Also trying to find the smallest score, if smaller than min,
            min = scores[j];          //   make it the new minimum
        total = total+scores[j];      // Add to the sum of all scores.
    }
    avg = (total - (min + max)) / 8;  // Calculate the average by taking the sum minus the range
    // cout<<avg<<" ";                //   over total scores which in the case of our infile is only 8
}

void sort_data(Skater array[], int number_of_skaters) {  // Bubble sort the skaters by average score
    for(int j=0; j < number_of_skaters-1; j++) {
        for(int i=0; i < number_of_skaters-1; i++) {
            if (array[i].avg < array[i+1].avg) {
                Skater temp = array[i];
                array[i] = array[i+1];
                array[i+1] = temp;
            }
        }
    }
}

void Skater::print_data(ofstream& outstream) {
    int interval = 20 - (strlen(first_name) + strlen(last_name));
    outstream.setf(ios::fixed);             // Fancy function to write a specific amount
    outstream.setf(ios::showpoint);         //    spaces per the length of the names
    outstream.precision(2);                 //    so that every column aligns properly
    outstream << first_name << " " << last_name;
    for(int k=0; k < interval; k++)
        outstream << " ";
    outstream << avg << endl;
}
