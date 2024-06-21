#!/bin/bash

repo_url="https://github.com/siddhaantkadu/devops-pocs.git"
branch="main"  
file_extension=".json"  

git clone --single-branch --branch "$branch" "$repo_url" temp_repo


cd temp_repo

# Find the latest JSON file in the repository
latest_json_file=$(git ls-tree -r --name-only HEAD | grep "\.json$" | sort | tail -n 1)

# Check if a JSON file was found
if [ -z "$latest_json_file" ]; then
  echo "No JSON file found in the repository."
  exit 1
fi

# Run your command with the found JSON file
/usr/local/bin/dicmd import -u "$admin_user" \
                            -w "$admin_password" \
                            -p PCInstall_Check \
                            -l Development \
                            -s datapoint=reuse,dataobject=reuse \
                            -f "$latest_json_file"

# Clean up - remove the temporary cloned repository
cd ..
rm -rf temp_repo



