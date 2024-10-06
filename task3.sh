# Headers
echo "PassengerId,Survived,Pclass,Name,Sex,Age,SibSp,Parch,Ticket,Fare,Cabin,Embarked" > temp_filtered.csv

# Task a and b: Extract passengers from 2nd class (Pclass = 2) and embarked from Southampton (Embarked = S)
gawk -F',' '$3 == 2 && ($13 ~ /S/)' titanic.csv | \
sed -e 's/female/F/g' -e 's/male/M/g' >> temp_filtered.csv

# Print the filtered passengers (Name, Gender, Age) 
echo "Passengers from 2nd class and female as F and male as M:"
gawk 'BEGIN {FPAT = "([^,]+)|(\"[^\"]+\")"} NR > 1 {
    gsub("\"", "", $4); # Remove quotes around Name field
    print "Name: " $4 ", Gender: " $5 ", Age: " $6
}' temp_filtered.csv

# Task c: Calculate the average age 
echo ""
echo "Calculating the average age of 2nd class passengers"
gawk 'BEGIN {FPAT = "([^,]+)|(\"[^\"]+\")"} NR > 1 && $6 != "" && $6 ~ /^[0-9]+(\.[0-9]+)?$/ {sum += $6; count++} END {if (count > 0) print "Average age: " sum/count; else print "No valid age data"}' temp_filtered.csv

