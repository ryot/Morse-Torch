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
#import <AVFoundation/AVFoundation.h>

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

@interface RTInputViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet RTTorchButton *torchButton;
@property (nonatomic, strong) NSArray *currentMorseArray;
@property (nonatomic) BOOL isMorsing;
@property (nonatomic, strong) NSOperationQueue *torchQueue;
@property (weak, nonatomic) IBOutlet UILabel *currentLetterLabel;

@end

@implementation RTInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentLetterLabel.text = @"Ready";
    _currentLetterLabel.textAlignment = NSTextAlignmentCenter;
    _inputTextView.text = @"Hello World";
    _inputTextView.delegate = self;
    _inputTextView.layer.borderWidth = 2.0;
    _inputTextView.layer.borderColor = [UIColor colorWithRed:1.000 green:0.689 blue:0.002 alpha:1.000].CGColor;
    _inputTextView.backgroundColor = [UIColor colorWithRed:1.000 green:0.987 blue:0.886 alpha:1.000];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mochaGrunge.png"]];
}

- (IBAction)morseTorchPressed:(id)sender {
    if (_isMorsing) {
        _isMorsing = NO;
        [_torchQueue cancelAllOperations];
        [self turnOffTorch];
        _currentLetterLabel.text = @"Stopped";
    } else if (!_isMorsing && _inputTextView.text.length > 0) {
        NSDictionary *morseCode = [NSString morseDict];
        _isMorsing = YES;
        _currentMorseArray = [_inputTextView.text morseThisString];
        _torchQueue = [NSOperationQueue new];
        _torchQueue.maxConcurrentOperationCount = 1;
        for (NSString *thisMorseSymbol in _currentMorseArray) {
            if ([thisMorseSymbol isEqualToString:@"wordSpace"]) {
                [_torchQueue addOperationWithBlock:^{
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        _currentLetterLabel.text = @"Space";
                    }];
                    [self turnOffTorch];
                    usleep(400000); //sums to 7 units including pauses between code characters and entire code symbols
                    if ([thisMorseSymbol isEqual:_currentMorseArray.lastObject]) {
                        _isMorsing = NO;
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            _torchButton.inverted = NO;
                            _currentLetterLabel.text = @"All Done";
                        }];
                    }
                }];
            } else {
                for (int i = 0; i < thisMorseSymbol.length; i++) {
                    [_torchQueue addOperationWithBlock:^{
                        NSString *currentLetterString = [[NSString stringWithFormat:@"%@: ", [[morseCode allKeysForObject:thisMorseSymbol] firstObject]] stringByAppendingString:thisMorseSymbol];
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            _currentLetterLabel.text = currentLetterString;
                        }];
                        unichar thisChar = [thisMorseSymbol characterAtIndex:i];
                        if (thisChar == '.') {
                            [self turnOnTorch];
                            usleep(100000);
                        } else if (thisChar == '-') {
                            [self turnOnTorch];
                            usleep(300000);
                        }
                        [self turnOffTorch];
                        usleep(100000);
                        if ([thisMorseSymbol isEqual:_currentMorseArray.lastObject] && i == thisMorseSymbol.length - 1) {
                            _isMorsing = NO;
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                _torchButton.inverted = NO;
                                _currentLetterLabel.text = @"All Done";
                            }];
                        }
                    }];
                }
                //add space between characters
                if (_isMorsing) {
                    [_torchQueue addOperationWithBlock:^{
                        usleep(200000);
                    }];
                }
            }
        }
    }
    _torchButton.inverted = !_torchButton.inverted;
    [_torchButton setNeedsDisplay];
    NSLog([_currentMorseArray description]);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)eventb
{
    [self.view endEditing:YES];
}

-(void)turnOnTorch
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device setFlashMode:AVCaptureFlashModeOn];
        [device unlockForConfiguration];
    }
}

-(void)turnOffTorch
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device setFlashMode:AVCaptureFlashModeOff];
        [device unlockForConfiguration];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
