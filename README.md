# PSUGymWatcher
This is a Swift based iOS application built in xCode
The main function of this application is to display the current amount of people in each gym at Penn State University Park
  - It currently displays a random population due to Penn State not giving permission 
    to me to use the counterAPI after I asked.
  - The old JSON parsing code is still in the application but it is commented out

The application also has a refresh rate limiter to prevent server load issues

The last page displays the a table of the hours of each gym on campus

The settings page allows people to reorganize the list of gyms and how they are displayed. It also allows people to disable
the pop up alerts to tell people they must wait to update the numbers, but they populations will no update
