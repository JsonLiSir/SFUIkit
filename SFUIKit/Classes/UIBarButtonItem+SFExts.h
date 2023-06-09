//
//  UIBarButtonItem+SFExts.h
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HX_BarItemEventsBlock)(void);

@interface UIBarButtonItem (SFExts)

/** block*/
@property (nonatomic, copy) HX_BarItemEventsBlock buttonEventsBlock;

/** 只有图片(需要设置离屏幕的距离) */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage edgeInsets:(UIEdgeInsets)insets target:(id)target action:(SEL)action;
/** 只有图片(不需要设置离屏幕的距离) */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/** 只有文字(需要设置离屏幕的距离) */
+ (instancetype)itemWithTitle:(NSString *)title edgeInsets:(UIEdgeInsets)insets target:(id)target action:(SEL)action;
/** 只有文字(不需要设置离屏幕的距离) */
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  图片 + 文字 (不需要设置离屏幕的距离)
 *
 *  @param image       图片名称
 *  @param highImage   高亮图片名称
 *  @param title       文字
 *  @param insets      离屏幕的距离
 *  @param target      实现方法的代理
 *  @param action      实现方法
 *
 *  @return 返回一个 图片 + 文字 的UIBarButtonItem
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title edgeInsets:(UIEdgeInsets)insets target:(id)target action:(SEL)action;

/** 图片 + 文字(不需要设置离屏幕的距离) */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
