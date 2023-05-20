#import "LAContextMenuCell.h"

@implementation LAContextMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		specifier.properties[@"height"] = [NSNumber numberWithInt:44];

		NSArray *values = specifier.properties[@"validTitles"];
		self.menuButton = [[LAContextMenuControl alloc] init];
		self.menuButton.title.text = [values objectAtIndex:[[LAPrefs shared] integerForKey:specifier.properties[@"key"] defaultValue:[specifier.properties[@"default"] integerValue] ID:specifier.properties[@"defaults"]]];
		self.menuButton.btn.showsMenuAsPrimaryAction = YES;
		NSString *msg = [NSString stringWithFormat:@"%@ %@", specifier.properties[@"title"], specifier.properties[@"message"] ?: @""];
		self.menuButton.btn.menu = [self contextMenuOptions:msg array:values specifier:specifier];
		self.menuButton.backgroundColor = UIColor.clearColor;
		self.menuButton.icon.tintColor = [[LAPrefs shared] accentColour];
		self.menuButton.title.textColor = [[LAPrefs shared] accentColour];
		[self addSubview:self.menuButton];

		[self.menuButton size:CGSizeMake(120, 35)];
		[self.menuButton y:self.centerYAnchor];
		[self.menuButton trailing:self.trailingAnchor padding:-12];


		self.headerLabel = [[UILabel alloc] init];
		self.headerLabel.textColor = UIColor.labelColor;
		self.headerLabel.text = specifier.properties[@"title"];
		self.headerLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
		[self addSubview:self.headerLabel];

		self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.headerLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.headerLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
		[self.headerLabel.trailingAnchor constraintEqualToAnchor:self.menuButton.leadingAnchor constant:-10].active = YES;

		self.selectedIndex = [[LAPrefs shared] integerForKey:specifier.properties[@"key"] defaultValue:[specifier.properties[@"default"] integerValue] ID:specifier.properties[@"defaults"]];
	}

	return self;
}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	[self.specifier setTarget:self];

	NSArray *values = self.specifier.properties[@"validTitles"];
	self.menuButton.title.text = [values objectAtIndex:[[LAPrefs shared] integerForKey:self.specifier.properties[@"key"] defaultValue:[self.specifier.properties[@"default"] integerValue] ID:self.specifier.properties[@"defaults"]]];
	NSString *msg = [NSString stringWithFormat:@"%@ %@", self.specifier.properties[@"title"], self.specifier.properties[@"message"] ?: @""];
	self.menuButton.btn.menu = [self contextMenuOptions:msg array:values specifier:self.specifier];
	self.selectedIndex = [[LAPrefs shared] integerForKey:self.specifier.properties[@"key"] defaultValue:[self.specifier.properties[@"default"] integerValue] ID:self.specifier.properties[@"defaults"]];

	self.detailTextLabel.hidden = YES;
	self.textLabel.hidden = YES;
}


-(UIMenu *)contextMenuOptions:(NSString *)title array:(NSArray *)array specifier:(PSSpecifier *)specifier {

	self.selectedIndex = [[LAPrefs shared] integerForKey:specifier.properties[@"key"] defaultValue:[specifier.properties[@"default"] integerValue] ID:specifier.properties[@"defaults"]];
	NSMutableArray* actions = [[NSMutableArray alloc] init];

	for (int i = 0; i < [array count]; i++) {

		[actions addObject:[UIAction actionWithTitle:[array objectAtIndex:i] image:i == self.selectedIndex ? [UIImage systemImageNamed:@"checkmark"] : nil identifier:nil handler:^(UIAction *action) {
			[self didSelectOptionAtIndex:i];
		}]];
	}

	return [UIMenu menuWithTitle:title children:actions];
}


-(void)didSelectOptionAtIndex:(NSInteger)index {
	self.selectedIndex = index;
	NSArray *values = self.specifier.properties[@"validTitles"];
	self.menuButton.title.text = [values objectAtIndex:index];
	[[LAPrefs shared] setInteger:index forKey:self.specifier.properties[@"key"] ID:self.specifier.properties[@"defaults"]];
	NSString *msg = [NSString stringWithFormat:@"%@ %@", self.specifier.properties[@"title"], self.specifier.properties[@"message"] ?: @""];
	self.menuButton.btn.menu = [self contextMenuOptions:msg array:values specifier:self.specifier];

	NSString *notification = self.specifier.properties[@"postNotification"];
	if (notification != nil) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			[[NSDistributedNotificationCenter defaultCenter] postNotificationName:notification object:nil userInfo:nil deliverImmediately:YES];
		});
	}

}

@end
