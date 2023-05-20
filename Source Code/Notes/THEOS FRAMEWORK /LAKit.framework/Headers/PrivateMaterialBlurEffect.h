#import <UIKit/UIKit.h>

@interface _UIBackdropView : UIView
-(id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3 ;
-(id)initWithSettings:(id)arg1 ;
-(id)initWithStyle:(long long)arg1 ;
- (void)setBlurFilterWithRadius:(float)arg1 blurQuality:(id)arg2 blurHardEdges:(int)arg3;
- (void)setBlurFilterWithRadius:(float)arg1 blurQuality:(id)arg2;
- (void)setBlurHardEdges:(int)arg1;
- (void)setBlurQuality:(id)arg1;
- (void)setBlurRadius:(float)arg1;
- (void)setBlurRadiusSetOnce:(BOOL)arg1;
- (void)setBlursBackground:(BOOL)arg1;
- (void)setBlursWithHardEdges:(BOOL)arg1;
@end

@interface _UIBackdropViewSettings : NSObject
@property (assign,getter=isEnabled,nonatomic) BOOL enabled;
@property (assign,nonatomic) double blurRadius;
@property (nonatomic,copy) NSString * blurQuality;
@property (assign,nonatomic) BOOL usesBackdropEffectView;
-(id)initWithDefaultValues;
+(id)settingsForStyle:(long long)arg1 ;
@end

typedef NS_ENUM(NSInteger, MTMaterialRecipe) {
  MTMaterialRecipeNone,
  MTMaterialRecipeNotifications,
  MTMaterialRecipeWidgetHosts,
  MTMaterialRecipeWidgets,
  MTMaterialRecipeControlCenterModules,
  MTMaterialRecipeSwitcherContinuityItem,
  MTMaterialRecipePreviewBackground,
  MTMaterialRecipeNotificationsDark,
  MTMaterialRecipeControlCenterModulesSheer
};

typedef NS_OPTIONS(NSUInteger, MTMaterialOptions) {
  MTMaterialOptionsNone             = 0,
  MTMaterialOptionsGamma            = 1 << 0,
  MTMaterialOptionsBlur             = 1 << 1,
  MTMaterialOptionsZoom             = 1 << 2,
  MTMaterialOptionsLuminanceMap     = 1 << 3,
  MTMaterialOptionsBaseOverlay      = 1 << 4,
  MTMaterialOptionsPrimaryOverlay   = 1 << 5,
  MTMaterialOptionsSecondaryOverlay = 1 << 6,
  MTMaterialOptionsAuxiliaryOverlay = 1 << 7,
  MTMaterialOptionsCaptureOnly      = 1 << 8
};

@interface MTMaterialView : UIView
@property (assign,nonatomic) BOOL shouldCrossfade;
@property (assign, nonatomic) BOOL recipeDynamic;
@property (nonatomic, assign, readwrite) NSUInteger recipe;
@property (assign,nonatomic) double weighting;
@property (assign,getter=isBlurEnabled,nonatomic) BOOL blurEnabled;
@property (assign,getter=isZoomEnabled,nonatomic) BOOL zoomEnabled;
@property (assign,getter=isCaptureOnly,nonatomic) BOOL captureOnly;
@property (assign,getter=isHighlighted,nonatomic) BOOL highlighted;
@property (assign,nonatomic) BOOL useBuiltInAlphaTransformerAndBackdropScaleAdjustment;
@property (assign,nonatomic) BOOL useBuiltInAlphaTransformerAndBackdropScaleAdjustmentIfNecessary;
+(instancetype)materialViewWithRecipeNamed:(NSString *)arg1 inBundle:(NSBundle *)arg2 configuration:(NSInteger)arg3 initialWeighting:(float)arg4 scaleAdjustment:(id)arg5;
+(instancetype)materialViewWithRecipe:(NSInteger)arg1 configuration:(NSInteger)arg2;
+(instancetype)materialViewWithRecipe:(NSInteger)arg1 options:(NSInteger)arg2;
+(id)materialViewWithRecipeNamed:(id)arg1 ;
-(void)setBlurEnabled:(BOOL)arg1 ;
-(BOOL)isHighlighted;
-(void)setHighlighted:(BOOL)arg1 ;
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

@interface SBHFeatherBlurView : UIView
-(id)initWithRecipe:(unsigned long long)arg1 ;
@end
