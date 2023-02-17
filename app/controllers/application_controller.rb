class ApplicationController < ActionController::Base
  layout 'application'
  include Pagy::Backend
  before_action :authenticate_user!

end
