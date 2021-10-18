# Code Backup Bash Script

The project is a bash script that creates a zip backup of a node project. It deletes `node_modules`, `.git`, `.env`, `.zip`, `.vs`.

### Usage

```shell
bash backup.sh project_directory_name backup_file_name

# Example
bash backup.sh test_folder test
# test.zip will be created
```
![Usage Example](./usage.png "Usage guide")

> Note: If backup file is not supplied, the backup file name will have a default name in the format `project_directory_name-date.zip`
