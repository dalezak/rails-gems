module ApplicationHelper
  def current_url
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

  def current_domain
    request.host_with_port.to_s
  end

  def current_site
    Rails.application.class.module_parent.name
  end

  def current_title
    title = []
    title << current_site
    if content_for?(:title)
      title << content_for(:title)
    else
      title << params[:controller].split("/").last.titleize
    end
    title.uniq.join(" | ")
  end

  def title(elements=[])
    content_for :title, elements.to_a.compact.map{ |a| a.try(:name) || a.try(:title) || a.try(:id) || a.to_s.capitalize }.join(" | ")
  end

  def description(description="")
    content_for :description, description
  end

  def keywords(keywords="")
    content_for :keywords, keywords
  end

  def sanitize(content)
    ActionController::Base.helpers.sanitize(content)
  end

  def strip_tags_and_entities(string)
    if string.present?
      stripped = strip_tags(string)
      decoded = HTMLEntities.new.decode(stripped)
      decoded.squish.gsub(%r{/</?[^>]*>/}, "")
    end
  end

  def route_exists?(path)
    begin
      recognize_path = Rails.application.routes.recognize_path(path, method: :get)
      recognize_path.present? && recognize_path[:action] != "route_not_found"
    rescue StandardError
      false
    end
  end

  def content_for_or(name, default)
    if content_for?(name)
      content_for(name)
    else
      default
    end
  end

  def body_class(params)
    body = []
    return unless params[:controller]
    if params[:controller].include?("/")
      body << params[:controller].split("/").first
      body << params[:controller].gsub("/", "-")
    else
      body << params[:controller]
    end
    if params[:controller].include?("/")
      body << "#{params[:controller].gsub('/', '-')}-#{params[:action]}"
    else
      body << "#{params[:controller]}-#{params[:action]}"
    end
    if params.key?(:page)
      body << "#{params[:controller]}-#{params[:action]}-#{params[:page]}"
    end
    body.join(" ")
  end

  def active(controllers, action_names = nil)
    class_name = controllers.split(",").any? { |c| controller.controller_name == c.strip } ? "active" : ""
    if class_name.present? && action_names.present?
      return action_names.split(",").any? { |an| controller.action_name == an.strip } ? "active" : ""
    end
    class_name
  end

  def render_cards(sm: 1, md: 2, lg: 3, xl: 4, gap: 4, &block)
    render(partial: '/partials/cards', locals: { sm: sm, md: md, lg: lg, xl: xl, gap: gap, block: block })
  end

  def render_badge(id: "", icon: "", color: "secondary", classes: "", data: {}, &block)
    render(partial: '/partials/badge', locals: { id: id, color: color, icon: icon, classes: classes, data: data, block: block })
  end

  def render_like(gem)
    render(partial: '/partials/like', locals: { gem: gem })
  end

  def render_likes(gem, suffix = "")
    render(partial: '/partials/likes', locals: { gem: gem, suffix: suffix })
  end

  def render_match(user, pluralize = false)
    render(partial: '/partials/match', locals: { user: user, pluralize: pluralize })
  end

  def render_avatar(user, size = "medium", classes = "")
    render(partial: '/partials/avatar', locals: { user: user, size: size, classes: classes })
  end

  def render_share(model, url = nil)
    render(partial: '/partials/share', locals: { model: model, url: url })
  end

  def render_modal(title: "", body: "", footer: "")
    render(partial: '/partials/modal', locals: { title: title, body: body, footer: footer })
  end

  def human_pluralize(count, word="")
    pluralize(number_to_human(count), word)
  end

end
