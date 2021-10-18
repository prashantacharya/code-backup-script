#!/bin/bash

if [ -z "$1" ]
  then
    echo "Error: Directory not specified"
    exit
fi

if [ ! -d "/path/to/dir" ] 
  then
    echo "Error: Directory '$1' does not exists."
    exit
fi

echo "Creating backup of $1"

# Copy the source directory in a backup directory
backup_dir="$1-$(date +'%m-%d-%Y')"
cp -r $1 $backup_dir

# Delete miscellaneous directories like .git and .vs
delete_misc_dirs() {
  rm -rf $backup_dir/.git*
  rm -rf $backup_dir/.vs
}

# Delete all node_modules
recursively_delete_node_modules() {
  echo ""
  echo "****** Deleting node_modules ******"
  find $backup_dir -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \; 
}

# Delete .env files if present 
recursively_delete_env() {
  echo ""
  echo "****** Deleting .env files ******"
  find $backup_dir -name '.env' -type f -prune -exec echo '{}' \; -exec rm -rf {} \; 
}


# call functions
delete_misc_dirs
recursively_delete_node_modules
recursively_delete_env

# if backup file name is not supplied
# set default value (dirname-date.zip)
if [ -z "$2" ]
  then
    zip_file_name="$(basename -- $backup_dir).zip"
  else 
    zip_file_name="$2.zip"
fi

# Create zip file and delete backup directory
zip -9 -y -r -q $zip_file_name $backup_dir
rm -rf $backup_dir

echo ""
echo "Created ZIP: $zip_file_name"
