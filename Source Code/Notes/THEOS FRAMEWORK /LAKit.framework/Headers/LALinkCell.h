#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "../PreferencesManager/LAPrefs.h"

@interface LALinkCell: PSTableCell
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UIColor *tintColour;
@end
