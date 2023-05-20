#import <Preferences/Preferences.h>
#import "LAStyleOptionView.h"
#import "LAKit.h"

@interface LAStyleCell : PSTableCell <LAStyleOptionViewDelegate>
@end

@interface PSSpecifier (PrivateMethods)
-(void)performSetterWithValue:(id)value;
-(id)performGetter;
@end
