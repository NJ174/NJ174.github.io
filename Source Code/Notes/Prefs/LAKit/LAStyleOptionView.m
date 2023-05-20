#import "LAStyleOptionView.h"

@implementation LAStyleOptionView {
  UIStackView *_stackView;
  UITapGestureRecognizer *_tapGesture;
  UIImpactFeedbackGenerator *appearanceHapticFeedback;
}

-(id)initWithFrame:(CGRect)frame appearanceOption:(id)option {
  self = [super initWithFrame:frame];

  if(self) {

    self.tintColour = [[LAPrefs shared] accentColour];

    _appearanceOption = option;

    _previewImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _previewImageView.clipsToBounds = YES;
    _previewImageView.contentMode = UIViewContentModeScaleAspectFit;
    _previewImageView.layer.cornerRadius = 8;
    _previewImageView.layer.borderColor = self.tintColour.CGColor;
    _previewImageView.translatesAutoresizingMaskIntoConstraints = NO;

    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.translatesAutoresizingMaskIntoConstraints = NO;

    _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_previewImageView, _label]];
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.distribution = UIStackViewDistributionEqualSpacing;
    _stackView.spacing = 5;
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_stackView];

    [NSLayoutConstraint activateConstraints:@[
    [_stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
    [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
    [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    [_stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ]];

    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:_tapGesture];
  }

  return self;
}

-(void)setPreviewImage:(UIImage *)image {
  _previewImage = image;
  _previewImageView.image = _previewImage;
}

-(void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
}

-(void)setHighlighted:(BOOL)highlighted {
  _highlighted = highlighted;

  if(_highlighted) {
    CABasicAnimation *showBorder = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    showBorder.duration = 0.1;
    showBorder.fromValue = @0;
    showBorder.toValue = @3;

    _previewImageView.layer.borderWidth = 3;
    [_previewImageView.layer addAnimation:showBorder forKey:@"Show Border"];
  }

  if(!_highlighted && _previewImageView.layer.borderWidth == 3) {
    CABasicAnimation *hideBorder = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    hideBorder.duration = 0.1;
    hideBorder.fromValue = @3;
    hideBorder.toValue = @0;

    _previewImageView.layer.borderWidth = 0;
    [_previewImageView.layer addAnimation:hideBorder forKey:@"Hide Border"];
  }
}

-(void)updateViewForAppearance:(NSString *)style {
  self.enabled = [style isEqualToString:_appearanceOption];
  self.highlighted = [style isEqualToString:_appearanceOption];
}

-(void)handleTap:(UIGestureRecognizer *)gesture {
  if(gesture.state == UIGestureRecognizerStateRecognized) {
    [self.delegate selectedOption:self];
    appearanceHapticFeedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [appearanceHapticFeedback impactOccurred];
  }
}

-(BOOL)gestureRecognizer:(id)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(id)otherGesture {
  return YES;
}
@end
