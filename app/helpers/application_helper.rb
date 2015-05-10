module ApplicationHelper
  def icon(name)
    "<span class=\"glyphicon glyphicon-#{name}\"><span>".html_safe
  end
  def product_status_options
    # [ ["發布","published"], ["草稿", "draft"] ]

    Product::STATUS.map{ |s| [ t(s, :scope => "product"), s] }
    #Event::STATUS.map{ |s| [ t( "event.#{s}" ), s] }
  end
end
