//
//  RTViewController.m
//  Morse Torch
//
//  Created by Ryo Tulman on 4/14/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTInputViewController.h"
#import "RTTorchButton.h"
#import "NSString+MorseCoder.h"

@interface RTInputViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UIButton *torchButton;
@property (nonatomic, strong) NSArray *currentMorseArray;

@end

@implementation RTInputViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _inputTextView.text = @"test";
    _inputTextView.delegate = self;
    _inputTextView.layer.borderWidth = 2.0;
    _inputTextView.layer.borderColor = [UIColor colorWithRed:1.000 green:0.689 blue:0.002 alpha:1.000].CGColor;
    _inputTextView.backgroundColor = [UIColor colorWithRed:1.000 green:0.987 blue:0.886 alpha:1.000];
    self.view.backgroundColor = [UIColor darkGrayColor];
}
- (IBAction)morseTorchPressed:(id)sender {
    RTTorchButton *button = (RTTorchButton *)sender;
    button.inverted = !button.inverted;
    [button setNeedsDisplay];
    _currentMorseArray = [_inputTextView.text morseThisString];
    NSLog([_currentMorseArray description]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
