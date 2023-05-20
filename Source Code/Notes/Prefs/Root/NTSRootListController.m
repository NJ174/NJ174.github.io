#include "NTSRootListController.h"
#import <spawn.h>

@implementation NTSRootListController

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	UIWindow *keyWindow = nil;
	NSArray *windows = [[UIApplication sharedApplication] windows];
	for (UIWindow *window in windows) {
		if (window.isKeyWindow) {
			keyWindow = window;
			break;
		}
	}

	keyWindow.tintColor = [[LAPrefs shared] accentColour];

	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(respring:)];
	self.navigationItem.rightBarButtonItem = applyButton;
}


-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

	UIWindow *keyWindow = nil;
	NSArray *windows = [[UIApplication sharedApplication] windows];
	for (UIWindow *window in windows) {
		if (window.isKeyWindow) {
			keyWindow = window;
			break;
		}
	}

	keyWindow.tintColor = [[UINavigationBar appearance] tintColor];
}


-(void)viewDidLoad {
	[super viewDidLoad];

	self.navigationController.navigationBar.prefersLargeTitles = NO;

	LAHeaderView *header = [[LAHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 175)];
	UITableView *tableView = [self valueForKey:@"_table"];
	tableView.tableHeaderView = header;
}


- (id)readPreferenceValue:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}
}

- (void)respring:(id)sender {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Respring" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
		pid_t pid;
		const char* args[] = {"killall", "backboardd", NULL};
		posix_spawn(&pid, "/var/jb/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No" style: UIAlertActionStyleCancel handler:^(UIAlertAction * action) { return; }];

	[alertController addAction:confirmAction];
	[alertController addAction:cancelAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

@end
