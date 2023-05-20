#import "NTEContainerViewController.h"

static CGFloat currentNotesYOffset = 0.0;
static NSString *notesPath = @"/var/mobile/Library/Preferences/com.nj174.notes.plist";

@implementation NTEContainerViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    self.view.clipsToBounds = YES;
    self.view.layer.cornerRadius = 22;
    self.view.layer.cornerCurve = kCACornerCurveContinuous;
    self.view.backgroundColor = UIColor.clearColor;

    if ([[LAPrefs shared] boolForKey:@"enableBorderColour" defaultValue:NO ID:BID]) {
        self.view.layer.borderColor = [[LAPrefs shared] colourForKey:@"notesBorderColour" defaultColour:@"FFD60A" ID:BID].CGColor;
        self.view.layer.borderWidth = [[LAPrefs shared] floatForKey:@"notesBorderWidth" defaultValue:1 ID:BID];
    }

    self.notesHeight = [[LAPrefs shared] floatForKey:@"notesHeight" defaultValue:150 ID:BID];

    self.baseView = [[BaseBlurView alloc] init];
    [self.view addSubview:self.baseView];
    [self.baseView fill];


    self.headerView = [[UIView alloc] init];
    if ([[LAPrefs shared] boolForKey:@"enableHeaderColour" defaultValue:NO ID:BID]) {
        self.headerView.backgroundColor = [[LAPrefs shared] colourForKey:@"notesHeaderColour" defaultColour:@"FFD60A" ID:BID];
    }
    [self.view addSubview:self.headerView];

    [self.headerView height:40];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.topAnchor padding:0];
    [self.headerView leading:self.view.leadingAnchor padding:0];
    [self.headerView trailing:self.view.trailingAnchor padding:0];


    self.icon = [[UIImageView alloc] init];
    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.cornerCurve = kCACornerCurveContinuous;
    self.icon.clipsToBounds = YES;
    self.icon.image = [UIImage _applicationIconImageForBundleIdentifier:@"com.apple.mobilenotes" format:2 scale:[UIScreen mainScreen].scale];
    [self.headerView addSubview:self.icon];

    [self.icon size:CGSizeMake(25, 25)];
    [self.icon y:self.headerView.centerYAnchor];
    [self.icon leading:self.headerView.leadingAnchor padding:15];


    self.moreButton = [[UIButton alloc] init];
    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:20 weight:UIImageSymbolWeightSemibold scale:UIImageSymbolScaleMedium];
    UIImage *btnImage = [UIImage systemImageNamed:@"ellipsis.circle" withConfiguration:configuration];
    [self.moreButton setImage:btnImage forState:UIControlStateNormal];
    self.moreButton.tintColor = [[LAPrefs shared] colourForKey:@"accentColour" defaultColour:@"FFD60A" ID:BID];
    self.moreButton.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    self.moreButton.showsMenuAsPrimaryAction = YES;
    self.moreButton.menu = [self moreMenu];
    [self.headerView addSubview:self.moreButton];

    [self.moreButton size:CGSizeMake(25, 25)];
    [self.moreButton y:self.headerView.centerYAnchor];
    [self.moreButton trailing:self.headerView.trailingAnchor padding:-15];


    self.titleTextField = [[UITextField alloc] init];
    self.titleTextField.backgroundColor = UIColor.clearColor;
    self.titleTextField.placeholder = @"Title...";
    self.titleTextField.font = [UIFont systemFontOfSize:14];
    self.titleTextField.textColor = UIColor.titleColour;
    self.titleTextField.delegate = self;
    self.titleTextField.returnKeyType = UIReturnKeyDone;
    self.titleTextField.tintColor = UIColor.accentColour;
    [self.headerView addSubview:self.titleTextField];

    [self.titleTextField width:self.view.frame.size.width/2];
    [self.titleTextField y:self.headerView.centerYAnchor];
    [self.titleTextField leading:self.icon.trailingAnchor padding:7.5];


    self.pages = [[NSMutableArray alloc] init];
    self.notesArray = [self loadNotesArray];

    NSInteger sortType = [[LAPrefs shared] integerForKey:@"notesSortType" defaultValue:3 ID:BID];

    if (sortType == 0) {
        [self.notesArray sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"modificationDate" ascending:NO]]];
    } else if (sortType == 1) {
        [self.notesArray sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]]];
    } else if (sortType == 2) {
        [self.notesArray sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES]]];
    } else if (sortType == 3) {
        [self.notesArray sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"content" ascending:YES]]];
    }


    [self layoutPageVC];


    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNotesPan:)];
    [self.headerView addGestureRecognizer:panGesture];
}


-(void)reloadNotes {

    [self.pages removeAllObjects];
    [self.notesArray removeAllObjects];
    self.notesArray = [self loadNotesArray];

    NSInteger sortType = [[LAPrefs shared] integerForKey:@"notesSortType" defaultValue:0 ID:BID];

    if (sortType == 0) {
        [self.notesArray sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"modificationDate" ascending:NO]]];
    } else if (sortType == 1) {
        [self.notesArray sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]]];
    } else if (sortType == 2) {
        [self.notesArray sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES]]];
    } else if (sortType == 3) {
        [self.notesArray sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"content" ascending:YES]]];
    }

    for (int i = 0; i < self.notesArray.count; i++) {
        NoteDataModel *data = self.notesArray[i];
        NTETextViewController *vc = [[NTETextViewController alloc] init];
        vc.index = i;
        vc.text = [[NSMutableAttributedString alloc] initWithString:data.content];
        vc.delegate = self;
        [self.pages addObject:vc];
    }


    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pageController setViewControllers:@[self.pages[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        NoteDataModel *data = self.notesArray[0];
        self.titleTextField.text = data.title;
    });

    [self disablePageScroll:NO];
    self.moreButton.menu = [self moreMenu];
}


-(void)layoutPageVC {

    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{@"UIPageViewControllerOptionInterPageSpacingKey" : @10}];
    self.pageController.dataSource = self;
    [self.view addSubview:self.pageController.view];
    [self.pageController.view top:self.headerView.bottomAnchor padding:0];
    [self.pageController.view leading:self.view.leadingAnchor padding:0];
    [self.pageController.view trailing:self.view.trailingAnchor padding:0];
    [self.pageController.view bottom:self.view.bottomAnchor padding:0];

    [self.pageController didMoveToParentViewController:self];

    for (int i = 0; i < self.notesArray.count; i++) {

        NoteDataModel *data = self.notesArray[i];

        NTETextViewController *vc = [[NTETextViewController alloc] init];
        vc.index = i;
        vc.text = [[NSMutableAttributedString alloc] initWithString:data.content];
        vc.delegate = self;
        [self.pages addObject:vc];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pageController setViewControllers:@[self.pages[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        NoteDataModel *data = self.notesArray[0];
        self.titleTextField.text = data.title;
    });

    [self disablePageScroll:NO];


    for (UIView *v in self.pageController.view.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)v).delegate = self;
        }
    }


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    if ([self.activeTextView isFirstResponder] || [self.titleTextField isFirstResponder]) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = [UIScreen mainScreen].bounds.size.height - self.view.frame.size.height - keyboardSize.height - 20;
            self.view.frame = f;
        }];
    }
}


-(void)keyboardWillHide:(NSNotification *)notification {
    CGFloat notesYOffset = [[LAPrefs shared] floatForKey:@"notesYOffset" defaultValue:400 ID:BID];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = notesYOffset;
        self.view.frame = f;
    }];
}


-(void)keyboardPresented:(CGSize)keyboardSize {
    if ([self.activeTextView isFirstResponder] || [self.titleTextField isFirstResponder]) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = [UIScreen mainScreen].bounds.size.height - self.view.frame.size.height - keyboardSize.height - 20;
            self.view.frame = f;
        }];
    }
}


-(void)keyboardDismiss {
    CGFloat notesYOffset = [[LAPrefs shared] floatForKey:@"notesYOffset" defaultValue:400 ID:BID];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = notesYOffset;
        self.view.frame = f;
    }];
}


-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    [[NSClassFromString(@"SBIdleTimerGlobalCoordinator") sharedInstance] resetIdleTimer];

    NSInteger index = [(NTETextViewController *)viewController index];
    if(index == 0 || index == NSNotFound) {
        index = self.pages.count;
    }
    index--;

    return [self childViewControllerAtIndex:index];
}


-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    [[NSClassFromString(@"SBIdleTimerGlobalCoordinator") sharedInstance] resetIdleTimer];

    NSInteger index = [(NTETextViewController *)viewController index];
    index++;
    if(index == self.pages.count) {
        index = 0;
    }

    return [self childViewControllerAtIndex:index];
}


-(NTETextViewController *)childViewControllerAtIndex:(NSInteger)index {
    for(NTETextViewController *viewController in self.pages) {
        if(viewController.index == index) {
            return viewController;
        }
    }

    return nil;
}


-(NSInteger)indexOfCurrentViewController {
    return ((NTETextViewController *)self.pageController.viewControllers[0]).index;
}


-(void)disablePageScroll:(BOOL)pageScroll {
    if(self.pages.count == 1) {
        pageScroll = YES;
    }

    for(UIView *view in self.pageController.view.subviews) {
        if([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).scrollEnabled = !pageScroll;
        }
    }
}



-(void)addPage {
    NSInteger pageIndexToInsertAt = [self indexOfCurrentViewController] + 1;

    for(NTETextViewController *viewController in self.pages) {
        if(viewController.index >= pageIndexToInsertAt) {
            viewController.index++;
        }
    }

    NoteDataModel *data = [[NoteDataModel alloc] initWithTitle:@"Title" content:@"" creation:[NSDate date] modification:[NSDate date]];

    NTETextViewController *viewController = [[NTETextViewController alloc] init];
    viewController.index = pageIndexToInsertAt;
    viewController.text = [[NSMutableAttributedString alloc] initWithString:data.content];
    viewController.delegate = self;
    [self.notesArray insertObject:data atIndex:pageIndexToInsertAt];
    [self.pages insertObject:viewController atIndex:pageIndexToInsertAt];
    [self saveNotesArray:self.notesArray];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pageController setViewControllers:@[self.pages[pageIndexToInsertAt]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        self.titleTextField.text = data.title;
    });

    [self disablePageScroll:NO];
}


-(void)removePage {
    if(self.pages.count == 1) {
        return;
    }

    NSInteger pageIndexToRemove = [self indexOfCurrentViewController];
    NSInteger pageIndexToMoveTo = (pageIndexToRemove == 0) ? 0 : pageIndexToRemove - 1;

    [self.pages removeObject:[self childViewControllerAtIndex:pageIndexToRemove]];
    [self.notesArray removeObjectAtIndex:pageIndexToRemove];

    for(NTETextViewController *viewController in self.pages) {
        if(viewController.index > pageIndexToRemove) {
            viewController.index--;
        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pageController setViewControllers:@[self.pages[pageIndexToMoveTo]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    });

    [self saveNotesArray:self.notesArray];
    [self disablePageScroll:NO];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updatingTitle];
    });
}


-(void)updatingTitle {
    if (self.notesArray.count >0) {
        NoteDataModel *data = self.notesArray[[self indexOfCurrentViewController]];
        self.titleTextField.text = data.title ?: @"";
        self.moreButton.menu = [self moreMenu];
    }
    [[NSClassFromString(@"SBIdleTimerGlobalCoordinator") sharedInstance] resetIdleTimer];
}


-(void)textViewDidBeginEditing:(UITextView *)textView {
    self.activeTextView = textView;
    [[NSClassFromString(@"SBIdleTimerGlobalCoordinator") sharedInstance] resetIdleTimer];
    [self disablePageScroll:YES];
}


-(void)textViewDidEndEditing:(UITextView *)textView {
    self.activeTextView = nil;

    [self saveNotes];
    [self disablePageScroll:NO];
}


-(void)textViewDidChange:(UITextView *)textView {
    [[NSClassFromString(@"SBIdleTimerGlobalCoordinator") sharedInstance] resetIdleTimer];
}


-(void)textViewDidChangeSelection:(UITextView *)textView {
    [[NSClassFromString(@"SBIdleTimerGlobalCoordinator") sharedInstance] resetIdleTimer];
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    UIToolbar *bar = [[UIToolbar alloc] init];
    bar.tintColor = UIColor.accentColour;
    [bar sizeToFit];

    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    [buttons addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage kitImageNamed:@"kb-undoHUD-undo"] style:UIBarButtonItemStylePlain target:self action:@selector(undoButtonAction)]];
    [buttons addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage kitImageNamed:@"kb-undoHUD-redo"] style:UIBarButtonItemStylePlain target:self action:@selector(redoButtonAction)]];
    [buttons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [buttons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)]];
    [bar setItems:buttons animated:YES];
    textView.inputAccessoryView = bar;

    return YES;
}


-(void)undoButtonAction {
    if([[self.activeTextView undoManager] canUndo]) {
        [[self.activeTextView undoManager] undo];
    }
}


-(void)redoButtonAction {
    if([[self.activeTextView undoManager] canRedo]) {
        [[self.activeTextView undoManager] redo];
    }
}


-(void)dismissKeyboard {
    [self.activeTextView resignFirstResponder];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self saveNotes];
}


-(void)shareNotes {

    NTETextViewController *vc = self.pages[[self indexOfCurrentViewController]];
    NSString *notesTitle = self.titleTextField.text;
    NSString *notesContent = vc.noteTextView.attributedText.string;
    NSString *content = [NSString stringWithFormat:@"%@ \n%@", notesTitle, notesContent];

    NSArray *items = @[content];
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    controller.view.tintColor = UIColor.accentColour;
    [self presentViewController:controller animated:YES completion:nil];
}


-(void)handleNotesPan:(UIPanGestureRecognizer *)gesture {

    CGPoint translation = [gesture translationInView:self.view];

    if (gesture.state == UIGestureRecognizerStateBegan) {
        currentNotesYOffset = self.view.frame.origin.y;
    }


    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {

        self.view.frame = CGRectMake(self.view.frame.origin.x, currentNotesYOffset+translation.y, self.view.frame.size.width, self.notesHeight);

    } else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateFailed) {

        if (self.view.frame.origin.y < 50) {
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.view.frame = CGRectMake(self.view.frame.origin.x, 50, self.view.frame.size.width, self.notesHeight);
            } completion:nil];
        } else if (self.view.frame.origin.y > [[UIScreen mainScreen] bounds].size.height - self.notesHeight - 50) {
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.view.frame = CGRectMake(self.view.frame.origin.x, [[UIScreen mainScreen] bounds].size.height - self.notesHeight - 50, self.view.frame.size.width, self.view.frame.size.height);}
                             completion:nil];
        }

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [[LAPrefs shared] setFloat:self.view.frame.origin.y forKey:@"notesYOffset" ID:BID];
        });

    }

}


-(void)saveNotes {
    NoteDataModel *data = self.notesArray[[self indexOfCurrentViewController]];
    NTETextViewController *vc = self.pages[[self indexOfCurrentViewController]];
    NSString *notesTitle = self.titleTextField.text;
    NSString *notesContent = vc.noteTextView.attributedText.string;
    data.title = notesTitle;
    data.content = notesContent;
    data.modificationDate = [NSDate date];
    [self saveNotesArray:self.notesArray];
}


-(NSMutableArray *)loadNotesArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:notesPath]){

        array = [NSKeyedUnarchiver unarchiveObjectWithFile:notesPath];

        if (array.count == 0) {
            NSMutableArray *new = [NSMutableArray new];
            [new addObject:[[NoteDataModel alloc] initWithTitle:@"Title" content:@"" creation:[NSDate date] modification:[NSDate date]]];
            array = [new mutableCopy];
        } else {
            array = [NSKeyedUnarchiver unarchiveObjectWithFile:notesPath];
        }

    } else {
        NSMutableArray *new = [NSMutableArray new];
        [new addObject:[[NoteDataModel alloc] initWithTitle:@"Title" content:@"" creation:[NSDate date] modification:[NSDate date]]];
        array = [new mutableCopy];
    }

    return array;
}


-(void)saveNotesArray:(NSMutableArray *)array {
    [NSKeyedArchiver archiveRootObject:array toFile:notesPath];
}


-(UIMenu *)moreMenu {

    NSInteger sortType = [[LAPrefs shared] integerForKey:@"notesSortType" defaultValue:0 ID:BID];

    UIAction *modificationAction = [UIAction actionWithTitle:@"Modification Date" image:sortType == 0 ? [UIImage systemImageNamed:@"checkmark"] : nil identifier:nil handler:^(UIAction *action) {
        [[LAPrefs shared] setInteger:0 forKey:@"notesSortType" ID:BID];
        [self reloadNotes];
    }];

    UIAction *creationAction = [UIAction actionWithTitle:@"Creation Date" image:sortType == 1 ? [UIImage systemImageNamed:@"checkmark"] : nil identifier:nil handler:^(UIAction *action) {
        [[LAPrefs shared] setInteger:1 forKey:@"notesSortType" ID:BID];
        [self reloadNotes];
    }];

    UIAction *titleAction = [UIAction actionWithTitle:@"Notes Title" image:sortType == 2 ? [UIImage systemImageNamed:@"checkmark"] : nil identifier:nil handler:^(UIAction *action) {
        [[LAPrefs shared] setInteger:2 forKey:@"notesSortType" ID:BID];
        [self reloadNotes];
    }];

    UIAction *contentAction = [UIAction actionWithTitle:@"Notes Content" image:sortType == 3 ? [UIImage systemImageNamed:@"checkmark"] : nil identifier:nil handler:^(UIAction *action) {
        [[LAPrefs shared] setInteger:3 forKey:@"notesSortType" ID:BID];
        [self reloadNotes];
    }];

    UIMenu *sortMenu = [UIMenu menuWithTitle:@"Sort by" image:[UIImage systemImageNamed:@"list.bullet.indent"] identifier:nil options:UIMenuOptionsSingleSelection children:@[modificationAction, creationAction, titleAction, contentAction]];


    UIAction *shareAction = [UIAction actionWithTitle:@"Share" image:[UIImage systemImageNamed:@"square.and.arrow.up"] identifier:nil handler:^(UIAction *action) {
        if (self.activeTextView) {
            [self dismissKeyboard];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self shareNotes];
        });
    }];

    UIAction *hideAction = [UIAction actionWithTitle:@"Hide" image:[UIImage systemImageNamed:@"eye.slash"] identifier:nil handler:^(UIAction *action) {
        if (self.activeTextView) {
            [self dismissKeyboard];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.nj174.notes-hide" object:nil userInfo:nil deliverImmediately:YES];
        });
    }];

    UIAction *newAction = [UIAction actionWithTitle:@"New Note" image:[UIImage systemImageNamed:@"plus"] identifier:nil handler:^(UIAction *action) {
        [self addPage];
    }];

    UIAction *deleteAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash.fill"] identifier:nil handler:^(UIAction *action) {
        [self removePage];
    }];
    deleteAction.attributes = UIMenuElementAttributesDestructive;

    if (self.notesArray.count > 1) {
        return [UIMenu menuWithTitle:@"Notes" children:@[sortMenu, shareAction, hideAction, newAction, deleteAction]];
    } else {
        return [UIMenu menuWithTitle:@"Notes" children:@[sortMenu, shareAction, hideAction, newAction]];
    }
}

@end
