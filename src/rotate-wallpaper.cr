require "./rotate-wallpaper/*"

module Rotate::Wallpaper
  def self.call
    find_files.cycle do |file|
      set_background(file)
      wait
    end
  end

  def self.find_files
    base_dir = ENV["HOME"] + "/img/wallpapers"
    Dir[base_dir + "/*"]
  end

  def self.set_background(file)
    `feh --bg-fill #{file}`
  end

  def self.wait
    sleep sleep_time
  end

  # @return [Int32]
  def self.sleep_time
    @@sleep_time ||= begin
      ENV.fetch("ROTATE_WALL_INTERVAL", "3600").to_i
    rescue
      3600
    end
  end
end

Rotate::Wallpaper.call
