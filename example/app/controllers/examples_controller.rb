class ExamplesController < ApplicationController
  def index
  end

  def reload
    AppSettings.reload

    redirect_to :back, notice: 'Settings reloaded'
  end
end
