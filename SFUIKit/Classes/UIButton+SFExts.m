//
//  UIButton+SFExts.m
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import "UIButton+SFExts.h"
#import <objc/runtime.h>

@implementation UIButton (SFExts)

static void *hx_buttonEventsBlockKey = &hx_buttonEventsBlockKey;

- (HX_ButtonEventsBlock)buttonEventsBlock {
    return objc_getAssociatedObject(self, &hx_buttonEventsBlockKey);
}

-(void)setButtonEventsBlock:(HX_ButtonEventsBlock)buttonEventsBlock {
    objc_setAssociatedObject(self, &hx_buttonEventsBlockKey, buttonEventsBlock, OBJC_ASSOCIATION_COPY);
}
-(NSDictionary *)paramDic{
    return objc_getAssociatedObject(self, _cmd);
    
}
-(void)setParamDic:(NSDictionary *)paramDic{
    objc_setAssociatedObject(self, @selector(paramDic), paramDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
/**
 给按钮绑定事件回调block
 
 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)hx_addEventHandler:(void (^)(void))block forControlEvents:(UIControlEvents)controlEvents {
    self.buttonEventsBlock = block;
    [self addTarget:self action:@selector(hx_blcokButtonClicked) forControlEvents:controlEvents];
}

// 按钮点击
- (void)hx_blcokButtonClicked {
    if (self.buttonEventsBlock) self.buttonEventsBlock();
}
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
 
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            labelWidth = self.titleLabel.intrinsicContentSize.width;
            labelHeight = self.titleLabel.intrinsicContentSize.height;
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2.0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            //labelWidth = self.titleLabel.frame.size.width;
            //labelHeight = self.titleLabel.frame.size.height;
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            labelWidth = self.titleLabel.intrinsicContentSize.width;
            labelHeight = self.titleLabel.intrinsicContentSize.height;
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWidth, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            labelWidth = self.titleLabel.frame.size.width;
//            labelHeight = self.titleLabel.frame.size.height;
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-space/2.0, 0, imageWidth+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

/** 发送倒计时*/
- (void)changeSendCaptchaBtn {
    
    __block int countdown = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        /** 倒计时未结束 */
        if (countdown > 0) {
            countdown--;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = NO;
                if (!self.selected) self.selected = YES;
                [self setTitle:[NSString stringWithFormat:@"%ds重新获取", countdown] forState:UIControlStateNormal];
            });
        } else { /** 倒计时结束 */
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = YES;
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                self.selected = NO;
            });
        }
    });
    dispatch_resume(timer);
}

/** 发送倒计时（xx秒后重新获取）*/
- (void)afterChangeSendCaptchaBtn {
    
    __block int countdown = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        /** 倒计时未结束 */
        if (countdown > 0) {
            countdown--;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = NO;
                if (!self.selected) self.selected = YES;
                [self setTitle:[NSString stringWithFormat:@"%ds后重新获取", countdown] forState:UIControlStateNormal];
            });
        } else { /** 倒计时结束 */
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = YES;
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                self.selected = NO;
            });
        }
    });
    dispatch_resume(timer);
}

- (void)changeSendCaptchaBtn:(dispatch_block_t)timerFinishedComplete {
    
    __block int countdown = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        /** 倒计时未结束 */
        if (countdown > 0) {
            countdown--;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = NO;
                if (!self.selected) self.selected = YES;
                [self setTitle:[NSString stringWithFormat:@"%ds重新获取", countdown] forState:UIControlStateNormal];
            });
        } else { /** 倒计时结束 */
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = YES;
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                self.selected = NO;
                if (timerFinishedComplete) {
                    timerFinishedComplete();
                }
            });
        }
    });
    dispatch_resume(timer);
}

@end
