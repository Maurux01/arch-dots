#!/bin/bash
cd ~/github/arch-dots
git add .
git commit -m "Backup: $(date '+%Y-%m-%d %H:%M')"
git push
cd -
echo "Backup subido a GitHub!" 