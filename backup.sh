#!/bin/bash

echo "Creating backup of $1"

backup_dir="$1-$(date +'%m-%d-%Y')"

cp -r $1 $backup_dir

rm -rf $backup_dir/.git*
rm -rf $backup_dir/.vs

rm -rf $backup_dir/api/node_modules
rm -rf $backup_dir/api/.env

rm -rf $backup_dir/app/node_modules
rm -rf $backup_dir/app/.env

#zip_file_name="$(basename -- $backup_dir).zip"
zip_file_name="$2.zip"

zip -9 -y -r -q $zip_file_name $backup_dir

echo "Created ZIP: $zip_file_name"
rm -rf $backup_dir
