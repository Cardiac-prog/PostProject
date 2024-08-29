module ApplicationHelper
  include Pagy::Frontend
  def formatted_timestamp(timestamp)
    timestamp.strftime("%d-%m-%Y %H:%M:%S")
  end
end
