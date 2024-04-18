+++
title = 'Create Python project'
date = 2023-10-30
+++

### Create Python project

- For PyCharm then you can ignore this step
- For Visual Studio Code:
  - Create new folder with `project-name`
  - Create virtual environment to isolate installed packages + python:
    Go to `project name` then run the command
    ```shell
    # Create virtual environment
    python -m venv .venv
    # Activate (Windows)
    .\.venv\Scripts\activate
    # Activate (Mac)
    source ./.venv/Scripts/activate
    ```

### Install required package

- After activating virtual environment, then we can install required packages by the command
  ```shell
  pip install <PACKAGE-NAME>
  ```
- If we define the required package in the `requirements.txt` then we can run
  ```shell
  pip install -r requirements.txt
  ```
  The `requirement.txt` file like this:
  ```shell
  Flask
  gunicorn==20.1.0
  Werkzeug==3.0.1
  requests
  ```
