require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'compass-rmagick'
require 'digest/md5'

describe Compass::Sprites do

  before :each do
    @images_src_path = File.join(File.dirname(__FILE__), 'test_project', 'public', 'images')
    @images_tmp_path = File.join(File.dirname(__FILE__), 'test_project', 'public', 'images-tmp')
    ::FileUtils.cp_r @images_src_path, @images_tmp_path
    file = StringIO.new("images_path = #{@images_tmp_path.inspect}\nsprite_engine = :rmagick")
    Compass.add_configuration(file, "sprite_config")
    Compass.configure_sass_plugin!
  end

  after :each do
    FileUtils.rm_r @images_tmp_path
  end

  def map_location(file)
    Dir.glob(File.join(@images_tmp_path, file)).first
  end

  def image_size(file)
    IO.read(map_location(file))[0x10..0x18].unpack('NN')
  end

  def image_md5(file)
    md5 = Digest::MD5.new
    md5.update IO.read(map_location(file))
    md5.hexdigest
  end

  def render(scss)
    scss = %Q(@import "compass"; #{scss})
    options = Compass.sass_engine_options
    options[:line_comments] = false
    options[:style] = :expanded
    options[:syntax] = :scss
    css = Sass::Engine.new(scss, options).render
    # reformat to fit result of heredoc:
    "      #{css.gsub('@charset "UTF-8";', '').gsub(/\n/, "\n      ").strip}\n"
  end

  it "should render sprites using rmagick" do
    css = render <<-CSS
      @import "squares/*.png"
    CSS
    File.exists?(File.join(@images_tmp_path, 'squares-161c60ad78.png'))
    image_size('squares-*.png').should == [20,30]
  end
  
  it "should render aprites using spacing" do
    css = render <<-SCSS
      $squares-ten-by-ten-spacing: 44px;
      $squares-twenty-by-twenty-spacing: 33px;
      @import "squares/*.png";
      @include all-squares-sprites;
    SCSS
    css.should == <<-CSS
      .squares-sprite, .squares-ten-by-ten, .squares-twenty-by-twenty {
        background: url('/squares-1cd84c9068.png') no-repeat;
      }
      
      .squares-ten-by-ten {
        background-position: 0 0;
      }
      
      .squares-twenty-by-twenty {
        background-position: 0 -54px;
      }
    CSS
    image_size('squares-*.png').should == [20, 74]
  end


end
