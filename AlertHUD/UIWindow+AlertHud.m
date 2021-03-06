//
//  UIWindow+AlertHud.m
//  AlertHUD
//
//  Created by POWER on 14/11/4.
//  Copyright (c) 2014年 power. All rights reserved.
//

#import "UIWindow+AlertHud.h"

#import "AlertHudBackgroundView.h"
#import "AlertHudLabel.h"

#define AlertHUDBounds CGRectMake(0, 0, 100, 50)
#define AlertHUDCenter CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
#define AlertHUDBackgroundAlpha 1
#define AlertHUDComeTime 0.25
#define AlertHUDStayTime 1.5
#define AlertHUDGoTime 0.25
#define AlertHUDFont 17

@implementation UIWindow (AlertHud)

-(void)showHUDWithText:(NSString *)text Enabled:(BOOL)enabled
{
    
    [self showHUDWithText:text Enabled:enabled Center:AlertHUDCenter BackgroundAlpha:AlertHUDBackgroundAlpha CoumeTime:AlertHUDComeTime StayTime:AlertHUDStayTime Go:AlertHUDGoTime];
}

- (void)showHUDWithText:(NSString *)text Bounds:(CGRect)bounds Enabled:(BOOL)enabled
{
    [self showHUDWithText:text Enabled:enabled Center:AlertHUDCenter BackgroundAlpha:AlertHUDBackgroundAlpha CoumeTime:AlertHUDComeTime StayTime:AlertHUDStayTime Go:AlertHUDGoTime];
}


- (void)showHUDWithText:(NSString *)text Enabled:(BOOL)enabled Center:(CGPoint)center BackgroundAlpha:(CGFloat)Alpha CoumeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime Go:(CGFloat)goTime
{

    CGRect bounds = CGRectMake(0, 0, [self widthOfString:text withFont:[UIFont systemFontOfSize:AlertHUDFont]]+30, 50);
    
    [self addSubview:[AlertHudBackgroundView shareHudView]];
    [self addSubview:[AlertHudLabel shareHudView]];
    
    [AlertHudBackgroundView shareHudView].center = center;
    [AlertHudLabel shareHudView].center = CGPointMake(center.x, center.y);
    
    [AlertHudLabel shareHudView].bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height/2);
    
    self.userInteractionEnabled = enabled;
    
    [self showTextWith:text Enable:enabled Bounds:bounds Center:center BackgroundAlpha:Alpha ComeTime:comeTime StayTime:stayTime GoTime:goTime];
    
}

- (void)showTextWith:(NSString *)text  Enable:(BOOL)enable Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime
{
    
    [AlertHudLabel shareHudView].text = text;
    
    [UIView animateWithDuration:comeTime animations:^{
        
        [self comeTimeBounds:bounds];
        [self comeTimeAlpha:backgroundAlpha withImage:YES];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:stayTime animations:^{
            
            [self stayTimeAlpha:backgroundAlpha];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:goTime animations:^{
                
                [self goTimeBounds:bounds];
                [self goTimeInit];
                
            } completion:^(BOOL finished) {
                //Nothing
            }];
        }];
        
    }];
}

#pragma mark 状态

-(void)goTimeBounds:(CGRect)bounds{
    
    [AlertHudBackgroundView shareHudView].bounds =
    CGRectMake(0, 0, bounds.size.width * 1.5, bounds.size.height * 1.5);
}

-(void)goTimeInit{
    
    [AlertHudBackgroundView shareHudView].alpha = 0;
    [AlertHudLabel shareHudView].alpha = 0;
    
}

-(void)stayTimeAlpha:(CGFloat)alpha{
    
    [AlertHudBackgroundView shareHudView].alpha = alpha - 0.01;
}

-(void)comeTimeBounds:(CGRect)bounds{
    
    [AlertHudBackgroundView shareHudView].bounds =
    CGRectMake(0, 0, bounds.size.width, bounds.size.height);
}

-(void)comeTimeAlpha:(CGFloat)alpha withImage:(BOOL)isImage{
    
    [AlertHudBackgroundView shareHudView].alpha = alpha;
    [AlertHudLabel shareHudView].alpha = 1;
}


//获取字节长度
- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

@end
