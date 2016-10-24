#include<iostream>
#include<fstream>
#include<string>
using namespace std;
const int  max_number_skaters=6;

class Skater
{
public:
    char first_name[15];
    char last_name[15];
    double avg;
    double scores[10];
    void get_data( ifstream& instream);
    void print_data(ofstream& outstream);


};


void sort_data(Skater array[], int number_of_skaters);



int main()
{
    Skater competitor[max_number_skaters];
    ifstream instream;
    ofstream outstream;
    int number_of_skaters=0;

    instream.open("infile.txt");
    outstream.open("outfile.txt");

    for (int j=0; j <max_number_skaters &&!instream.eof(); j++)
    {

        competitor[?].get_data(?);
        number_of_skaters++;


    }
    cout<<endl;
    //cout<<"number_of_skaters is "<<number_of_skaters<<endl;





    sort_data(competitor,  number_of_skaters);

    outstream<<"         Figure Skating Competition Results"<<endl;
    outstream<<"         ---------------------------------- \n";

    for(int i=0; i<number_of_skaters; i++)
    {
        outstream<<"  "<<i+1<<"    ";
        competitor[?].print_data(?);
    }
    //print_data(competitor, number_of_skaters,  outstream);
    return 0;
}

void Skater::get_data( ifstream& instream)
{

        double total=0;
        double max=0;
        double min=6.0;

        instream>>first_name;
        //cout<<first_name<<endl;
        instream>>last_name;
    //    cout<<last_name<<endl;

        for(int j=0; j<10; j++)
        {

            instream>>scores[j];
            //cout<<scores[j]<<" ";
            if(scores[j]>max)
                max=scores[j];
            if(scores[j]<min)
                min=scores[j];
            total=total+scores[j];

        }
        avg=(total-(min+max))/8;
        //cout<<avg<<" ";






}

void sort_data(Skater array[], int number_of_skaters)
{
    for(int j=0; j<number_of_skaters-1; j++)
    {
        for(int i=0; i<number_of_skaters-1; i++)
        {
            if (array[i].avg<array[i+1].avg)
            {
                Skater temp=array[i];
                array[i]=array[i+1];
                array[i+1]=temp;
            }

        }
    }


}

void Skater::print_data(ofstream& outstream)
{

    int interval=20-(strlen(first_name)+strlen(last_name));


        //outstream<<endl;
        outstream.setf(ios::fixed);
        outstream.setf(ios::showpoint);
        outstream.precision(2);

        //outstream<<"  "<<i+1<<"    ";
        outstream<<first_name<<" "<<last_name;
        for(int k=0; k<interval; k++)
        outstream<<" ";
        outstream<<avg<<endl;


}
