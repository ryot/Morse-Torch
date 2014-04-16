//
//  NSString+MorseCoder.h
//  Morse Torch
//
//  Created by Ryo Tulman on 4/14/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MorseCoder)

-(NSArray *)morseThisString;
+(NSDictionary *)morseDict;

@end
