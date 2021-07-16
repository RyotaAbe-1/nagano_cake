class Admin::OrderDetailsController < ApplicationController
  skip_before_action :authenticate_customer!
end
