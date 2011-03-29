# Compass Rmagick Engine

Compass Rmagick Engine is a drop in replacement for creating sprites using chunky_png.

## Usage

### Rails
  
1. In your gem file add  `gem 'compass-rmagick-engine', '~> 0.0.1'`
2. Add `sprite_engine = :rmagick` to your compass config
    
Standalone

First run `gem install compass-rmagick-engine`

Then open your compass config file and add

    require 'compass-rmagick-engine'
    sprite_engine = :rmagick
    
    