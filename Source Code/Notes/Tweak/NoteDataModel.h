#import <UIKit/UIKit.h>

@interface NoteDataModel : NSObject <NSCoding>
-(id)initWithTitle:(NSString *)title content:(NSString *)content creation:(NSDate *)creation modification:(NSDate *)modification;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *creationDate;
@property (strong, nonatomic) NSDate *modificationDate;
@end
