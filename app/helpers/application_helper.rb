module ApplicationHelper
  def current_url
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

  def current_site
    Rails.application.class.module_parent.name
      .underscore
      .humanize
      .split
      .map(&:capitalize)
      .join(' ')
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

  def render_cards(sm: 1, md: 2, lg: 3, xl: 4, gap: 4, &block)
    render(
      partial: '/partials/cards',
      locals: { sm: sm, md: md, lg: lg, xl: xl, gap: gap, block: block })
  end

  def render_badge(icon: "", color: "secondary", &block)
    render(
      partial: '/partials/badge',
      locals: { color: color, icon: icon, block: block })
  end

  def render_like(gem)
    render(
      partial: '/partials/like',
      locals: { gem: gem })
  end

  def render_match(user)
    render(
      partial: '/partials/match',
      locals: { user: user })
  end

end
