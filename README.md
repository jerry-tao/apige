# Apige

Just another api doc generator.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apige'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apige

## Usage

Initialize:

```
# Will create default apige folder with default template and demo files.
apige init
# Create with specific folder
apige init /apidoc
```

Then

```
# This will create md files in apige/docs/#{version}(optional)/#{api_filename}.md.
apige compile
```

## FAQ

### How to custom template?

Just modify  temlate file in apige/templates.

Structure.

 - HEAD

 - API Content(Render in defined order)

## References

### Configuration

- templates: Required, Hash
- date
- version
- author
- meta

### Scope Method

#### group & resources

- desc
- meta

#### get/put/post/delete

- title
- desc
- meta
- params
- required

### Template Varable

- head: all config value
- group: level name description parent children type apis
- resources: Same with group
- api: level title path method params response_value


## WIP

- Mock server
- Support Api blueprint format.
