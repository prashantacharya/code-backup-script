#!/bin/bash

echo "Creating backup of $1"

backup_dir="$1-$(date +'%m-%d-%Y')"

cp -r $1 $backup_dir

delete_misc_dirs() {
  rm -rf $backup_dir/.git*
  rm -rf $backup_dir/.vs
}

recursively_delete_node_modules() {
  echo ""
  echo "****** Deleting node_modules ******"
  find $backup_dir -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \; 
}

recursively_delete_env() {
  echo ""
  echo "****** Deleting .env files ******"
  find $backup_dir -name '.env' -type f -prune -exec echo '{}' \; -exec rm -rf {} \; 
}


# call functions
delete_misc_dirs
recursively_delete_node_modules
recursively_delete_env

#zip_file_name="$(basename -- $backup_dir).zip"
zip_file_name="$2.zip"

zip -9 -y -r -q $zip_file_name $backup_dir

echo "Created ZIP: $zip_file_name"
rm -rf $backup_dir
