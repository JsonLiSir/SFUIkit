//
//  UIViewController+Navigation.m
//  SFLoginModule
//
//  Created by zhouxr on 2021/5/13.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

- (void)navigationPushVc:(UIViewController *)pushVc animated:(BOOL)animation isMissSelf:(BOOL)isMissSelf {
    if(isMissSelf)  {
        NSMutableArray *vcArr=[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [vcArr addObject:pushVc];
        [vcArr removeObject:self];
        [self.navigationController setViewControllers:vcArr animated:animation];
    } else {
        [self.navigationController pushViewController:pushVc animated:animation];
    }
}

+(void)popToRootIndex:(NSInteger)index isAnimated:(BOOL)animated completion: (void (^ _Nullable)(void))completion {
    if([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:NSClassFromString(@"SFBaseTabBarController")]) {
        
        UITabBarController *tabBarVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        [tabBarVc dismissViewControllerAnimated:animated completion:completion];
        
        for(UINavigationController *nav in tabBarVc.viewControllers) {
            [nav popToRootViewControllerAnimated:NO];
        }
        
        tabBarVc.selectedIndex=index;
        
        if(((UINavigationController *)tabBarVc.viewControllers[index]).delegate)  {

            [((UINavigationController *)tabBarVc.viewControllers[index]).delegate navigationController:((UINavigationController *)tabBarVc.viewControllers[index]) willShowViewController:((UINavigationController *)tabBarVc.viewControllers[index]).topViewController animated:NO];
        }//dismiss的之前先调用导航控制器pop到当前页不会调用navgation的delegate方法导致navationbar隐藏不正确,所以要手动调用一次
    }
}

@end
