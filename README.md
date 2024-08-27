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

We'll do our best to group you files in you test folder as well.

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

## Contributing
Feel free to open PR with fixes for generators for that creates files outside of sliders folder.

Known generators that will not do what you expect:
- view
- fixtures (part of model tests)
- models
- components
- tests (controller, mailer, scaffold)

Other things we need to fix:
- loading fixtures from slider fixture foldeer

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
