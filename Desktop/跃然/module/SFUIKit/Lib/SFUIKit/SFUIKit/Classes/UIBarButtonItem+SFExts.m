//
//  UIBarButtonItem+SFExts.m
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import "UIBarButtonItem+SFExts.h"
#import <objc/runtime.h>
#import "UIColor+SFExts.h"

@implementation UIBarButtonItem (SFExts)

static void *hx_buttonEventsBlockKey = &hx_buttonEventsBlockKey;

- (HX_BarItemEventsBlock)buttonEventsBlock {
    return objc_getAssociatedObject(self, &hx_buttonEventsBlockKey);
}

-(void)setButtonEventsBlock:(HX_BarItemEventsBlock)buttonEventsBlock {
    objc_setAssociatedObject(self, &hx_buttonEventsBlockKey, buttonEventsBlock, OBJC_ASSOCIATION_COPY);
}

/** 只有图片 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage edgeInsets:(UIEdgeInsets)insets target:(id)target action:(SEL)action {
    return [self itemWithImage:image highImage:highImage title:nil edgeInsets:insets target:target action:action];
}

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    return [self itemWithImage:image highImage:highImage title:nil target:target action:action];
}

/** 只有文字 */
+ (instancetype)itemWithTitle:(NSString *)title edgeInsets:(UIEdgeInsets)insets target:(id)target action:(SEL)action {
    return [self itemWithImage:nil highImage:nil title:title edgeInsets:insets target:target action:action];
}

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [self itemWithImage:nil highImage:nil title:title target:target action:action];
}

/** 图片 + 文字 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title edgeInsets:(UIEdgeInsets)insets target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor clearColor];
    
    if (image.length) {
        
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highImage.length) {
        [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    } else{
        //文字普通状态的颜色
        [button setTitleColor:[UIColor colorWithHexString:@"#2B2C2D"] forState:UIControlStateNormal];
        //文字高亮状态的颜色
        [button setTitleColor:[UIColor colorWithHexString:@"#2B2C2D"] forState:UIControlStateHighlighted];
    }
    //文字大小
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    
    //button size
    if (image.length) {
        button.bounds = CGRectMake(0, 0, 44, 44);
    } else {
        [button sizeToFit];
    }
    //按钮内容的内边距
    button.contentEdgeInsets = insets;
    
    //按钮内部 文字和图片的间距
    if (image.length) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action {
    return [self itemWithImage:image highImage:highImage title:title edgeInsets:UIEdgeInsetsZero target:target action:action];
}


@end
