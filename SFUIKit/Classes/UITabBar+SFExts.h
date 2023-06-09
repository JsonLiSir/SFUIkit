//
//  UITabBar+SFExts.h
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (SFExts)

- (void)showBadgeOnItemIndex:(int)index badgeTitle:(NSString *)title; // 展示小红点
- (void)hideBadgeOnItemIndex:(int)index; // 隐藏小红点
- (void)showBadgeOnItemIndex:(int)index; // 展示小红点

@end

NS_ASSUME_NONNULL_END
