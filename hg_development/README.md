# Description

This cookbook installs and configures development environment for you.

# Avialbale recipes

 * `recipe["hg_development::git_aware_prompt"]` - installs and configures git aware prompt, colorful git branch and diff indicator.

# Recipes description

### git\_aware\_prompt

Enables colorful branch indicator, also shows weather there are unstaged changes in current repository.

[https://github.com/jimeh/git-aware-prompt](https://github.com/jimeh/git-aware-prompt)

Available attributes with defaults:

```ruby
node["user"] = nil # user for whom we install git_aware_prompt

# check git_aware_prompt repository for more examples.
node["hg_development"]["git_aware_prompt"]["ps1"] = "\"\\u@\\h:\\w\\[$bldgrn\\]\\$git_branch\\[$txtred\\]\\$git_dirty\\[$txtrst\\]\\$ \""
```