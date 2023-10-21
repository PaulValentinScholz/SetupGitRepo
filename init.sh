#!/bin/bash

# Check if Git is installed
if ! command -v git &>/dev/null; then
    echo "Git is not installed. Please install Git and try again."
    exit 1
fi

# Prompt for the project directory (default to the current directory)
read -p "Enter the project directory (or press Enter for the current directory): " project_dir

# Use the current directory if the user just hits enter
if [ -z "$project_dir" ]; then
    project_dir=$(pwd)
fi

# Check if the directory exists
if [ ! -d "$project_dir" ]; then
    echo "Directory '$project_dir' does not exist."
    exit 1
fi

# Navigate to the project directory
cd "$project_dir" || exit 1

# Prompt for a GitHub repository URL (optional)
read -p "Enter a GitHub repository URL (or press Enter to skip): " github_url

# Initialize a Git repository
git init

# Optional: Add and commit an initial README file with the GitHub URL
read -p "Create an initial README file? (y/n): " create_readme
if [ "$create_readme" = "y" ]; then
    echo "# My Project" > README.md
    if [ -n "$github_url" ]; then
        echo -e "\nGitHub Repository: $github_url" >> README.md
        git remote add origin "$github_url"
    fi
    git add README.md
    git commit -m "Initial commit"
fi

echo "Git repository initialized in '$project_dir'."

