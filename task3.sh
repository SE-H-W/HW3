# Headers
echo "PassengerId,Survived,Pclass,Name,Sex,Age,SibSp,Parch,Ticket,Fare,Cabin,Embarked" > temp_filtered.csv

# Task a and b: Extract passengers from 2nd class (Pclass = 2) and embarked from Southampton (Embarked = S)
gawk -F',' '$3 == 2 && ($13 ~ /S/)' titanic.csv | \
sed -e 's/female/F/g' -e 's/male/M/g' >> temp_filtered.csv

# Print the Name, Gender, and Age 
echo "Passengers from 2nd class and embarked from Southampton:"
gawk -F',' 'NR > 1 {
    print "Name: " $4 ", Gender: " $6 ", Age: " $7
}' temp_filtered.csv

# Task c: Calculate the average age 
echo ""
echo "Calculating the average age"
gawk -F',' 'NR > 1 {
    # Skip rows with blank or non-numeric age
    if ($7 != "" && $7 ~ /^[0-9]+(\.[0-9]+)?$/) {
        sum += $7; count++
    }
}
END {
    if (count > 0) {
        print "Total count: " count
        print "Sum of ages: " sum
        print "Average age: " sum/count
    } else {
        print "No valid age data"
    }
}' temp_filtered.csv
