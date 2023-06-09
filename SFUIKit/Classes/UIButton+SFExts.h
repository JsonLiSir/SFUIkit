//
//  UIButton+SFExts.h
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HX_ButtonEventsBlock)(void);

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (SFExts)

@property (strong ,nonatomic) NSDictionary *paramDic; // 用来传递参数
@property (nonatomic, copy) HX_ButtonEventsBlock buttonEventsBlock;

/** 方法回调*/
- (void)hx_addEventHandler:(void (^)(void))block forControlEvents:(UIControlEvents)controlEvents;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

/** 发送倒计时*/
- (void)changeSendCaptchaBtn;
/** 发送倒计时（xx秒后重新获取）*/
- (void)afterChangeSendCaptchaBtn;

/// 倒计时结束回调
- (void)changeSendCaptchaBtn:(dispatch_block_t)timerFinishedComplete;

@end

NS_ASSUME_NONNULL_END
