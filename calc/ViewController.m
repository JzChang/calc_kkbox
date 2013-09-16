//
//  ViewController.m
//  calc
//
//  Created by Mac on 13/9/16.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSDecimalNumber *calcNum1, *calcNum2;


@end

BOOL isClickNumber = NO;
BOOL isClickPoint = NO;
BOOL isClickCalac = NO;
BOOL isClickOp = NO;

NSString *calcOp = @"";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.calcNum1 = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.calcNum2 = [NSDecimalNumber decimalNumberWithString:@"0"];
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

- (IBAction)click_num:(UIButton *)sender {
        
    
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
    
    
}

- (IBAction)click_clear:(UIButton *)sender {
    self.displayLbl.text = @"0";
    isClickPoint = isClickNumber = NO;
}

- (IBAction)click_op:(UIButton *)sender {
    
    
    if (!isClickCalac && ![calcOp isEqualToString:@""]) {
        self.calcNum2 = [NSDecimalNumber decimalNumberWithString:self.displayLbl.text];
        [self calcNum:calcOp WithNum1:self.calcNum1 andNum2:self.calcNum2];
    }
    else {
        self.calcNum1 = [NSDecimalNumber decimalNumberWithString:self.displayLbl.text];
    }

    
    isClickPoint = isClickNumber = NO;
    
    if ([[sender currentTitle] isEqualToString:@"/"]) {
        calcOp = @"/";
    }
    else if ([[sender currentTitle] isEqualToString:@"*"]) {
        calcOp = @"*";
    }
    else if ([[sender currentTitle] isEqualToString:@"-"]) {
        calcOp = @"-";
    }
    else if ([[sender currentTitle] isEqualToString:@"+"]) {
        calcOp = @"+";
    }


    
    
}

- (void)calcNum:(NSString *)op WithNum1:(NSDecimalNumber *)num1 andNum2:(NSDecimalNumber *)num2
{
    NSLog(@"%@ %@ %@", [num1 stringValue], op, [num2 stringValue]);
    
    if ([op isEqualToString:@"/"]) {
        if ([[num2 stringValue] isEqualToString:@"0"]) {
            self.displayLbl.text = @"ERROR";
            isClickPoint = isClickNumber = NO;

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


- (IBAction)click_calc:(UIButton *)sender {
    
    isClickCalac = YES;

    self.calcNum2 = [NSDecimalNumber decimalNumberWithString:self.displayLbl.text];
    
    [self calcNum:calcOp WithNum1:self.calcNum1 andNum2:self.calcNum2];
    

}




@end
