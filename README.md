# README

 ```
.___  ___.      ___       _______  __    ______
|   \/   |     /   \     /  _____||  |  /      |
|  \  /  |    /  ^  \   |  |  __  |  | |  ,----'
|  |\/|  |   /  /_\  \  |  | |_ | |  | |  |
|  |  |  |  /  _____  \ |  |__| | |  | |  `----.
|__|  |__| /__/     \__\ \______| |__|  \______|

 _______   ______   .______       __    __  .___  ___.      _______.
|   ____| /  __  \  |   _  \     |  |  |  | |   \/   |     /       |
|  |__   |  |  |  | |  |_)  |    |  |  |  | |  \  /  |    |   (----`
|   __|  |  |  |  | |      /     |  |  |  | |  |\/|  |     \   \
|  |     |  `--'  | |  |\  \----.|  `--'  | |  |  |  | .----)   |
|__|      \______/  | _| `._____| \______/  |__|  |__| |_______/

```

#### This forum discussion app is built with Ruby on Rails during the 3 months full stack bootcamp.

### Challenges:

- AJAX Forms
- Voting feature
- Listing Popular Topics / Posts

### Instructions

- Clone and cd into project folder
- Run ```bundle``` to install gems
- Run ```rails db:create``` and ```rails db:migrate``` to set up database
- or
- Run ```rails db:setup``` to load from schema instead
- Run ```rails db:seed``` if you want to populate database
- Run ```rails db:test:prepare``` to prepare test database
- Run ```rspec``` to run tests
- Run ```rails s``` to start server

### Setting Up Environment
- Run ```figaro install```
- Set ```SERVER_URL = "http://localhost:3000" ``` for ```development``` and ```test``` environments.
- ```Production``` uses SendGrid and AWS api keys. Kindly use your own keys.

### References:

#### Frontend
- [Turbolinks](https://github.com/turbolinks/turbolinks)
- [SCSS Guide](http://sass-lang.com/guide)
- [Font Awesome](http://fontawesome.io/), [Font Awesome Gem](https://github.com/bokmann/font-awesome-rails)
- [Bootstrap](http://getbootstrap.com/), [Bootstrap Gem](https://github.com/twbs/bootstrap-sass)
- [Flexboxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Using_CSS_flexible_boxes), [Flexbox Guide](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)
- [Unsplash Royalty Free Photos](https://unsplash.com/)
- [Remotipart](gem 'remotipart', github: 'mshibuya/remotipart', ref: '88d9a7d')

#### Image Uploading
- [Carrierwave](https://github.com/carrierwaveuploader/carrierwave)
- [Mini Magick](https://github.com/minimagick/minimagick)
- [Fog](https://github.com/fog/fog)

#### Authorization
- [Pundit](https://github.com/elabs/pundit)

#### Pagination
- [Kaminari](https://github.com/amatsuda/kaminari)

#### Environment
- [Figaro](https://github.com/laserlemon/figaro)

#### Testing
- [RSpec Docs](https://www.relishapp.com/rspec/rspec-rails/docs), [RSpec Gem](https://github.com/rspec/rspec-rails)
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)
- [Factory Girls](https://github.com/thoughtbot/factory_girl)
- [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner)
- [Capybara](https://github.com/jnicklas/capybara)
- [Rails Controller Testing](https://github.com/rails/rails-controller-testing)
- [Letter Opener](https://github.com/ryanb/letter_opener)
- [Faker](https://github.com/stympy/faker)
- [Pry](https://github.com/pry/pry)

