//
//  UIView+SFToast.h
//  StarFish
//
//  Created by 李阳 on 2021/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SFToast)

// each makeToast method creates a view and displays it as toast
- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title isRotate:(BOOL)rotate;
// displays toast with an activity spinner
- (void)makeToastActivity;
- (void)makeToastActivity:(id)position;
- (void)hideToastActivity;

// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point;

// -Abe---
// showToast Class methods display on current window
+ (void)showToast:(NSString *)message;
+ (void)showToast:(NSString *)message duration:(CGFloat)interval position:(id)position;
+ (void)showToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title;
+ (void)showToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title image:(UIImage *)image;
+ (void)showToast:(NSString *)message duration:(CGFloat)interval position:(id)position image:(UIImage *)image;
- (void)showToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title isRotate:(BOOL)rotate;

@end

NS_ASSUME_NONNULL_END
