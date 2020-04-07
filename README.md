# SplutterApp
This application implements the basic capabilities of such a well-known service as Twitter and is just an example.

This project is based on the Ruby on Rails framework, using the PostgreSQL database, the SendGrid & CarrierWave platforms.

![image alt](https://github.com/SplutterApp-Team/SplutterApp/Production/Logos/RubyOnRails.png)

![image alt](https://github.com/SplutterApp-Team/SplutterApp/Production/Logos/PostgreSQL.png)

![image alt](https://github.com/SplutterApp-Team/SplutterApp/Production/Logos/SendGrid.png)

![image alt](https://github.com/SplutterApp-Team/SplutterApp/Production/Logos/CarrierWave.png)


## Note (License)

All source code in the [Ruby on Rails Tutorial](https://www.railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

# How to run SplutterApp project?

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For help with your application, go to the [*SplutterApp Documentation*](https://github.com/SplutterApp-Team/SplutterApp/wiki/SplutterApp-Documentation) section.
