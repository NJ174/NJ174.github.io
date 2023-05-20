#import "LAKit.h"
#import "NotesAppearance.h"

@protocol NTETextViewControllerDelegate <NSObject>
-(void)textViewDidBeginEditing:(UITextView *)textView;
-(void)textViewDidEndEditing:(UITextView *)textView;
-(void)textViewDidChange:(UITextView *)textView;
-(void)textViewDidChangeSelection:(UITextView *)textView;
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView;
@end

@interface NTETextViewController : UIViewController <UITextViewDelegate>
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) UITextView *noteTextView;
@property (nonatomic, retain) NSAttributedString *text;
@property (nonatomic, weak) id<NTETextViewControllerDelegate> delegate;
@end
