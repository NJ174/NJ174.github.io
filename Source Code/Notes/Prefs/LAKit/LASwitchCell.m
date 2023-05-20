#import "LASwitchCell.h"

@implementation LASwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {
		((UISwitch *)self.control).onTintColor = [[LAPrefs shared] accentColour];
	}

	return self;
}

@end
