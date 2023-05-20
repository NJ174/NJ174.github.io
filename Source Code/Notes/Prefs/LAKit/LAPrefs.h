#import <UIKit/UIKit.h>

static NSString *BID = @"com.nj174.notesprefs";

@interface LAPrefs : NSObject
+(instancetype)shared;
-(id)init;
- (void)setBool:(BOOL)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setObject:(id)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setFloat:(float)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setInt:(int)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setInteger:(NSInteger)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue ID:(NSString*)bundleIdentifier;
- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue ID:(NSString*)bundleIdentifier;
- (float)floatForKey:(id)aKey defaultValue:(float)defaultValue ID:(NSString*)bundleIdentifier;
- (int)intForKey:(id)aKey defaultValue:(int)defaultValue ID:(NSString*)bundleIdentifier;
- (NSInteger)integerForKey:(id)aKey defaultValue:(NSInteger)defaultValue ID:(NSString*)bundleIdentifier;
- (bool)boolForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (id)objectForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (float)floatForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (int)intForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (NSInteger)integerForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (UIColor *)colourForKey:(id)aKey defaultColour:(NSString *)defaultColour ID:(NSString*)bundleIdentifier;
- (void)removeObjectForKey:(id)aKey ID:(NSString*)bundleIdentifier;
-(UIColor *)accentColour;
@end
