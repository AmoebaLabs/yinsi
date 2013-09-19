Teacup.handler UIView, :nav_background do |view, hash|
  UINavigationBar.appearance.setBackgroundImage(hash[:normal].uiimage, forBarMetrics:UIBarMetricsDefault)
  UINavigationBar.appearance.setTitleVerticalPositionAdjustment(4.0, forBarMetrics:UIBarMetricsDefault)
  UINavigationBar.appearance.setBackgroundImage(hash[:landscape].uiimage, forBarMetrics:UIBarMetricsLandscapePhone)
  UINavigationBar.appearance.setTitleVerticalPositionAdjustment(7.0, forBarMetrics:UIBarMetricsLandscapePhone)
end

Teacup.handler UIView, :background_gradient do |view, hash|
  background_image = Graphics::gradient_image_with_top(hash[:top], hash[:bottom], view.frame)
  view.setBackgroundColor(UIColor.colorWithPatternImage(background_image))
end

Teacup.handler UIRoundedRectButton, :button_background do |view, image, text_color|
  text_color ||= UIColor.whiteColor
  view.setBackgroundImage(image.uiimage, forState:UIControlStateNormal)
  view.setTitleColor(text_color, forState:UIControlStateNormal)
end

Teacup.handler UISegmentedControl, :texture do |view, hash|
  view.setDividerImage(hash[:segmentImage].uiimage, forLeftSegmentState: UIControlStateSelected, rightSegmentState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
  view.setBackgroundImage(hash[:backgroundOn].uiimage, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault)
end

Teacup.handler UISlider, :texture do |view, hash|
  UISlider.appearance.setMinimumTrackImage(hash[:minImage].uiimage, forState:UIControlStateNormal)
  UISlider.appearance.setMaximumTrackImage(hash[:maxImage].uiimage, forState:UIControlStateNormal)
  UISlider.appearance.setThumbImage(hash[:thumbImage].uiimage, forState:UIControlStateNormal)
end

Teacup.handler UITextField, :placeholderColor do |text_field, color|
  text_field.setValue(color, forKeyPath: "_placeholderLabel.textColor")
end

Teacup.handler UITextField, :placeholderFont do |text_field, font|
  text_field.setValue(font, forKeyPath: "_placeholderLabel.font")
end

Teacup.handler UITextField, :padding do |text_field, hash|
  [:left, :right].each do |side|
    if hash[side]
      padding_view = UIView.alloc.initWithFrame(CGRectMake(0,0,hash[side],5))
      text_field.send("#{side}View=", padding_view)
      text_field.send("#{side}ViewMode=", UITextFieldViewModeAlways)
    end
  end
end

Teacup.handler UIButton, :padding do |button, hash|
  left = hash[:left] || 0.0
  right = hash[:right] || 0.0
  button.titleEdgeInsets = UIEdgeInsetsMake(0.0, left, 0.0, right)
end
