//
//  NSString+MorseCoder.m
//  Morse Torch
//
//  Created by Ryo Tulman on 4/14/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "NSString+MorseCoder.h"

@implementation NSString (MorseCoder)

-(NSArray *)morseThisString {
    NSDictionary *morseDict = [NSString morseDict];
    NSMutableArray *morseArray = [NSMutableArray new];
    NSString *prevChar;
    for (int i = 0; i < self.length; i++) {
        unichar thisChar = [self characterAtIndex:i];
        NSString *thisCharString = [NSString stringWithFormat:@"%c", thisChar];
        NSString *thisCharMorseValue = [morseDict objectForKey:[thisCharString capitalizedString]];
        if (thisCharMorseValue) {
            if ([thisCharString  isEqualToString:@" "] && [thisCharString isEqualToString:prevChar]) {
                prevChar = thisCharString;
                continue; //skip extra spaces
            }
            [morseArray addObject:thisCharMorseValue];
        }
        prevChar = thisCharString;
    }
    return [NSArray arrayWithArray:morseArray];
}

+(NSDictionary *)morseDict
{
    return @{@" ": @"wordSpace", //morse spaces between words are 7 units, rather than the 3 between letters. #TODO figure out where I should factor this in.
             @"A": @".-",
             @"B": @"-...",
             @"C": @"-.-.",
             @"D": @"-..",
             @"E": @".",
             @"F": @"..-.",
             @"G": @"--.",
             @"H": @"....",
             @"I": @"..",
             @"J": @".---",
             @"K": @"-.-",
             @"L": @".-..",
             @"M": @"--",
             @"N": @"-.",
             @"O": @"---",
             @"P": @".--.",
             @"Q": @"--.-",
             @"R": @".-.",
             @"S": @"...",
             @"T": @"-",
             @"U": @"..-",
             @"V": @"...-",
             @"W": @".--",
             @"X": @"-..-",
             @"Y": @"-.--",
             @"Z": @"--..",
             @"0": @".----",
             @"1": @"..---",
             @"2": @"...--",
             @"3": @"....-",
             @"4": @".....",
             @"5": @"-....",
             @"6": @"--...",
             @"7": @"---..",
             @"8": @"----.",
             @"9": @"-----"};
}

@end
