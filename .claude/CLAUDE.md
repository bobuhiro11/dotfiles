# Claude Code Configuration

* Implement test code first
* Run test cases and linter before committing code
  * The targets are limited to changed files to spepd up the process
* Keep your response concise and limit line width to 80 characters.
* For python code, use 'uv run' to run the code, instead of 'python' or 'python3' commands.
* Respect github pr template when creating pull requests, and provide a clear description of the changes made.
* Indicate that the change is made by Claude in the pull request description, and commit message.
* Please show the plan first before writing the code or docs.
* Use `gh` command for github related operations, such as creating/reading pull requests, issues, etc.
