# 🍔 Sliders
Sliders are mini "app-folders" for grouping related code in your Rails application.

*Like a slider is not really a burger 🍔 this is not really app folders 😉*

Some times you have bundles of code in your app that is related to some specific feature.
Extracting to a gem is not really an option as the feature is tightly integrated with the rest of the application. So how do you get a good structure of files in you application?

(Yes, I've been inspired by, or envious at,  [Hanami](https://github.com/hanami/hanami) and their [slices](https://guides.hanamirb.org/v2.1/app/slices/) for structuring a Hanami application.)

With `sliders` you get a namespace folder that groups all you files.

Going from:
```plain
app/
├─ controllers/
│  └─ my_feature/
│     ├─ first_controller.rb
│     └─ second_controller.rb
├─ models/
│  └─ my_feature/
│     ├─ record_a.rb
│     └─ record_b.rb
├─ jobs/
│  └─ my_feature/
│     └─ run_in_background_job.rb
└─ interactors/
   └─ my_feature/
      └─ important_feature_task.rb
```

To:
```plain
app/
└─ sliders/
   └─ my_feature/
      ├─ controllers/
      │  ├─ first_controller.rb
      │  └─ second_controller.rb
      ├─ models/
      │  ├─ record_a.rb
      │  └─ record_b.rb
      ├─ jobs/
      │  └─ run_in_background_job.rb
      └─ interactors/
         └─ important_feature_task.rb
```

Future plan is to group all your sliders tests in a `test/sliders/my_feature` folder as well.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "sliders"
```

And then execute:
```bash
$ bundle
```

## Usage
Create your slider folder
```bash
$ rails g slider my_feature
```

This creates the `app/sliders/` folder and a module and folder for your feature.

Now you can just use regular generators to create thing in `MyFeature` namespace and *sliders* will create the files in your slider folder.

The folder *sliders* is not used for namespace, just like the folders in your slider is not used. So a file in `app/sliders/my_feature/models/admin.rb` will be for the constant `MyFeature::Admin`.

### Fixtures
Load fixtures from slides by adding `Sliders.add_fixtures` before `module ActiveSupport` in `test_helper.rb`

## Contributing
PR with fixes or improvements are most welcome.

We have tested *sliders* with most of Rails built-in generators, only a few of them have actual test cases.
PR with tests for more generators are very welcome - also generators for often used gems like eg. ViewComponent or Rspec.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
