//
//  UILabel+SFExts.m
//  StarFish
//
//  Created by 李阳 on 2021/2/19.
//

#import "UILabel+SFExts.h"

@implementation UILabel (SFExts)

// 1. 由文本生成attributedString
+ (NSAttributedString *)
attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle lineSpacing:(float)line paragraphSpacing:(float)paragraph {
   return  [self attributedStringWithText:text textColor:color textFont:font hasUnderlineStyle:hasUnderLineStyle wordSpacing:0 lineSpacing:line paragraphSpacing:paragraph];
}

+ (NSAttributedString *)attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle wordSpacing:(CGFloat)wordSpace lineSpacing:(float)line paragraphSpacing:(float)paragraph {
    if (!text || ![text isKindOfClass:NSString.class] || text.length == 0) {
        text = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSRange range = NSMakeRange(0, text.length);
    [paragraphStyle setLineSpacing:line];
    [paragraphStyle setParagraphSpacing:paragraph];
    [attributedString addAttribute:NSKernAttributeName value:@(wordSpace) range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    if (hasUnderLineStyle) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    }
    return attributedString;
}
+ (NSAttributedString *)attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle wordSpacing:(CGFloat)wordSpace lineSpacing:(float)line paragraphSpacing:(float)paragraph  shadowColor:(UIColor *)shadowColor alignment:(NSTextAlignment)alignment {
    if (!text || ![text isKindOfClass:NSString.class] || text.length == 0) {
        text = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSRange range = NSMakeRange(0, text.length);
    [paragraphStyle setLineSpacing:line];
    [paragraphStyle setParagraphSpacing:paragraph];
    paragraphStyle.alignment = alignment;
    [attributedString addAttribute:NSKernAttributeName value:@(wordSpace) range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 1.0;
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowColor = shadowColor;
    [attributedString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, attributedString.length)];
    if (hasUnderLineStyle) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    }
    return attributedString;
}
// 2. 由图片生成attributedString
+ (NSAttributedString *)attributedStringWithImage:(UIImage *)image imageBounds:(CGRect)bounds lineSpacing:(float)line paragraphSpacing:(float)paragraph {
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    NSMutableAttributedString *attachmentAttributedString = [[NSMutableAttributedString alloc]initWithAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSRange range = NSMakeRange(0, attachmentAttributedString.length);
    [paragraphStyle setLineSpacing:line];
    [paragraphStyle setParagraphSpacing:paragraph];
    [attachmentAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    return attachmentAttributedString;
}

// 3. 多个AttributedString拼接成一个resultAttributedString
+ (NSAttributedString *)jointAttributedStringWithItems:(NSArray *)items {
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] init];
    
    for (int i = 0; i < items.count; i++) {
        if ([items[i] isKindOfClass:[NSAttributedString class]]) {
            [resultAttributedString appendAttributedString:items[i]];
        }
    }
    
    return resultAttributedString;
}
- (BOOL)isSingleLine {
    CGRect stringRect=[self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    if(stringRect.size.height>self.font.lineHeight) {
        return NO;
    } else {
        return YES;
    }
}

@end
