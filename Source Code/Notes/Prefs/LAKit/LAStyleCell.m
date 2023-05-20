#import "LAStyleCell.h"
//#import "../Global-Prefs.h"

@implementation LAStyleCell {
  UIStackView *_stackView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier specifier:specifier];

  if(self) {

    specifier.properties[@"height"] = [NSNumber numberWithInt:160];

    NSMutableArray *optionViewArray = [[NSMutableArray alloc] init];
    NSDictionary *options = [specifier propertyForKey:@"options"];
    NSBundle *bundle = [specifier.target bundle];

    for(NSString *key in options) {
      NSDictionary *optionProperties = [options objectForKey:key];

      LAStyleOptionView *optionView = [[LAStyleOptionView alloc] initWithFrame:CGRectZero appearanceOption:[optionProperties objectForKey:@"styleOption"]];
      optionView.delegate = self;
      optionView.label.text = [optionProperties objectForKey:@"title"];
      optionView.previewImage = [UIImage imageNamed:[optionProperties objectForKey:@"image"] inBundle:bundle compatibleWithTraitCollection:nil];
      optionView.tag = [[optionProperties objectForKey:@"arrangement"] integerValue];
      optionView.translatesAutoresizingMaskIntoConstraints = NO;

      [optionViewArray addObject:optionView];
    }


    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    _stackView = [[UIStackView alloc] initWithArrangedSubviews:[optionViewArray sortedArrayUsingDescriptors:@[ascendingSort]]];
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.distribution = UIStackViewDistributionFillEqually;
    _stackView.spacing = 0;
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_stackView];

    for(LAStyleOptionView *view in _stackView.arrangedSubviews) {
      view.enabled = [view.appearanceOption isEqual:[specifier performGetter]];
      view.highlighted = [view.appearanceOption isEqual:[specifier performGetter]];
    }

    [NSLayoutConstraint activateConstraints:@[
    [_stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
    [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
    [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    [_stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ]];
  }

  return self;
}


-(void)selectedOption:(LAStyleOptionView *)option {
  [self.specifier performSetterWithValue:option.appearanceOption];

  for(LAStyleOptionView *view in _stackView.arrangedSubviews) {
    [view updateViewForAppearance:option.appearanceOption];
  }
}

@end
