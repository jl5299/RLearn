# Data and Variables:
In our final tidy dataset, we have the following variables
TimeBody Acceleration/Jerk/Gyro/Magnitude - for all their mean/std by subject & acitivity
We also have the same data in the frequency domain.

Ultimately, there are 180 unique observations of 68 variables after grouping the data by subject and activity.

The following variables are included in the final output:
Time Body Acceleration Mean
Time Body Acceleration Std
Time Body Jerk Mean
Time Body Jerk Std
Time Body Gyro Mean
Time Body Gyro Std
Time Body Magnitude Mean
Time Body Magnitude Std
Time Gravity Acceleration Mean
Time Gravity Acceleration Std

Frequency Body Acceleration Mean
Frequency Body Acceleration Std
Frequency Body Jerk Mean
Frequency Body Jerk Std
Frequency Body Gyro Mean
Frequency Body Gyro Std
Frequency Body Magnitude Mean
Frequency Body Magnitude Std


# Transformations Performed:
In order to tidy our data, I used tools from the dplyr, plyr libraries. I first pulled the data from the cloudfront html source. Then, going throuch each directory, I leveraged the read.table function to read each relevant file into a data table. Then using dplyr's mutate functionality, I was able to rename columns to organize the data into readable and combinable groups. Finally, using subsets and aggregate, I was able to tidy up the data and take only the used features/activities to find the average per subject and activity data in a final representation of our data.