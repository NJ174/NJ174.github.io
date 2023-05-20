#import "LAContextMenuControl.h"

@implementation LAContextMenuControl

-(instancetype)init {

  self = [super init];
  if (self) {

    self.icon = [[UIImageView alloc] init];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    self.icon.tintColor = UIColor.secondaryLabelColor;
    self.icon.image = [UIImage systemImageNamed:@"chevron.up.chevron.down"];
    [self addSubview:self.icon];

    [self.icon size:CGSizeMake(20, 20)];
    [self.icon y:self.centerYAnchor];
    [self.icon trailing:self.trailingAnchor padding:0];


    self.title = [[UILabel alloc] init];
    self.title.textAlignment = NSTextAlignmentRight;
    self.title.textColor = UIColor.secondaryLabelColor;
    self.title.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [self addSubview:self.title];

    [self.title y:self.centerYAnchor];
    [self.title trailing:self.icon.leadingAnchor padding:-5];
    [self.title leading:self.leadingAnchor padding:0];


    self.btn = [[UIButton alloc] init];
    [self addSubview:self.btn];
    [self.btn fill];

  }

  return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  [self touchAnimateWithHighlighted:YES];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self touchAnimateWithHighlighted:NO];
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  [self touchAnimateWithHighlighted:NO];
}


-(void)touchAnimateWithHighlighted:(BOOL)isHighlighted {

  [UIView animateWithDuration:0.1 animations:^{
    self.alpha = isHighlighted ? 0.8 : 1;
    self.transform = isHighlighted ? CGAffineTransformMakeScale(0.98 ,0.98) : CGAffineTransformMakeScale(1 ,1);
  }];

}

@end
