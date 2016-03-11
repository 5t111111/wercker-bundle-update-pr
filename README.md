# wercker-bundle-update-pr

This is an automation script to bundle update and send pull request via Wercker's Trigger Build API. By requesting trigger build to Wercker with an environment variable which instruct wercker.yml to execute this script, bundle update is invoked, then commit changes and send pull request to GitHub repository if there some changes exist.

(Both concept and implementaion are strongly based on [circleci-bundle-update-pr](https://github.com/masutaka/circleci-bundle-update-pr).

## Installation

``` text
$ gem install wercker-bundle-update-pr
```

## Usage

### Prerequisites

The application on which you want to execute `bundle update` automatically must be on a Wercker CI.

### Getting GitHub Personal access token

A GitHub personal access token is required for sending GitHub pull request. Go to your account's settings page and obtain a personal access token.

### Getting Werkcer personal token

A Wercker personal token is required for invoking Trigger Build API. Go to your account's settings page and obtain a personal token.

### Wercker application configuration

In the application's setting page:

1. Generate SSH key named "wercker_github_ci_key" in "SSH Keys" for pushing changes to GitHub
1. Register the above generated key to GitHub SSH keys in Personal settings
1. In "Environment variables", add `GITHUB_ACCESS_TOKEN` with a GitHub personal access token (**Make sure you mark it "protected" otherwise it will be shown in logs**)
1. In "Environment variables", add `WERCKER_GITHUB_CI_KEY` as SSH key pair and select "wercker_github_ci_key"

### Configure wercker.yml

Add the following 2 steps under `steps` to access GitHub via SSH (Set GitHub's SSH key RSA fingerprint to `<fingerprint>`. See [What are GitHub's SSH key fingerprints?](What are GitHub's SSH key fingerprints?)):

```yaml
    - add-ssh-key:
        keyname: WERCKER_GITHUB_CI_KEY
        fingerprint: <fingerprint>

    - add-to-known_hosts:
        hostname: github.com
```

then add this step as well (replace `<username>` and `<email>` with yours).

``` yaml
    - script:
        code: |
          if [ "${BUNDLE_UPDATE}" ] ; then
            gem update bundler --no-document
            gem install wercker-bundle-update-pr
            wercker-bundle-update-pr <username> <email>
          fi
```

Do not forget `git commit` and `git push` these changes.

### Fire Trigger build API

Now all set to fire Trigger build API.

``` text
$ curl -H 'Content-Type: application/json' -H "Authorization: Bearer <wercker personal token>" -X POST -d '{"applicationId": "<wercker application id>", "branch":"master", "message":"bundle update via trigger build", "envVars":[{"key":"BUNDLE_UPDATE","value":"true"}]}' https://app.wercker.com/api/v3/builds
```

You have to replace `<wercker personal token>` with your Wercker personal access token, and replace `<wercker application id>` which you can find in the URL of your wercker application.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wercker-bundle-update-pr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
