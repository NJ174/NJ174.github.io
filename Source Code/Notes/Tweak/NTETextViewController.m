#import "NTETextViewController.h"

@implementation NTETextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = UIColor.clearColor;
    
    [self layoutTextView];
}


-(void)layoutTextView {
    
    NSInteger alignment = [[LAPrefs shared] integerForKey:@"notesTextAlignment" defaultValue:0 ID:BID];
    
    self.noteTextView = [[UITextView alloc] init];
    if (alignment == 0) {
        self.noteTextView.textAlignment = NSTextAlignmentLeft;
    } else if (alignment == 1) {
        self.noteTextView.textAlignment = NSTextAlignmentCenter;
    } else if (alignment == 2) {
        self.noteTextView.textAlignment = NSTextAlignmentRight;
    }
    self.noteTextView.allowsEditingTextAttributes = YES;
    self.noteTextView.attributedText = self.text;
    self.noteTextView.backgroundColor = UIColor.clearColor;
    self.noteTextView.clipsToBounds = YES;
    self.noteTextView.contentInset = UIEdgeInsetsZero;
    self.noteTextView.textContainerInset = UIEdgeInsetsMake(10, 5, 10, 5);
    self.noteTextView.font = [UIFont systemFontOfSize:[self fontSize]];
    self.noteTextView.scrollEnabled = YES;
    self.noteTextView.textColor = UIColor.contentColour;
    self.noteTextView.tintColor = UIColor.accentColour;
    self.noteTextView.delegate = self;
    [self.view addSubview:self.noteTextView];
    [self.noteTextView fill];
}


-(CGFloat)fontSize {
    NSInteger size = [[LAPrefs shared] integerForKey:@"notesFontSize" defaultValue:0 ID:BID];
    
    if (size == 0) {
        return 14;
    } else if (size == 1) {
        return 15;
    } else if (size == 2) {
        return 16;
    } else if (size == 3) {
        return 17;
    } else if (size == 4) {
        return 18;
    } else if (size == 5) {
        return 19;
    } else if (size == 6) {
        return 20;
    } else if (size == 7) {
        return 15;
    } else if (size == 8) {
        return 21;
    } else if (size == 9) {
        return 22;
    } else if (size == 10) {
        return 23;
    } else if (size == 11) {
        return 24;
    } else {
        return 14;
    }
}


-(void)textViewDidBeginEditing:(UITextView *)textView {
    [self.delegate textViewDidBeginEditing:textView];
}


-(void)textViewDidEndEditing:(UITextView *)textView {
    [self.delegate textViewDidEndEditing:textView];
}


-(void)textViewDidChange:(UITextView *)textView {
    [self.delegate textViewDidChange:textView];
}


-(void)textViewDidChangeSelection:(UITextView *)textView {
    [self.delegate textViewDidChangeSelection:textView];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return [self.delegate textViewShouldBeginEditing:textView];
}

@end
