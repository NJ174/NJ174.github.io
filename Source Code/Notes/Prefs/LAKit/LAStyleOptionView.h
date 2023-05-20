#import <Preferences/Preferences.h>
#import "LAKit.h"

@class LAStyleOptionView;
@protocol LAStyleOptionViewDelegate <NSObject>
-(void)selectedOption:(LAStyleOptionView *)option;
@end

@interface LAStyleOptionView : UIView
@property (nonatomic, weak) id<LAStyleOptionViewDelegate> delegate;
@property (nonatomic, retain) id appearanceOption;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, retain) UIImageView *previewImageView;
@property (nonatomic, retain) UIImage *previewImage;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIColor *tintColour;
-(id)initWithFrame:(CGRect)frame appearanceOption:(id)option;
-(void)updateViewForAppearance:(NSString *)style;
@end
