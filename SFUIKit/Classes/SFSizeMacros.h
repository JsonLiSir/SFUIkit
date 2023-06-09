//
//  Header.h
//  StarFish
//
//  Created by 李阳 on 2021/4/25.
//

#ifndef SFSizeMacros_h
#define SFSizeMacros_h


#pragma mark =============== 屏幕尺寸 =================
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width    //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height  //屏幕高度
#define StateBar_HEIGHT self.navigationController.navigationBar.frame.size.height
#define TopHeight (self.navigationController.navigationBar.frame.size.height+[UIApplication sharedApplication].statusBarFrame.size.height) //顶部导航高度
#define  SF_tabHeight   (SCREEN_HEIGHT >= 812 ? 83 : 49)
#define  SF_navHeight   (SF_EXTRA_AREA_INSET_WITH_VIEW().top + 44)
#define  SF_navTopY     (SCREEN_HEIGHT >= 812 ? 24 : 0)

#define w(X) ((SCREEN_WIDTH) * ((X) / 375.0))     // 适配屏幕宽度（以375为基准iphone6）

#pragma mark =============== 字体大小、样式 =================

#define UIFontMake(fontSize) [UIFont systemFontOfSize:fontSize]
#define UIFontBoldMake(fontSize) [UIFont boldSystemFontOfSize:fontSize]

#define sfSemibold(s)     [UIFont systemFontOfSize:w(s) weight:UIFontWeightSemibold]
#define sfRegular(s)     [UIFont systemFontOfSize:w(s) weight:UIFontWeightRegular]
#define sfMedium(s)     [UIFont systemFontOfSize:w(s) weight:UIFontWeightMedium]

#pragma mark - placeHolder
#define sfPlaceHolderColor(string,size,color)  [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size],NSForegroundColorAttributeName:color}]
#define UIColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]
#define kHexColorA(c, a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]

#pragma mark =============== collection =================
#define loadingCell(_CellName_) *cell = [tableView dequeueReusableCellWithIdentifier:@(_CellName_)];\
cell.selectionStyle=UITableViewCellSelectionStyleNone;\
if (cell == nil) {\
[tableView registerNib:[UINib nibWithNibName:@(_CellName_) bundle:nil] forCellReuseIdentifier:@(_CellName_)];\
cell = [tableView dequeueReusableCellWithIdentifier:@(_CellName_)];\
cell.selectionStyle=UITableViewCellSelectionStyleNone;\
}

#pragma mark =============== 内联函数 =================
/**  图片 */
NS_INLINE UIImage *SF_LOAD_IMAGE(NSString *imageName) {
    return [UIImage imageNamed:imageName];
}


/**  判断是否为 iPhone X */
NS_INLINE BOOL SF_IS_IPHONEX() {
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[UIApplication sharedApplication] delegate].window;
        return mainWindow.safeAreaInsets.bottom > 0;
    }else{
        return NO;
    }
}

/**  RGB转颜色 */
NS_INLINE UIColor *SF_RGB_COLOR(NSInteger r, NSInteger g, NSInteger b) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

/**  RGBA转颜色 */
NS_INLINE UIColor *SF_RGBA_COLOR(NSInteger r, NSInteger g, NSInteger b, CGFloat a) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0];
}

/**  安全区域*/
NS_INLINE UIEdgeInsets SF_EXTRA_AREA_INSET_WITH_VIEW() {
     if (@available(iOS 11.0, *)) {
         UIWindow *mainWindow = [[UIApplication sharedApplication] delegate].window;
         return mainWindow.safeAreaInsets;
     }
    return UIEdgeInsetsMake([UIApplication sharedApplication].statusBarFrame.size.height, 0, 0, 0);
}

/**  获取当前window */
NS_INLINE UIWindow * SF_MainWindow(void) {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    } else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}

/**  获取当前vc */
NS_INLINE UIViewController *SF_TopViewController() {
    UIViewController *topViewController = SF_MainWindow().rootViewController;
    UIViewController *temp = nil;

    while (YES) {
        temp = nil;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            temp = ((UINavigationController *)topViewController).visibleViewController;
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            temp = ((UITabBarController *)topViewController).selectedViewController;
        }
        else if (topViewController.presentedViewController != nil) {
            temp = topViewController.presentedViewController;
        }
        
        if (temp != nil) {
            topViewController = temp;
        } else {
            break;
        }
    }
    
    return topViewController;
}

#endif /* SFSizeMacros_h */
