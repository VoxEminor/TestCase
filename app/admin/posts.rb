# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :blocked, :title, :description, :comments 
  filter :created_at
  filter :title
  filter :description
  filter :blocked, as: :check_boxes

  # form do |f|
  #   f.semantic_errors
  #   f.inputs 'Details' do
  #     f.input :blocked
  #   end
  #   f.actions
  # end
end
