//
//  UIViewController+Navigation.h
//  SFLoginModule
//
//  Created by zhouxr on 2021/5/13.
//


NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Navigation)

/// 是否初始化当前视图加载
- (void)navigationPushVc:(UIViewController *)pushVc animated:(BOOL)animation isMissSelf:(BOOL)isMissSelf;

/// 回到根试图
+(void)popToRootIndex:(NSInteger)index isAnimated:(BOOL)animated completion: (void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
