# Ruby Capstone Project - Ruby Linter

[![View Code](https://img.shields.io/badge/View%20-Code-green)](https://github.com/carlos-ssh/Capstone_Ruby)
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)](https://github.com/carlos-ssh/Capstone_Ruby/issues)
[![GitHub Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)](https://github.com/carlos-ssh/Capstone_Ruby/pulls)


# About 

The main concept of this Capstone, it's building Linters for Ruby, the project provides feedback about errors or warnings in code. 
Built completely with Ruby following best practices maintaining good coding standards working DIY and managing the version control with Gitflow.


# Ruby Linter
It checks, the following errors & warnings.
- check empty line error
- check for trailing spaces
- check missing/unexpected end
- check for missing/unexpected tags i.e. '( )', '[ ]', and '{ }'
- check for wrong indentation

> Below are demonstrations of good and bad code for the above cases. I will use the pipe '|' symbol to indicate cursor position where necessary.

## Trailing spaces
> note where the cursor(|) is on the bad code 
~~~ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date)  |
    @venue = venue
    @date = date
  end
end
~~~

## Missing/Unexpected Tag
~~~ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date
    @venue = venue
    @date = [[date]
  end
end
~~~

## Indentation Error Check
~~~ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date)
    @venue = venue
      @date = date
  end
end
~~~

## Missing/unexpected end
~~~ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
  end
end
~~~

## Empty line error
~~~ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date)

    @venue = venue
    @date = date
  end
end
~~~

## Built With
- Ruby
- RSpec for Ruby Testing


# Getting Started

To get a local copy of the repository please run the following commands on your terminal:

```
$ cd <folder>
```

```
$ git clone https://github.com/carlos-ssh/Capstone_Ruby.git
```

**To check for errors on a file:** 

~~~bash
$ bin/main ./bugs/bug.rb
~~~

## Testing

To test the code, run `rspec` from root of the folder using terminal.
Note: `bug.rb` has been excluded from rubocop checks to allow RSpec testing without interfering with Gitflow actions

> Rspec is used for the test, to install the gem file, run

~~~bash
$ bundle install 
~~~

> But before that, make sure you have **bundler** installed on your system, else run

~~~bash
$ gem install bundler 
~~~

> or you simply install the the following directly using 

~~~bash
$ gem install rspec 
~~~

~~~bash
$ gem install colorize 
~~~
# Author

👤 **Carlos Robles**

- Github: [@carlos.robles](https://github.com/carlos-ssh/)
- Twitter: [@carlos.robles](https://twitter.com/aom.robles)
- Linkedin: [carlos.robles](https://www.linkedin.com/in/carlos-ssh/)


#
## 🤝 Contributing

Contributions, issues and feature requests are welcome!
#

## Show your support

Give a ⭐️ if you like this project!
#

## Acknowledgments

- Project inspired by [Microverse](https://www.microverse.org)
 
