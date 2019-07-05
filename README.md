OceanView2Excel and Process Ver.8 2019.7.4

Chengxin Yu

chy220@lehigh.edu

Run the main.m to proceed.

This package can be used to automate the process of copying data from Ocean View to 
Excel and finish data calculation due to specific purpose and then write to the xlsx file.

The program stores the raw measurement data in the 'rawFile' directory,
and the later processed sheet in the 'processFile' directory.

Users are not required to create the folders or the xlsx file beforehand, 
and are highly suggested not to do so. They should process as guided in the main program.

Users can choose to record data first and process later, or process immediately once they 
run the program.

In the 'rawFile(sample)', I leave the sample 'data.xlsx' for users to copy data to stimulate
the process of copying data from Ocean View.
In the 'processFile(sample)' is the expected output.

For testing purpose, main.m only includes current set of 0, 40 and 45 mA. To run the program
in real experiment measurement, users are required to uncomment the full current set, and 
comment out the testing set.
