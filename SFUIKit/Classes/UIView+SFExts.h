//
//  UIView+SFExts.h
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^tapViewBlock)(UIView *view);

@interface UIView (SFExts)

#pragma mark =============== 给view绑定事件 =================

/** 属性 **/
@property (nonatomic , copy)tapViewBlock actionBlock;
/**
 点击按钮事件
 @param actionBlock 回调方法
 */
- (void)tapView:(tapViewBlock)actionBlock;


/** 让控件抖动*/
- (void)loadShakeAnimation;

#pragma mark =============== frame =================

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

#pragma mark =============== 渐变色 =================
- (void)hx_setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors
                                 locations:(NSArray<NSNumber *> *_Nullable)locations
                                startPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint;

#pragma mark =============== 添加阴影 =================
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;

#pragma mark =============== 切圆角-设置边框颜色 =================
- (void)clipRadius:(CGFloat)radius
       bolderColor:(UIColor *)bolderColor
       bolderWidht:(CGFloat)bolderWidht;


// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen;

/**
 *切圆角
 *@param radios 角度
 *@param rects 需要切的边
 */
- (void)clipCornerViewRadios:(CGFloat)radios
                       rects:(UIRectCorner)rects;

@end

NS_ASSUME_NONNULL_END
