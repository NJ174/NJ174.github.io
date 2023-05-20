#import <Preferences/Preferences.h>
#import "LAKit.h"

@interface PSTableCell (PrivateColourPicker)
- (UIViewController *)_viewControllerForAncestor;
@end

@interface LAColorPickerCell : PSTableCell <UIColorPickerViewControllerDelegate>
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UIView *colorPreview;
@property (nonatomic, retain) UIColor *tintColour;
@end
