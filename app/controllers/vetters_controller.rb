class VettersController < ApplicationController
  layout 'layouts/vetter'
  before_action :authenticate_vetter!
end
