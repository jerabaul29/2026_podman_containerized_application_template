# 2026_podman_containerized_application_template

A podman containerized template for running applications.

## Main motivations and goals

- I want to be able to run applications that should be safe (but still) on my linux machines without worrying too much about security: an app should only have access to its own data, should not be able to mess up with my other userspace stuff, should be kept up to date automatically independently of how it is installed, etc. This should be convenient and automated, too.
- In addition, many apps are not fully packaged - by fully, I mean also making sure updates are enforced, libraries and dependencies can be installed together with the app, etc.
- For example, an app installed from an app image upstream or an appimage file or a python package should be kept up to date automatically at least once per week - no more "installed once with pip in userspace, never updated if not I actively remember to update" stuff.
- For example, an app that only needs to talk to 1 server should only be able to talk to this specific server - no reason to give it access to the whole internet.
- For example, an app that only needs to access 1 folder on my machine to keep track of its local data should only be able to access this folder - no reason that is can access my ssh keys, downloads, and generally other userspace stuff.
- For example, and app that requires several step to install (install some libraries, then the app) should be installable in a simple "one command" way on all my linux machines.
- For example, an app should not be able to freeze my whole machine if it has a memory leak or deadlock or dead loop or fork bomb like issue.

The solution I want to use for this is to use bash scripting and Containerfiles and use these to spin podman containers. The reason for going for these technologies is that they are ubiquitous and stable on most linux systems.

While relatively well isolated, this is less isolated than a full VM, but also more lightweigth and simpler to use - for apps I generally trust, I believe this is the right kind of control.

This repository is not a full solution - rather a "starting point framework" I use when podman containerizing my apps. Each app I containerize this way then needs its own separate github repository that uses this repository as a starting point.

## Workflow of the containerized app

- The meta information about the app to containerize is in `app_config.sh`. This defines variables, such as `APP_NAME`, `MAX_APP_IMAGE_AGE`, .
- By running `make.sh`, the `APP_NAME.sh` (with the correct name obtained from `app_config.sh`) is automatically generated. This is the file that should be used by the end user.
- The `APP_NAME.sh` contains the following commands and logics: these can be called as for example `APP_NAME.sh --install`, `APP_NAME.sh --build`, `APP_NAME.sh --run`, etc. More flags may be included with all these commands, such as `--dry-run`.
  - `--install`: copies the the `APP_NAME.sh` for the user: copy it to the relevant folder (defined in `app_config.sh`, generally `/usr/bin`), and make it executable with `chmod u+x`. This should be run by the user on first time use of the containerized app.
  - `--build`: builds the Containerfile into an image that is ready to use, clean "too old" images if relevant. This should generally not be called by the user.
  - `--run`: once `--install` has been run, this is the only command the end user should use. Its workflow:
    - check if the newest image is recent enough following the `app_config.sh` parameter `MAX_APP_IMAGE_AGE`.
      - if it is too old, call `--build`
    - run the latest image using podman

## Coding conventions and rules

- Only use bash and Containerfile.
- Code defensively: sanitize all inputs and outputs.
- Avoid third party libraries when not needed.
- Use solutions that are robust across Linux systems.
- Have flags for the different behaviors.
- Use multi-stage Containerfile build process to speed things up.
- Each app gets its own container mountable folder for persistent data in `~/containerized_app/APP_NAME/`
- Always install software from trusted sources, and if relevant check hash of files; better to pull latest and actively fail if there is a breaking change prompting user action, than to silently use outdated software with security holes.
- When building a new image, keep the previous last image too in case the newer image does not work and some use action is needed to fix things.
- If there is any issue, fail loudly with a clear pointer to where the issue is so the user can jump in.
- Keep logs in the persistent folder location. Use logrotate to manage logs. To keep things simple and avoid collisions etc, just call logrotate each time `APP_NAME.sh` is run. Rotate weekly with a proper config.

## Rules for the AI coder

- Discuss with the user before implementing anything new.
- Keep things simple and consistent.
- Make sure to write code that is safe and secure.
- Keep all .md files up to date.
- Keep a log of discussions and inputs with the user in a DISCUSSIONS_LOG.md file.
- Make sure that important choices are written down in relevant .md files, and then implemented in the .sh or Containerfile files; the .md files should describe the high level features, and the role of the AI coder is to turn these into code.

