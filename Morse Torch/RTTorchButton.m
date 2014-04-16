//
//  RTTorchButton.m
//  Morse Torch
//
//  Created by Ryo Tulman on 4/14/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTTorchButton.h"

@implementation RTTorchButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIFont *font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
        UIColor* textColor = [UIColor colorWithRed:0.000 green:0.427 blue:0.832 alpha:1.000];
        NSDictionary *attrs = @{ NSForegroundColorAttributeName : textColor,
                                 NSFontAttributeName : font,
                                 NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
        NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:@"Torch It!" attributes:attrs];
        [self setAttributedTitle:attrString forState:UIControlStateNormal];
    }
    return self;
}

-(void)setInverted:(BOOL)inverted
{
    _inverted = inverted;
    if (_inverted) {
        UIFont *font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
        UIColor *textColor = [UIColor colorWithRed:0.725 green:0.024 blue:0.000 alpha:1.000];
        NSDictionary *attrs = @{ NSForegroundColorAttributeName : textColor,
                   NSFontAttributeName : font,
                   NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"TORCHING" attributes:attrs];
        [self setAttributedTitle:attrString forState:UIControlStateNormal];
    } else {
        UIFont *font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
        UIColor* textColor = [UIColor colorWithRed:0.000 green:0.427 blue:0.832 alpha:1.000];
        NSDictionary *attrs = @{ NSForegroundColorAttributeName : textColor,
                                 NSFontAttributeName : font,
                                 NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
        NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:@"Torch It!" attributes:attrs];
        [self setAttributedTitle:attrString forState:UIControlStateNormal];
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.inverted) {
        //// General Declarations
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.928 green: 0.525 blue: 0.332 alpha: 1];
        UIColor* color6 = [UIColor colorWithRed: 0.977 green: 0.83 blue: 0.311 alpha: 1];
        UIColor* color8 = [UIColor colorWithRed:0.663 green:0.442 blue:0.000 alpha:1.000];
        UIColor* color11 = [UIColor colorWithRed: 0.941 green: 0.604 blue: 0.325 alpha: 0.284];
        
        //// Gradient Declarations
        NSArray* linearGradientColors = [NSArray arrayWithObjects:
                                         (id)color6.CGColor,
                                         (id)color.CGColor, nil];
        CGFloat linearGradientLocations[] = {0, 1};
        CGGradientRef linearGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)linearGradientColors, linearGradientLocations);
        
        //// Shadow Declarations
        UIColor* glow = color8;
        CGSize glowOffset = CGSizeMake(0.1, 5.1);
        CGFloat glowBlurRadius = 6;
        
        //// Frames
        CGRect torchFrame = rect;
        
        //// Subframes
        CGRect button = CGRectMake(CGRectGetMinX(torchFrame) + 4, CGRectGetMinY(torchFrame) + 4, floor((CGRectGetWidth(torchFrame) - 4) * 0.97872 + 0.5), floor((CGRectGetHeight(torchFrame) - 4) * 0.93939 + 0.5));
        
        
        //// Button
        {
            //// Rounded Rectangle Drawing
            CGRect roundedRectangleRect = CGRectMake(CGRectGetMinX(button) + floor(CGRectGetWidth(button) * 0.00000 + 0.5), CGRectGetMinY(button) + floor(CGRectGetHeight(button) * 0.00000 + 0.5), floor(CGRectGetWidth(button) * 1.00000 + 0.5) - floor(CGRectGetWidth(button) * 0.00000 + 0.5), floor(CGRectGetHeight(button) * 1.00000 + 0.5) - floor(CGRectGetHeight(button) * 0.00000 + 0.5));
            UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: roundedRectangleRect cornerRadius: 22];
            CGContextSaveGState(context);
            [roundedRectanglePath addClip];
            CGContextDrawLinearGradient(context, linearGradient,
                                        CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMaxY(roundedRectangleRect)),
                                        CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMinY(roundedRectangleRect)),
                                        0);
            CGContextRestoreGState(context);
            
            ////// Rounded Rectangle Inner Shadow
            CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -glowBlurRadius, -glowBlurRadius);
            roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -glowOffset.width, -glowOffset.height);
            roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
            
            UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
            [roundedRectangleNegativePath appendPath: roundedRectanglePath];
            roundedRectangleNegativePath.usesEvenOddFillRule = YES;
            
            CGContextSaveGState(context);
            {
                CGFloat xOffset = glowOffset.width + round(roundedRectangleBorderRect.size.width);
                CGFloat yOffset = glowOffset.height;
                CGContextSetShadowWithColor(context,
                                            CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                            glowBlurRadius,
                                            glow.CGColor);
                
                [roundedRectanglePath addClip];
                CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
                [roundedRectangleNegativePath applyTransform: transform];
                [[UIColor grayColor] setFill];
                [roundedRectangleNegativePath fill];
            }
            CGContextRestoreGState(context);
            
            [color11 setStroke];
            roundedRectanglePath.lineWidth = 3;
            [roundedRectanglePath stroke];
        }
        //// Cleanup
        CGGradientRelease(linearGradient);
        CGColorSpaceRelease(colorSpace);
    } else {
        //// General Declarations
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.928 green: 0.525 blue: 0.332 alpha: 1];
        UIColor* color6 = [UIColor colorWithRed: 0.977 green: 0.83 blue: 0.311 alpha: 1];
        UIColor* color8 = [UIColor colorWithRed: 1 green: 1 blue: 0.8 alpha: 1];
        UIColor* color11 = [UIColor colorWithRed: 0.941 green: 0.604 blue: 0.325 alpha: 0.284];
        
        //// Gradient Declarations
        NSArray* linearGradientColors = [NSArray arrayWithObjects:
                                         (id)color6.CGColor,
                                         (id)color.CGColor, nil];
        CGFloat linearGradientLocations[] = {0, 1};
        CGGradientRef linearGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)linearGradientColors, linearGradientLocations);
        
        //// Shadow Declarations
        UIColor* glow = color8;
        CGSize glowOffset = CGSizeMake(0.1, 5.1);
        CGFloat glowBlurRadius = 6;
        
        //// Frames
        CGRect torchFrame = rect;
        
        //// Subframes
        CGRect button = CGRectMake(CGRectGetMinX(torchFrame) + 4, CGRectGetMinY(torchFrame) + 4, floor((CGRectGetWidth(torchFrame) - 4) * 0.97872 + 0.5), floor((CGRectGetHeight(torchFrame) - 4) * 0.93939 + 0.5));
        
        
        //// Button
        {
            //// Rounded Rectangle Drawing
            CGRect roundedRectangleRect = CGRectMake(CGRectGetMinX(button) + floor(CGRectGetWidth(button) * 0.00000 + 0.5), CGRectGetMinY(button) + floor(CGRectGetHeight(button) * 0.00000 + 0.5), floor(CGRectGetWidth(button) * 1.00000 + 0.5) - floor(CGRectGetWidth(button) * 0.00000 + 0.5), floor(CGRectGetHeight(button) * 1.00000 + 0.5) - floor(CGRectGetHeight(button) * 0.00000 + 0.5));
            UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: roundedRectangleRect cornerRadius: 22];
            CGContextSaveGState(context);
            [roundedRectanglePath addClip];
            CGContextDrawLinearGradient(context, linearGradient,
                                        CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMinY(roundedRectangleRect)),
                                        CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMaxY(roundedRectangleRect)),
                                        0);
            CGContextRestoreGState(context);
            
            ////// Rounded Rectangle Inner Shadow
            CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -glowBlurRadius, -glowBlurRadius);
            roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -glowOffset.width, -glowOffset.height);
            roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
            
            UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
            [roundedRectangleNegativePath appendPath: roundedRectanglePath];
            roundedRectangleNegativePath.usesEvenOddFillRule = YES;
            
            CGContextSaveGState(context);
            {
                CGFloat xOffset = glowOffset.width + round(roundedRectangleBorderRect.size.width);
                CGFloat yOffset = glowOffset.height;
                CGContextSetShadowWithColor(context,
                                            CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                            glowBlurRadius,
                                            glow.CGColor);
                
                [roundedRectanglePath addClip];
                CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
                [roundedRectangleNegativePath applyTransform: transform];
                [[UIColor grayColor] setFill];
                [roundedRectangleNegativePath fill];
            }
            CGContextRestoreGState(context);
            
            [color11 setStroke];
            roundedRectanglePath.lineWidth = 3;
            [roundedRectanglePath stroke];
        }
        //// Cleanup
        CGGradientRelease(linearGradient);
        CGColorSpaceRelease(colorSpace);
    }
}


@end
