ActiveSupport::Reloader.to_prepare do
  # make controllers aware of sliders and adjust view path on slider controllers
  ApplicationController.include FixSlidersViewPath
  # reload sliders code and load list of sliders
  Sliders.reload_sliders
end
