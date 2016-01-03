> These guidelines are for the v1.0.0 fork of `oxidized-web`.  If you're looking
> for contributing guidelines for the original `oxidized-web`, there are none.
> You should head to [ytti/oxidized-web](https://github.com/ytti/oxidized-web)
> to contribute to anything pre-v1.0.0.

# Submitting Issues Against `oxidized-web`

Please:

 * include any error messages you might have received
 * include the output of `git rev-parse HEAD` from your local oxidized-web repo

# Contributing to `oxidized-web`

There isn't currently a document explaining the layout, but it should be
relatively self-explanatory.

## Due Diligence

Please ensure that whenever you contribute, you update:

* relevant tests -- see [spec/](spec/)
* relevant API definitions -- see [raml/](raml/)
* relevant API schemas -- see [raml/schemas/](raml/schemas/)
* relevant response samples -- see [raml/schemas/](raml/schemas/)

## Commits

Please make them short.  Several small commits are easier to digest than a
single large commit.

Multiple commits in a single pull request is fine.

## Commit Messages

Please don't use the `-m` message shortcut.  Please write a short message as
the subject.  Briefly detail whatever changes you've made in the body.  For more
detail and examples, please read
[this excellent post](http://chris.beams.io/posts/git-commit/).

## Adding a New Feature

Ensure an issue exists and is tagged with the `enhancement` label.  If you are
working on it, please also add the `in-progress` label.

Remember that `oxidized-web` depends on data exposed by
[oxidized](https://github.com/ytti/oxidized).  If you can't get the data from
`oxidized`, you probably won't be able to put it into `oxidized-web`.  So if
there's some killer feature you want from `oxidized-web`, be aware that you
might need to contribute that feature to `oxidized` first.

## Fixing a Bug

Ensure an issue exists and is tagged with the `bug` label.  If you are working
on it, please also add the `in-progress` label.

## Verify Tests Pass

You can verify tests run by running `rake test:spec`.

## Submit a Pull Request

Push your changes up to GitHub and then submit a new pull request against the
`v1.0.0` branch.
