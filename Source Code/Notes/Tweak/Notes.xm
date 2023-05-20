#import "LAKit.h"
#import "NTEContainerViewController.h"

@interface CSCoverSheetViewController : UIViewController
@end

@interface CSScrollView : UIScrollView
-(void)hideNotes;
@end

NTEContainerViewController *noteVC;


%group NotesHook
%hook CSCoverSheetViewController

-(void)viewDidLoad {
  %orig;

    CGFloat notesYOffset = [[LAPrefs shared] floatForKey:@"notesYOffset" defaultValue:400 ID:BID];
    CGFloat notesHeight = [[LAPrefs shared] floatForKey:@"notesHeight" defaultValue:150 ID:BID];

    noteVC = [[NTEContainerViewController alloc] init];
    noteVC.view.frame = CGRectMake(12.5, notesYOffset, self.view.frame.size.width-25, notesHeight);
    [self.view addSubview:noteVC.view];
    [noteVC didMoveToParentViewController:self];

    [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.nj174.notes-hide" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            noteVC.view.alpha = 0;
        } completion:nil];
        [[LAPrefs shared] setBool:YES forKey:@"isNotesHidden" ID:BID];
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

%new
-(void)keyboardWillShow:(NSNotification *)notification {
  CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.020 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
  [noteVC keyboardPresented:keyboardSize];
  });
}

%new
-(void)keyboardWillHide:(NSNotification *)notification {
  [noteVC keyboardDismiss];
}

%end


%hook CSScrollView

-(instancetype)initWithFrame:(CGRect)arg1 {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNotes)];
    tapGesture.numberOfTapsRequired = 3;
    [self addGestureRecognizer:tapGesture];
    return %orig;
}

%new
-(void)hideNotes {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        noteVC.view.alpha = 1;
    } completion:nil];
    [[LAPrefs shared] setBool:NO forKey:@"isNotesHidden" ID:BID];
}

%end
%end

%ctor {
  if ([[LAPrefs shared] boolForKey:@"enableNotes" defaultValue:YES ID:BID]) {
   %init(NotesHook);
  }
}
