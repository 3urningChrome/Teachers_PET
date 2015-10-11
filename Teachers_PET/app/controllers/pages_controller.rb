
class PagesController < ApplicationController
  require 'method_missing_in_development'
  before_action :require_login, only: [:home_page]
  
  def index
  end
  
  def home_page
  end
end
