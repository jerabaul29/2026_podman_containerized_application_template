# 2026_podman_containerized_application_template

A podman containerized template for running applications

## Main motivations and goals

- I want to be able to run applications that should be safe (but still) on my linux machines without worrying too much about security: an app should only have access to its own data, should not be able to mess up with my other userspace stuff, should be kept up to date automatically independently of how it is installed, etc. This should be convenient and automated, too.
- For example, an app installed from an app image upstream or a python package should be kept up to date automatically at least once per week - no more "installed once with pip in userspace, never updated if not I actively remember to update" stuff.
- For example, an app that only needs to talk to 1 server should only be able to talk to this specific server - no reason to give it access to the whole internet.
- For example, an app that only needs to access 1 folder on my machine to keep track of its local data should only be able to access this folder - no reason that is can access my ssh keys, downloads, and generally other userspace stuff.
- For example, and app that requires several step to install (install some libraries, then the app) should be installable in a simple "one command" way on all my linux machines.
- For example, an app should not be able to freeze my whole machine if it has a memory leak or deadlock or dead loop or fork bomb like issue.

The solution I want to use for this is to use podman containers. XXTODO: quite big improvement why XXTODO: not perfect why.

Less isolated than a full VM, but also more lightweigth and simpler to use - for apps I generally trust, I believe this is the right kind of control.

This is not a full solution - rather a "starting point framework" I use when podman containerizing my apps.
