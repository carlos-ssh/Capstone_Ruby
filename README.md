# Ruby Capstone Project - Ruby Linter

[![View Code](https://img.shields.io/badge/View%20-Code-green)](https://github.com/carlos-ssh/Capstone_Ruby)
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)](https://github.com/carlos-ssh/Capstone_Ruby/issues)
[![GitHub Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)](https://github.com/carlos-ssh/Capstone_Ruby/pulls)


# About 

The main concept of this Capstone, it's building Linters for Ruby, the project provides feedback about errors or warnings in code. 
Built completely with Ruby following best practices maintaining good coding standards working DIY and managing the version control with Gitflow.


#
# Getting Started:

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

> The file bug.rb will be contain errors on it, because it is just for tests.

# Ruby Linter
It checks, the following errors & warnings.
- check empty line error
- check for trailing spaces
- check missing/unexpected end
- check for missing/unexpected tags i.e. '( )', '[ ]', and '{ }'
- check for wrong indentation

> Below are demonstrations of good and bad code for the above cases. I will use the pipe '|' symbol to indicate cursor position where necessary.

#
## Testing Example:
#
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

## Built With
- Ruby
- Rubcop
- RSpec for Ruby Testing
- Love


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
 
