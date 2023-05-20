#import "LAKit.h"
#import "BaseBlurView.h"
#import "NTETextViewController.h"
#import "NoteDataModel.h"
#import "NotesAppearance.h"

@interface NTEContainerViewController : UIViewController <UIPageViewControllerDataSource, UIScrollViewDelegate, NTETextViewControllerDelegate, UITextFieldDelegate>
@property (nonatomic, retain) BaseBlurView *baseView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *icon;
@property (nonatomic, retain) UIButton *moreButton;
@property (nonatomic, retain) UITextField *titleTextField;
@property (nonatomic, retain) UIPageViewController *pageController;
@property (nonatomic, retain) NSMutableArray *pages;
@property (nonatomic, retain) NSMutableArray *notesArray;
@property (nonatomic, retain) UITextView *activeTextView;
@property (nonatomic) CGFloat notesHeight;
-(void)keyboardPresented:(CGSize)keyboardSize;
-(void)keyboardDismiss;
@end

@interface UIImage (Private)
+(id)_applicationIconImageForBundleIdentifier:(NSString*)displayIdentifier format:(int)form scale:(CGFloat)scale;
+(instancetype)kitImageNamed:(NSString *)arg1;
@end

@interface SBIdleTimerGlobalCoordinator : NSObject
+(instancetype)sharedInstance;
-(void)resetIdleTimer;
@end
