#import "LAPrefs.h"

@implementation LAPrefs

+(instancetype)shared {
  static LAPrefs *shared = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[LAPrefs alloc] init];
  });
  return shared;
}

-(id)init {
  return self;
}


- (void)setBool:(BOOL)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:[NSNumber numberWithBool:anObject] forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
  }
}


- (void)setObject:(id)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:anObject forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
  }
}


- (void)setFloat:(float)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:[NSNumber numberWithFloat:anObject] forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
  }
}


- (void)setInt:(int)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:@(anObject) forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
  }
}


- (void)setInteger:(NSInteger)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:@(anObject) forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
  }
}


- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }
  if([settings objectForKey:aKey] == NULL){
    return defaultValue;
  }
  return [[settings objectForKey:aKey] boolValue];
}


- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }
  return [settings objectForKey:aKey]?:defaultValue;
}


- (float)floatForKey:(id)aKey defaultValue:(float)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }
  return [[settings objectForKey:aKey] floatValue]?:defaultValue;
}


- (int)intForKey:(id)aKey defaultValue:(int)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }

  if ([settings objectForKey:aKey] != nil) {
    return [[settings objectForKey:aKey] intValue];
  }

  return defaultValue;
}


- (NSInteger)integerForKey:(id)aKey defaultValue:(NSInteger)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }

  if ([settings objectForKey:aKey] != nil) {
    return [[settings objectForKey:aKey] intValue];
  }

  return defaultValue;
}


- (bool)boolForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }
  return [[settings objectForKey:aKey] boolValue];
}


- (id)objectForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }
  return [settings objectForKey:aKey];
}


- (float)floatForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }
  return [settings objectForKey:aKey] ? [[settings objectForKey:aKey] floatValue] : 0;
}


- (int)intForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }
  return [[settings objectForKey:aKey] intValue];
}


- (NSInteger)integerForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }
  return [[settings objectForKey:aKey] intValue];
}


- (UIColor *)colourForKey:(id)aKey defaultColour:(NSString *)defaultColour ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  }

  UIColor *colour;

  if ([self objectForKey:aKey ID:bundleIdentifier] != nil) {
    colour = [self colorWithHexString:[self objectForKey:aKey ID:bundleIdentifier]];
  } else {
    colour = [self colorWithHexString:defaultColour];
  }

  return colour;
}


- (void)removeObjectForKey:aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings removeObjectForKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
  }
}


-(UIColor *)colorWithHexString:(NSString*)hex {

  if ([hex isEqualToString:@"red"]) {
    return UIColor.systemRedColor;
  } else if ([hex isEqualToString:@"orange"]) {
    return UIColor.systemOrangeColor;
  } else if ([hex isEqualToString:@"yellow"]) {
    return UIColor.systemYellowColor;
  } else if ([hex isEqualToString:@"green"]) {
    return UIColor.systemGreenColor;
  } else if ([hex isEqualToString:@"blue"]) {
    return UIColor.systemBlueColor;
  } else if ([hex isEqualToString:@"teal"]) {
    return UIColor.systemTealColor;
  } else if ([hex isEqualToString:@"indigo"]) {
    return UIColor.systemIndigoColor;
  } else if ([hex isEqualToString:@"purple"]) {
    return UIColor.systemPurpleColor;
  } else if ([hex isEqualToString:@"pink"]) {
    return UIColor.systemPinkColor;
  } else if ([hex isEqualToString:@"default"]) {
    return UIColor.labelColor;
  } else if ([hex isEqualToString:@"tertiary"]) {
    return UIColor.tertiaryLabelColor;
  } else {

    NSString *cleanString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
      cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
      [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
      [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
      [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
      cleanString = [cleanString stringByAppendingString:@"ff"];
    }

    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
  }
}


-(UIColor *)accentColour {
  return UIColor.systemOrangeColor;
}

@end
