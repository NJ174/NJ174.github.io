#import "LADualColorPickerCell.h"

@implementation LADualColorPickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		specifier.properties[@"height"] = [NSNumber numberWithInt:60];

		self.containerView = [[UIView alloc] init];
		[self.contentView addSubview:self.containerView];

		[self.containerView top:self.topAnchor padding:0];
		[self.containerView leading:self.leadingAnchor padding:0];
		[self.containerView trailing:self.trailingAnchor padding:0];
		[self.containerView bottom:self.bottomAnchor padding:0];


		self.colorWell2 = [[LADualColourControl alloc] init];
		self.colorWell2.title.text = @"Dark";
		[self.colorWell2 addTarget:self action:@selector(colourWell2Tapped) forControlEvents:UIControlEventTouchUpInside];
		[self.containerView addSubview:self.colorWell2];

		[self.colorWell2 size:CGSizeMake(37, 45)];
		[self.colorWell2 y:self.containerView.centerYAnchor];
		[self.colorWell2 trailing:self.containerView.trailingAnchor padding:-10];


		self.colorWell1 = [[LADualColourControl alloc] init];
		self.colorWell1.title.text = @"Light";
		[self.colorWell1 addTarget:self action:@selector(colourWell1Tapped) forControlEvents:UIControlEventTouchUpInside];
		[self.containerView addSubview:self.colorWell1];

		[self.colorWell1 size:CGSizeMake(37, 45)];
		[self.colorWell1 y:self.containerView.centerYAnchor];
		[self.colorWell1 trailing:self.colorWell2.leadingAnchor padding:-8];


		self.headerLabel = [[UILabel alloc] init];
		self.headerLabel.textAlignment = NSTextAlignmentLeft;
		self.headerLabel.textColor = UIColor.labelColor;
		self.headerLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
		self.headerLabel.numberOfLines = 1;
		self.headerLabel.text = specifier.properties[@"title"];
		[self.containerView addSubview:self.headerLabel];

		[self.headerLabel y:self.containerView.centerYAnchor];
		[self.headerLabel leading:self.containerView.leadingAnchor padding:10];
		[self.headerLabel trailing:self.colorWell1.leadingAnchor padding:-10];


		self.detailTextLabel.hidden = YES;
		self.textLabel.hidden = YES;

		[self updatePreview];

	}

	return self;
}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	[self updatePreview];

	[self.specifier setTarget:self];

	self.detailTextLabel.hidden = YES;
	self.textLabel.hidden = YES;
}


-(void)colourWell1Tapped {
	self.cpType = 0;
	[self presentColorPicker];
}


-(void)colourWell2Tapped {
	self.cpType = 1;
	[self presentColorPicker];
}


- (void)presentColorPicker {

	UIViewController *prefsController = [self _viewControllerForAncestor];

	NSString *key = self.specifier.properties[@"key"];

	if (@available(iOS 14.0, *)) {
		UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
		colourPickerVC.view.tintColor = [[LAPrefs shared] accentColour];
		colourPickerVC.delegate = self;
		if (self.cpType == 0) {
			NSString *lightKey = [NSString stringWithFormat:@"%@", [[LAPrefs shared] objectForKey:[NSString stringWithFormat:@"%@-Light", key] defaultValue:self.specifier.properties[@"lightFallback"] ID:self.specifier.properties[@"defaults"]]];
			colourPickerVC.selectedColor = [self colorWithHexString:lightKey];
		} else {
			NSString *darkKey = [NSString stringWithFormat:@"%@", [[LAPrefs shared] objectForKey:[NSString stringWithFormat:@"%@-Dark", key] defaultValue:self.specifier.properties[@"darkFallback"] ID:self.specifier.properties[@"defaults"]]];
			colourPickerVC.selectedColor = [self colorWithHexString:darkKey];
		}
		colourPickerVC.supportsAlpha = [self.specifier.properties[@"supportAlpha"] boolValue] ?: NO;
		[prefsController presentViewController:colourPickerVC animated:YES completion:nil];
	}

}


- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController API_AVAILABLE(ios(14.0)){

	UIColor *selectedColour = viewController.selectedColor;
	if (self.cpType == 0) {
		NSString *key = [NSString stringWithFormat:@"%@-Light", self.specifier.properties[@"key"]];
		[[LAPrefs shared] setObject:[self hexStringFromColor:selectedColour] forKey:key ID:self.specifier.properties[@"defaults"]];
	} else {
		NSString *key = [NSString stringWithFormat:@"%@-Dark", self.specifier.properties[@"key"]];
		[[LAPrefs shared] setObject:[self hexStringFromColor:selectedColour] forKey:key ID:self.specifier.properties[@"defaults"]];
	}
	[self updatePreview];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.0xkuj.liveactivities/colorPickerDidChangedNotification" object:nil userInfo:nil deliverImmediately:YES];
	});

}


- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController API_AVAILABLE(ios(14.0)){

	UIColor *selectedColour = viewController.selectedColor;
	if (self.cpType == 0) {
		NSString *key = [NSString stringWithFormat:@"%@-Light", self.specifier.properties[@"key"]];
		[[LAPrefs shared] setObject:[self hexStringFromColor:selectedColour] forKey:key ID:self.specifier.properties[@"defaults"]];
	} else {
		NSString *key = [NSString stringWithFormat:@"%@-Dark", self.specifier.properties[@"key"]];
		[[LAPrefs shared] setObject:[self hexStringFromColor:selectedColour] forKey:key ID:self.specifier.properties[@"defaults"]];
	}
	[self updatePreview];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.0xkuj.liveactivities/colorPickerDidChangedNotification" object:nil userInfo:nil deliverImmediately:YES];
	});

}


-(void)updatePreview {

	NSString *key = self.specifier.properties[@"key"];

	NSString *lightKey = [NSString stringWithFormat:@"%@", [[LAPrefs shared] objectForKey:[NSString stringWithFormat:@"%@-Light", key] defaultValue:self.specifier.properties[@"lightFallback"] ID:self.specifier.properties[@"defaults"]]];
	self.colorWell1.colorWell.backgroundColor = [self colorWithHexString:lightKey];

	NSString *darkKey = [NSString stringWithFormat:@"%@", [[LAPrefs shared] objectForKey:[NSString stringWithFormat:@"%@-Dark", key] defaultValue:self.specifier.properties[@"darkFallback"] ID:self.specifier.properties[@"defaults"]]];
	self.colorWell2.colorWell.backgroundColor = [self colorWithHexString:darkKey];
}


-(UIColor*)colorWithHexString:(NSString*)hex {

	if ([hex isEqualToString:@"red"]) {
		return UIColor.systemRedColor;
	} else if ([hex isEqualToString:@"orange"]) {
		return UIColor.systemOrangeColor;
	} else if ([hex isEqualToString:@"yellow"]) {
		return UIColor.systemYellowColor;
	} else if ([hex isEqualToString:@"green"]) {
		return UIColor.systemGreenColor;
	} else if ([hex isEqualToString:@"blue"]) {
		return UIColor.systemBlueColor;
	} else if ([hex isEqualToString:@"teal"]) {
		return UIColor.systemTealColor;
	} else if ([hex isEqualToString:@"indigo"]) {
		return UIColor.systemIndigoColor;
	} else if ([hex isEqualToString:@"purple"]) {
		return UIColor.systemPurpleColor;
	} else if ([hex isEqualToString:@"pink"]) {
		return UIColor.systemPinkColor;
	} else if ([hex isEqualToString:@"default"]) {
		return UIColor.labelColor;
	} else if ([hex isEqualToString:@"tertiary"]) {
		return UIColor.tertiaryLabelColor;
	} else {

		NSString *cleanString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
		if([cleanString length] == 3) {
			cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
			[cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
			[cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
			[cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
		}
		if([cleanString length] == 6) {
			cleanString = [cleanString stringByAppendingString:@"ff"];
		}

		unsigned int baseValue;
		[[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

		float red = ((baseValue >> 24) & 0xFF)/255.0f;
		float green = ((baseValue >> 16) & 0xFF)/255.0f;
		float blue = ((baseValue >> 8) & 0xFF)/255.0f;
		float alpha = ((baseValue >> 0) & 0xFF)/255.0f;

		return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
	}
}


- (NSString *)hexStringFromColor:(UIColor *)color {
	const CGFloat *components = CGColorGetComponents(color.CGColor);

	CGFloat r = components[0];
	CGFloat g = components[1];
	CGFloat b = components[2];
	CGFloat a = components[3];

	return [NSString stringWithFormat:@"%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255)];
}

@end
