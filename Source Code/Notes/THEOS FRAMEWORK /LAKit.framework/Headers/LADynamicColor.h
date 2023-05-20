#import <UIKit/UIKit.h>

@interface UIColor (LADynamicColor)
+(UIColor *)dynamicForKey:(NSString *)key lightDefault:(NSString *)lightDefault darkDefault:(NSString *)darkDefault ID:(NSString *)bid;
@end