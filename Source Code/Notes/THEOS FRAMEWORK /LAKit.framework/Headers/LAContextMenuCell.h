#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "../PreferencesManager/LAPrefs.h"
#import "LAContextMenuControl.h"
#import "../Extensions/LAKitConstraint.h"
#import "../Utils/NCCenter.h"

@interface LAContextMenuCell : PSTableCell
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) LAContextMenuControl *menuButton;
@property (nonatomic) NSInteger selectedIndex;
@end
