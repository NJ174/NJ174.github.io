#import "LADualColourControl.h"

@implementation LADualColourControl

-(instancetype)init {

  self = [super init];
  if (self) {

    self.colorWell = [[UIView alloc] init];
    self.colorWell.layer.cornerRadius = 17.5;
    self.colorWell.clipsToBounds = YES;
    self.colorWell.layer.borderWidth = 1.0;
    self.colorWell.layer.borderColor = [[LAPrefs shared] accentColour].CGColor;
    self.colorWell.backgroundColor = UIColor.whiteColor;
    self.colorWell.userInteractionEnabled = NO;
    [self addSubview:self.colorWell];

    [self.colorWell size:CGSizeMake(35, 35)];
    [self.colorWell x:self.centerXAnchor];
    [self.colorWell top:self.topAnchor padding:0];


    self.title = [[UILabel alloc] init];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = [[LAPrefs shared] accentColour];
    self.title.font = [UIFont systemFontOfSize:9 weight:UIFontWeightSemibold];
    self.title.numberOfLines = 1;
    [self addSubview:self.title];

    [self.title x:self.centerXAnchor];
    [self.title top:self.colorWell.bottomAnchor padding:1.5];
    [self.title leading:self.leadingAnchor padding:0];
    [self.title trailing:self.trailingAnchor padding:0];

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
