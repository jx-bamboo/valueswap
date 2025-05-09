class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
	allow_browser versions: { safari: 13, chrome: 90, firefox: 90, opera: 80, ie: false }
end
