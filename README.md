# osb
A simple osu! storyboard framework written in Ruby.

## Installation

osb requires Ruby 2.6+.

```sh
gem install osb
```

## Usage

Create a storyboard container:
```rb
require "osb"
include Osb
sb = Storyboard.new
```

Create a static image:
```rb
sp = Sprite.new(file_path: "test.png")
```

Describe what it does:
```rb
sp.fade(start_time: 1000, start_opacity: 1)
sp.move(start_time: 2000, start_position: [320, 640], end_position: [100, 100])
sp.scale(start_time: 100, end_time: 200, start_scale: 1, end_scale: 2)
```

Add it to the container:
```rb
sb << sp
```

Generate your storyboard file:
```rb
sb.generate("path/to/your_storyboard_file.osb")
```

Full documentation is available at https://rubydoc.info/gems/osb/index.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nanachi-code/osb-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
