//
//  ViewController.m
//  calc
//
//  Created by Mac on 13/9/16.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    BOOL isClickNumber;
    BOOL isClickPoint;
    BOOL isClickCalac;
    BOOL isClickOp;
    NSString *calcOp;
}

@property (strong, nonatomic) NSDecimalNumber *calcNum1, *calcNum2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self resetConfig];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_displayLbl release];
    [super dealloc];
}

- (void)resetConfig
{
    self.calcNum1 = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.calcNum2 = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    isClickNumber = NO;
    isClickPoint = NO;
    isClickCalac = NO;
    isClickOp = NO;
    calcOp = @"";
}

- (IBAction)click_num:(UIButton *)sender
{
    if (!isClickNumber) {
        if ([[sender currentTitle] isEqualToString:@"."]) {
            self.displayLbl.text = @"0.";
            isClickPoint = YES;
            isClickNumber = YES;

        }
        else if ([[sender currentTitle] isEqualToString:@"0"]) {
            self.displayLbl.text = @"0";
        }
        else {
            self.displayLbl.text = [sender currentTitle];
            isClickNumber = YES;
        }
    }
    else {
        if ([[sender currentTitle] isEqualToString:@"."] && !isClickPoint) {
            self.displayLbl.text = [self.displayLbl.text stringByAppendingString:@"."];
            isClickPoint = YES;
        }
        
        if (isClickPoint) {
            if (![[sender currentTitle] isEqualToString:@"."]) {
                self.displayLbl.text = [self.displayLbl.text stringByAppendingString:[sender currentTitle]];
            }
        }
        else {
            self.displayLbl.text = [self.displayLbl.text stringByAppendingString:[sender currentTitle]];

        }
    }
    
    isClickOp = NO;
}

- (IBAction)click_clear:(UIButton *)sender
{
    self.displayLbl.text = @"0";

    [self resetConfig];
}

- (IBAction)click_op:(UIButton *)sender
{
    if (isClickOp) {
        // 使用者更改計算
        calcOp = [sender currentTitle];
        return;
    }
    
    if (!isClickCalac && ![calcOp isEqualToString:@""]) {
        self.calcNum2 = [NSDecimalNumber decimalNumberWithString:self.displayLbl.text];
        [self calcNum:calcOp WithNum1:self.calcNum1 andNum2:self.calcNum2];
    }
    else {
        self.calcNum1 = [NSDecimalNumber decimalNumberWithString:self.displayLbl.text];
    }

    isClickPoint = isClickNumber = NO;
    
    if (calcOp) {
        [calcOp release];
    }
    calcOp = [[sender currentTitle] retain];
        
    isClickOp = YES;
}

- (void)calcNum:(NSString *)op WithNum1:(NSDecimalNumber *)num1 andNum2:(NSDecimalNumber *)num2
{
    NSLog(@"%@ %@ %@", [num1 stringValue], op, [num2 stringValue]);
    
    if ([op isEqualToString:@"/"]) {
        if ([[num2 stringValue] isEqualToString:@"0"]) {
            self.displayLbl.text = @"ERROR";
            
            [self resetConfig];
            return;
        }
        else {
            self.calcNum1 = [num1 decimalNumberByDividingBy:num2];
        }
    }
    else if ([op isEqualToString:@"*"]) {
        self.calcNum1 = [num1 decimalNumberByMultiplyingBy:num2];
    }
    else if ([op isEqualToString:@"-"]) {
        self.calcNum1 = [num1 decimalNumberBySubtracting:num2];
    }
    else if ([op isEqualToString:@"+"]) {
        self.calcNum1 = [num1 decimalNumberByAdding:num2];
    }
    
    self.displayLbl.text = [self.calcNum1 stringValue];
    
    calcOp = @"";
    isClickCalac = NO;
    
    NSLog(@"= %@", [self.calcNum1 stringValue]);
}

- (IBAction)click_calc:(UIButton *)sender
{
    isClickCalac = YES;

    self.calcNum2 = [NSDecimalNumber decimalNumberWithString:self.displayLbl.text];
    
    [self calcNum:calcOp WithNum1:self.calcNum1 andNum2:self.calcNum2];
}

@end
