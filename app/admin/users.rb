# frozen_string_literal: true

ActiveAdmin.register User do
  filter :email
  filter :admin, as: :check_boxes
end
