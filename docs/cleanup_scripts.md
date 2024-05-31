# Scripts for cleaning temporary files and others cleaning tasks  

## directory_size_cleanup.sh
This script check if the file size directory is greater than limit size, if it's true, delete its content.
The script needs two parameters:

 - The first parameter is the full directory path
 - The second parameter is the directory limit size in bytes allowed

### Example
`foo@bar:~$ ./directory_size_cleanup.sh /tmp/directory_to_check 15000000` 


# delete_temp_files.sh
# other_cleanup_script.sh
