#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "../PreferencesManager/LAPrefs.h"

@interface LAHyperlinkCell : PSTableCell
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UIImageView *linkImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UIColor *tintColour;
@end
