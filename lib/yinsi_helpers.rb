module YinsiHelpers
  extend self
  
  def self.included(base)
    base.send :extend, self
  end

  # Lookup a variable from the main application teacup stylehseet
  def stylesheet_var(name)
    # We need to hit a fake query to Teacup::Stylesheet to ensure it has parsed it, or
    # it's possible that it has not yet been loaded.
    @query_completed ||= begin
      Teacup::Stylesheet[:application].query(:dummy)
      true
    end
    Teacup::Stylesheet[:application].instance_variable_get("@#{name.to_s}".to_sym)
  end

  def font_awesome_icon(icon_name, options = {})
    if options[:image_size] && !options[:font_size]
      options[:font_size] = options[:image_size]-1
    end

    options = {
      color: :black.uicolor,
      background_color: UIColor.clearColor,
      image_size: 30,
      font_size: 29
    }.merge(options)

    FontAwesomeKit.imageForIcon(FontAwesomeKit.allIcons["FAKIcon#{icon_name.to_s.sub('-','_').camelize.sub('Icon','')}"],
                                imageSize: CGSizeMake(30,30),
                                fontSize: 29,
                                attributes: {'FAKImageAttributeForegroundColor' => options[:color],
                                             'FAKImageAttributeBackgroundColor' => options[:background_color]})

  end

  def font_awesome_tab_icon(icon_name, options = {})
    options = {
      image_size: 30,
      font_size: 29,
    }.merge(options)
    font_awesome_icon(icon_name, options)
  end

  def dismissKeyboard
    self.view.endEditing(true)
  end

  def dismiss_keyboard_on_tap
    self.view.addGestureRecognizer(UITapGestureRecognizer.alloc.initWithTarget(self, action: 'dismissKeyboard'))
  end

  def set_tab_icon(icon_name, title)
    icon = font_awesome_tab_icon(icon_name, color: stylesheet_var(:clouds))
    self.set_tab_bar_item icon: {selected: icon, unselected: icon}, title: title
  end

  def unobserve(observer)
    App.notification_center.unobserve observer
  end

  def tab_titled(title)
    App.delegate.tab_bar.find_tab(title)
  end

end
