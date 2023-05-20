#import <Preferences/PSSwitchTableCell.h>
#import <Preferences/PSSpecifier.h>
#import "../PreferencesManager/LAPrefs.h"

@interface UIImage (Private)
+(instancetype)kitImageNamed:(NSString *)arg1;
@end

@interface UIView (Private)
-(UIViewController *)_viewControllerForAncestor;
@end

@interface LAInfoSwitchCell : PSSwitchTableCell
@property (nonatomic, retain) UILabel *headerLabel;
@end
