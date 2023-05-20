#import "LALinkCell.h"

@implementation LALinkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		self.iconImage = [[UIImageView alloc]init];
		self.iconImage.image = [UIImage systemImageNamed:specifier.properties[@"sfIcon"]];
		self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
		self.iconImage.tintColor = [[LAPrefs shared] accentColour];
		[self addSubview:self.iconImage];

		self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
		[self.iconImage.widthAnchor constraintEqualToConstant:29].active = YES;
		[self.iconImage.heightAnchor constraintEqualToConstant:29].active = YES;
		[[self.iconImage centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.iconImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12].active = YES;


		self.headerLabel = [[UILabel alloc] init];
		self.headerLabel.textColor = UIColor.labelColor;
		self.headerLabel.text = specifier.properties[@"title"];
		self.headerLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
		[self addSubview:self.headerLabel];

		self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.headerLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor constant:0].active = true;
		[self.headerLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:10].active = YES;

	}

	return self;
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

		NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

		if ([cString length] < 6) return [UIColor grayColor];

		if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];

		if ([cString length] != 6) return  [UIColor grayColor];

		NSRange range;
		range.location = 0;
		range.length = 2;
		NSString *rString = [cString substringWithRange:range];

		range.location = 2;
		NSString *gString = [cString substringWithRange:range];

		range.location = 4;
		NSString *bString = [cString substringWithRange:range];

		unsigned int r, g, b;
		[[NSScanner scannerWithString:rString] scanHexInt:&r];
		[[NSScanner scannerWithString:gString] scanHexInt:&g];
		[[NSScanner scannerWithString:bString] scanHexInt:&b];

		return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
	}
}

@end
