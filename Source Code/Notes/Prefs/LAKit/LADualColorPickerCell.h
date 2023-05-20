#import <Preferences/Preferences.h>
#import "LAKit.h"
#import "LADualColourControl.h"

@interface PSTableCell (PrivateColourPicker)
- (UIViewController *)_viewControllerForAncestor;
@end  

@interface LADualColorPickerCell : PSTableCell <UIColorPickerViewControllerDelegate>
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) LADualColourControl *colorWell1;
@property (nonatomic, retain) LADualColourControl *colorWell2;
@property (nonatomic) NSInteger cpType;
@end
