OceanView2Excel and Process Ver.10.0
2019.7.28

Chengxin Yu

chy220@lehigh.edu



---
This program is specified for the summer research purpose during 2019 in Sinclair Lab, Lehigh University.
It's not guaranteed the program will work elsewhere but it still worth a shot.
Data process follows the specific standard given by the instructors.

---

update Ver. 10

---

New features:

Support the measurement udner low power density.
Bugs fixed.

update Ver. 8.6.2

---
New features:

(some previous upadte information is missing here....)

In Ver. 8.6.2, I add a new option for users to change the wave length range during running the 
program while in the past one needs to terminate the whole program to change the wave length range.
Now, users can type in 'CWR' when the program asks 'Confirm this fft (y/n)?'.

Also it allows users to continuously process files without rerunning the program for each file.

---

update Ver. 8.1 & 8.2

---
New features:

* Allow users to rewrite the data during measurement if they miss or copy the wrong 
data from Ocean View

* Change the filename of processed file from 'processing' to 'processed'
---

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
