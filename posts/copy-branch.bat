set "branchComment=20240201-Add More Notes"

set source="."
set des="D:\HaiHo\Hai-Researchs\bk\Hai-TakeNotes\%branchComment%"

robocopy %source% %des% /e /XD ".venv" "node_modules" ".git" "__pycache__" ".idea"
