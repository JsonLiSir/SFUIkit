//
//  UILabel+ZTBLabel.m
//  ZTB
//
//  Created by Runing on 2019/10/15.
//  Copyright © 2019 ZM. All rights reserved.
//  XIB文字适应

#import "UILabel+ZTBLabel.h"
#import <objc/runtime.h>
#import "SFUIKit.h"

@implementation UILabel (ZTBLabel)

+ (void)load {
    Method method3 = class_getInstanceMethod([self class], @selector(dg_awakeFromNib));
    Method method4 = class_getInstanceMethod([self class], @selector(awakeFromNib));
    //1.如果返回成功:则说明被替换方法没有存在.也就是被替换的方法没有被实现,我们需要先把这个方法实现,然后再执行我们想要的效果,用我们自定义的方法去替换被替换的方法. 这里使用到的是class_replaceMethod这个方法. class_replaceMethod本身会尝试调用class_addMethod和method_setImplementation，所以直接调用class_replaceMethod就可以了)
    
    //2.如果返回失败:则说明被替换方法已经存在.直接将两个方法的实现交换即
    if (!class_addMethod([self class], @selector(awakeFromNib), method_getImplementation(method3), method_getTypeEncoding(method3))) {
        method_exchangeImplementations(method4, method3);
    } else {
        class_replaceMethod(self, @selector(dg_awakeFromNib), method_getImplementation(method4), method_getTypeEncoding(method4));
    }
}

- (void)dg_awakeFromNib {
    
    self.font = [UIFont fontWithDescriptor:self.font.fontDescriptor size:w(self.font.pointSize)];
}
@end
