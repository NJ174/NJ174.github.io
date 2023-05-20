#import "NotesAppearance.h"
#import "LAKit.h"

@implementation UIColor (Appearance)

+(UIColor *)accentColour {
    return [[LAPrefs shared] colourForKey:@"accentColour" defaultColour:@"FFD60A" ID:BID];
}


+(UIColor *)titleColour {
    NSInteger appearance = [[LAPrefs shared] integerForKey:@"notesAppearance" defaultValue:0 ID:BID];
    if (appearance == 0) {
        return UIColor.labelColor;
    } else {
        return [[LAPrefs shared] colourForKey:@"notesTitleColour" defaultColour:@"FFFFFF" ID:BID];
    }
}


+(UIColor *)contentColour {
    NSInteger appearance = [[LAPrefs shared] integerForKey:@"notesAppearance" defaultValue:0 ID:BID];
    if (appearance == 0) {
        return UIColor.labelColor;
    } else {
        return [[LAPrefs shared] colourForKey:@"notesContentColour" defaultColour:@"FFFFFF" ID:BID];
    }
}

@end
