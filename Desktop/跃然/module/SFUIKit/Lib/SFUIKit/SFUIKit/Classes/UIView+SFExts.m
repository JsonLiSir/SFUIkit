//
//  UIView+SFExts.m
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import "UIView+SFExts.h"
#import <objc/runtime.h>

@implementation UIView (SFExts)

#pragma mark =============== 给view绑定事件 =================

- (void)setActionBlock:(tapViewBlock)actionBlock{
    objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.userInteractionEnabled = YES;
}
- (tapViewBlock)actionBlock{
    return objc_getAssociatedObject(self, @selector(actionBlock));
}

#pragma mark =============== 方法实现 ===============
- (void)tapView:(tapViewBlock)actionBlock{
    self.actionBlock = actionBlock;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)]];
}
#pragma mark =============== 点击事件 ===============
- (void)click{
    if (self.actionBlock) self.actionBlock(self);
}

/** 让控件抖动*/
- (void)loadShakeAnimation {
    CALayer *lbl = [self layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen {

    if(!self || self.hidden || !self.superview) return NO;
    CGRect screenRect = [UIScreen mainScreen].bounds;
    //转换view对应window的Rect
    CGRect rect = [self convertRect:self.bounds toView:[UIApplication sharedApplication].keyWindow];

    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) return NO;

    //若size 为CGRectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) return NO;

    if (rect.origin.y < 24 || rect.origin.y > screenRect.size.height - 69) return NO;
    //获取 该view 与window 交叉的Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);

    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) return NO;
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) return NO;

    return YES;
}

#pragma mark =============== Frame =================

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark =============== 渐变色 =================
- (void)hx_setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors
                                 locations:(NSArray<NSNumber *> *_Nullable)locations
                                startPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint {
    [self layoutIfNeeded];
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    [gradLayer setColors:colorsM];
    [gradLayer setLocations:locations];
    gradLayer.startPoint=startPoint;
    gradLayer.endPoint=endPoint;
    gradLayer.frame = self.bounds;
    [self.layer addSublayer:gradLayer];
}

#pragma mark =============== 添加阴影 =================
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
}

#pragma mark =============== 切圆角-设置边框颜色 =================
- (void)clipRadius:(CGFloat)radius
       bolderColor:(UIColor *)bolderColor
       bolderWidht:(CGFloat)bolderWidht {
    //切圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    //设置边框
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = maskPath.CGPath;
    borderLayer.fillColor = UIColor.clearColor.CGColor;
    borderLayer.strokeColor = bolderColor.CGColor;
    borderLayer.lineWidth = bolderWidht;
    borderLayer.frame = self.bounds;
    [self.layer addSublayer:borderLayer];
}

- (void)clipCornerViewRadios:(CGFloat)radios
                 rects:(UIRectCorner)rects {
    CGRect bounds = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:rects cornerRadii:CGSizeMake(radios, radios)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    [self.layer addSublayer:maskLayer];
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}

@end
