#import "NoteDataModel.h"

@implementation NoteDataModel

-(id)initWithTitle:(NSString *)title content:(NSString *)content creation:(NSDate *)creation modification:(NSDate *)modification {
    
    self = [super init];
    if(self) {
        
        self.title = title;
        self.content = content;
        self.creationDate = creation;
        self.modificationDate = modification;
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.content = [decoder decodeObjectForKey:@"content"];
        self.creationDate = [decoder decodeObjectForKey:@"creationDate"];
        self.modificationDate = [decoder decodeObjectForKey:@"modificationDate"];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.creationDate forKey:@"creationDate"];
    [encoder encodeObject:self.modificationDate forKey:@"modificationDate"];
}

@end
