module ApplicationHelper
  include AuthHelper

  def navbar_link(label, path, options = {})
    patch = options[:with]

    if patch
      label += [" (", patch, ")"].join
    end

    link_to label, path
  end
end
