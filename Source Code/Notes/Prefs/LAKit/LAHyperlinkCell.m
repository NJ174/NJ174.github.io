#import "LAHyperlinkCell.h"

@implementation LAHyperlinkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		specifier.properties[@"height"] = [NSNumber numberWithInt:60];

		self.tintColour = [[LAPrefs shared] accentColour];

		NSString *customIconPath = [NSString stringWithFormat:@"/Library/PreferenceBundles/LiveActivityPrefs.bundle/%@.png", specifier.properties[@"pngIcon"]];


		self.iconImage = [[UIImageView alloc]init];
		self.iconImage.image = [[UIImage imageWithContentsOfFile:customIconPath]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		self.iconImage.clipsToBounds = true;
		[self addSubview:self.iconImage];

		self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
		[self.iconImage.widthAnchor constraintEqualToConstant:40.0].active = YES;
		[self.iconImage.heightAnchor constraintEqualToConstant:40.0].active = YES;
		[[self.iconImage centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.iconImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;


		self.linkImage = [[UIImageView alloc]init];
		self.linkImage.image = [UIImage systemImageNamed:specifier.properties[@"accessoriesSFIcon"]];
		self.linkImage.contentMode = UIViewContentModeScaleAspectFit;
		self.linkImage.tintColor =  UIColor.tertiaryLabelColor;
		[self addSubview:self.linkImage];

		self.linkImage.translatesAutoresizingMaskIntoConstraints = NO;
		[self.linkImage.widthAnchor constraintEqualToConstant:16].active = YES;
		[self.linkImage.heightAnchor constraintEqualToConstant:16].active = YES;
		[[self.linkImage centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.linkImage.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;


		self.headerLabel = [[UILabel alloc] init];
		self.headerLabel.textColor = self.tintColour;
		[self.headerLabel setText:specifier.properties[@"title"]];
		[self.headerLabel setFont:[self.headerLabel.font fontWithSize:17]];
		[self addSubview:self.headerLabel];

		self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.headerLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor constant:-10].active = true;
		[self.headerLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:10].active = YES;
		[self.headerLabel.trailingAnchor constraintEqualToAnchor:self.linkImage.leadingAnchor constant:-10].active = YES;


		self.subtitleLabel = [[UILabel alloc]init];
		self.subtitleLabel.textColor = UIColor.secondaryLabelColor;
		[self.subtitleLabel setText:specifier.properties[@"subtitle"]];
		[self.subtitleLabel setFont:[self.subtitleLabel.font fontWithSize:12]];
		[self addSubview:self.subtitleLabel];

		self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.subtitleLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor constant:10].active = true;
		[self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:10].active = YES;
		[self.subtitleLabel.trailingAnchor constraintEqualToAnchor:self.linkImage.leadingAnchor constant:-10].active = YES;
	}

	return self;
}

@end
