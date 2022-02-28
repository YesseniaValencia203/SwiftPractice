#!/bin/sh

#  GithubSummary.sh
#  
#
#  Created by Consultant on 2/23/22.
#  

git config --global user.name "Yessenia Valencia"
git config --global user.email "yesseniavalencia2@outlook.com"
git help config
git config --help

#initialize a repository from existing code
git init
 # before first commit
git status
 # add gitignore file to avoid it in list of untracked files
 # to add all the files to staging area
git add -A
git add .gitignore
# to remove files from staging area back to working area
git reset
# to push everything
git commit -m "Initial Commit"
# logs commits
git logs
# track existing remote repo
# clone a remote repo
git clone <url> <where to clone>
git clone ../remote_repo.git .
# to view changes to any files
git diff

# view info about remote repo
git remote -v
git branch -a # list branches in repo
# pulls any cnages made since last time it has been pulled
git pull origin master
# pushes changes to remote repo HAVE TO PULL FIRST
git push origin master
# to create a branch for desired feature
git branch calc-divide
# change branches
git checkout calc-divide
# after commit, push branch to remote
git push -u origin calc-divide

# to merge a branch
git checkout master # switch to master
git pull origin master # pull any changes
git branch --merged # branches that have been merged
git merge calc-divide # merges changes into master branch
git push origin master # pushes them to master

# to delete branch
git branch --merged
git branch -d calc-divide
git branch -a # sees that we deleted local branch
git push origin --delete calc-divide

# say we make changes that we don't want
git checkout calc.py
git status
git status

git status
git add -A
git commit --amend -m "Completed"
git push origin master

git log --stat # shows us files changed


# remove commit to feature branch
git log # grab hsh of the commit we want to undo
git checkout subtract-branch
# cherry-pick : given one or more existing commits, apply changes each one introduces, recording a new commit for each
# requires working tree to be clean
git cherry-pick  <hash>

git reset --soft <hash>
git status #

git reset <Hash> # kept changes but put them in the working area
git reset --hard <hash> # reverts tracked files to what they were
git clean -df # removes .gitignore

# Reference logs that record when the tips of the branches and other references were updated in the local repository
# useful to specify the old value of a reference
git reflog

# GIven one or more existing commits, reverts the changes that the related patched introfuct, and record some new commits that record them
# used to record new commits to reverse the effect of some earlier commits (often only a faulty one)
git reverb <hash>


# Stash
git stash save "worked on add function"
# list the stash entries you currently have
git stash list
# remove a single stash entry from list of stash entries
git stash stop stash@{0}
# removes all stash entries
git stash clear

# Diffmerge tool: helps make changes without going throught all the trouble of opening/changing/closing all required files

