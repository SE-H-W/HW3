#!/bin/bash

# Step 1: Find files containing "sample" and at least 3 occurrences of "CSC510"
echo "a: Files containing 'sample' and at least 3 occurrences of 'CSC510':"
grep -rl "sample" dataset1/ | while read file; do
    count=$(grep -o "CSC510" "$file" | wc -l)
    if [ "$count" -ge 3 ]; then
        echo "$file $count"
    fi
done | sort -k2,2nr -k1 | tee temp_files.txt

# Step b: Sorting files by occurrence of 'CSC510' and breaking ties by file size
echo
echo "b: Sorting files by occurrence of 'CSC510' and breaking ties by file size:"
gawk '{
    # Use stat to get file size and print it along with the file and count
    cmd = "stat -f%z " $1
    cmd | getline size
    close(cmd)
    print $0, size
}' temp_files.txt | sort -k2,2nr -k3,3nr | tee sorted_files.txt


echo
echo "c: Renaming files"
cat sorted_files.txt | while read file count size; do
    newfile=$(echo "$file" | sed 's/file_/filtered_/')
    echo "$newfile"
done
