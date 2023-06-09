//
//  UILabel+SFExts.h
//  StarFish
//
//  Created by 李阳 on 2021/2/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (SFExts)

/** 富文本*/
+ (NSAttributedString *)attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle lineSpacing:(float)line paragraphSpacing:(float)paragraph;

+ (NSAttributedString *)attributedStringWithImage:(UIImage *)image imageBounds:(CGRect)bounds lineSpacing:(float)line paragraphSpacing:(float)paragraph;

+ (NSAttributedString *)jointAttributedStringWithItems:(NSArray *)items;

+(NSAttributedString *)attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle wordSpacing:(CGFloat)wordSpace lineSpacing:(float)line paragraphSpacing:(float)paragraph;

+ (NSAttributedString *)attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle wordSpacing:(CGFloat)wordSpace lineSpacing:(float)line paragraphSpacing:(float)paragraph  shadowColor:(UIColor *)shadowColor alignment:(NSTextAlignment)alignment ;

-(BOOL)isSingleLine;

@end

NS_ASSUME_NONNULL_END
