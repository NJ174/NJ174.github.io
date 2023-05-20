#import "BaseBlurView.h"

@implementation BaseBlurView

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
        [[NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/MaterialKit.framework"] load];
        
        self.clipsToBounds = YES;
        
        self.blurView = [NSClassFromString(@"MTMaterialView") materialViewWithRecipe:1 configuration:0];
        self.blurView.weighting = 1;
        self.blurView.highlighted = NO;
        self.blurView.recipeDynamic = YES;
        self.blurView.zoomEnabled = YES;
        self.blurView.alpha = 0;
        [self addSubview:self.blurView];
        [self.blurView fill];
        
        [self updatingAppearance];
    }
    return self;
}


-(void)updatingAppearance {
    NSInteger appearance = [[LAPrefs shared] integerForKey:@"notesAppearance" defaultValue:0 ID:BID];
    if (appearance == 0) {
        self.blurView.alpha = 1;
        self.backgroundColor = UIColor.clearColor;
    } else if (appearance == 1) {
        self.blurView.alpha = 0;
        self.backgroundColor = [[LAPrefs shared] colourForKey:@"notesBackgroundColour" defaultColour:@"000000" ID:BID];
    }
}


-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self updatingAppearance];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self updatingAppearance];
    });
}

@end

/*
 MTMaterialRecipeNone = 0,
 MTMaterialRecipeNotifications = 1,
 MTMaterialRecipeWidgetHosts = 2,
 MTMaterialRecipeWidgets = 3,
 MTMaterialRecipeControlCenterModules = 4,
 MTMaterialRecipePreviewBackground = 6,
 MTMaterialRecipeNotificationsDark = 7,
 MTMaterialRecipeControlCenterModulesSheer = 8,
 MTMaterialRecipeSiriPlatter = 9,
 MTMaterialRecipeSiriPlatterSheer = 10,
 MTMaterialRecipeSiriDialogue = 11,
 MTMaterialRecipeSpotlightPlatter = 12,
 MTMaterialRecipeSpotlightPlatterSheer = 13,
 MTMaterialRecipeSpotlightBackground = 14,
 MTMaterialRecipeCarPlayNotifications = 15,
 MTMaterialRecipeSiriBackground = 16,
 MTMaterialRecipeSleepPlatter = 17,
 MTMaterialRecipeSleepPlatterSheer = 18,
 MTMaterialRecipeDock = 19,
 MTMaterialRecipeSystemChromeBackground = 50,
 MTMaterialRecipeSystemVibrantBackgroundUltraThin = 51,
 MTMaterialRecipeSystemVibrantBackgroundThin = 52,
 MTMaterialRecipeSystemVibrantBackgroundRegular = 53,
 MTMaterialRecipeSystemVibrantBackgroundThick = 54,
 */
