class UpdatersController < ApplicationController
  def new
    @updaters = Updater.all
  end
end