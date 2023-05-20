#import "LAInfoSwitchCell.h"

@implementation LAInfoSwitchCell {
  UIButton *_infoButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

  if(self) {

    ((UISwitch *)self.control).onTintColor = [[LAPrefs shared] accentColour];

    _infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    _infoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_infoButton addTarget:self action:@selector(infoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_infoButton];

    [NSLayoutConstraint activateConstraints:@[
    [_infoButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
    [_infoButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-4],
    ]];


    self.headerLabel = [[UILabel alloc] init];
    self.headerLabel.textColor = UIColor.labelColor;
    self.headerLabel.text = specifier.properties[@"title"];
    self.headerLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    [self addSubview:self.headerLabel];

    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.headerLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor constant:0].active = true;
    [self.headerLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    [self.headerLabel.trailingAnchor constraintEqualToAnchor:_infoButton.leadingAnchor constant:-10].active = YES;

  }

  return self;
}

-(void)infoButtonTapped {
  NSString *title = ([self.specifier propertyForKey:@"title"]);
  NSString *message = ([self.specifier propertyForKey:@"message"]) ?: @"No information provided for this cell";

  UIAlertController *infoAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

  [infoAlert addAction:cancelAction];

  UIViewController *rootViewController = self._viewControllerForAncestor;
  [rootViewController presentViewController:infoAlert animated:YES completion:nil];
}

@end
