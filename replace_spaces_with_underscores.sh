#!/bin/bash
# Goes through all the files in the current directory and replaces the spaces in the filenames with underscores (aka "a sample file.txt" to "a_sample_file.txt").

# Go through each file in the current directory
for file in *
do
	# Take out some characters I don't want in filename just in case they cause problems with filesystems or commands or whatever.
	new_filename=`echo $file | tr -d "\'\",()"`

	# Replace some special case strings with appropriate strings in the filename
	new_filename=${new_filename// -/-}
	new_filename=${new_filename//- /-}
	new_filename=${new_filename// _/_}
	new_filename=${new_filename//_ /_}

	# Replace spaces with underscores in the filename
	new_filename=`echo $new_filename | tr [:blank:] '_'`

	# Rename the file
	if [ "$file" = "$new_filename" ]; then
		echo "\"$file\" doesn't have spaces in the filename, ignoring it."
	elif test -e "$new_filename"; then
		echo "\"$new_filename\" already exists, ignoring \"$file\"."
	elif test -f "$file"; then # Using "test -f" to check if file is a regular file or not.
		# File is a regular file with spaces if this code is hit. In the future you may want to do something different with regular files.
		echo "Renaming regular file \"$file\" to \"$new_filename\"."
		mv "$file" $new_filename
	else
		# File is a non-regular file with spaces, like a directory or a device, if this code is hit. In the future you may want to do something different with non-regular files.
		echo "Renaming non-regular file \"$file\" to \"$new_filename\"."
		mv "$file" $new_filename
	fi
done
