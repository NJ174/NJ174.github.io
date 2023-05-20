#import "LAHeaderView.h"

@implementation LAHeaderView

-(instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    UIImageView *bannerImage = [[UIImageView alloc] init];
    bannerImage.clipsToBounds = YES;
    bannerImage.contentMode = UIViewContentModeScaleAspectFill;
    bannerImage.layer.cornerRadius = 13;
    bannerImage.image = [UIImage imageWithContentsOfFile:@"/var/jb/Library/PreferenceBundles/NotesPrefs.bundle/banner.png"];
    [self addSubview:bannerImage];

    [bannerImage top:self.topAnchor padding:10];
    [bannerImage leading:self.leadingAnchor padding:15];
    [bannerImage trailing:self.trailingAnchor padding:-15];
    [bannerImage bottom:self.bottomAnchor padding:0];

  }

  return self;
}

@end
