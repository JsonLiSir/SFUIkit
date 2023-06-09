//
//  CALayer+SFExts.m
//  StarFish
//
//  Created by 李阳 on 2021/2/25.
//

#import "CALayer+SFExts.h"

@implementation CALayer (SFExts)

-(void)setBorderUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}
-(UIColor*)borderUIColor{
    return [UIColor colorWithCGColor:self.borderColor];
}
-(void)setShadowUIColor:(UIColor *)color{
    self.shadowColor = color.CGColor;
}
-(UIColor*)shadowUIColor{
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
