#import <Preferences/Preferences.h>
#import "LAKit.h"
#import "LAContextMenuControl.h"

@interface LAContextMenuCell : PSTableCell
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) LAContextMenuControl *menuButton;
@property (nonatomic) NSInteger selectedIndex;
@end
