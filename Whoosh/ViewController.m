//
//  ViewController.m
//  Whoosh
//
//  Created by Rodney Sampson on 8/30/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UILabel * sentenceCountLabel;
@property (nonatomic, strong) IBOutlet UITextField * textField;
@property (nonatomic, strong) IBOutlet UIButton * storeTextButton;
@property (strong, nonatomic) IBOutlet UILabel * firstSentenceLabel;
@property (strong, nonatomic) IBOutlet UILabel * secondSentenceLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint * firstSentenceLabelTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint * secondSentenceLabelTopConstraint;
@property (nonatomic) CGFloat currentConstantFirstSentence;
@property (nonatomic) CGFloat currentConstantSecondSentence;
@property (nonatomic, strong) NSString * sentenceOne;
@property (nonatomic, strong) NSString * sentenceTwo;

- (IBAction)storeTextIntoSentence:(UIButton *)sender;

- (void)animateLabels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.delegate = self;
    
    self.sentenceOne = nil;
    self.sentenceTwo = nil;
    self.firstSentenceLabel.adjustsFontSizeToFitWidth = true;
    self.firstSentenceLabel.layer.zPosition = -1;
    self.secondSentenceLabel.adjustsFontSizeToFitWidth = true;
    self.secondSentenceLabel.layer.zPosition = -2;
    
    self.currentConstantFirstSentence = self.firstSentenceLabelTopConstraint.constant;
    self.currentConstantSecondSentence = self.firstSentenceLabelTopConstraint.constant;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

- (void)resetState {
    self.sentenceOne = nil;
    self.sentenceTwo = nil;
    self.firstSentenceLabel.layer.zPosition = -1;
    self.firstSentenceLabel.backgroundColor = [UIColor clearColor];
    self.secondSentenceLabel.layer.zPosition = -1;
    self.secondSentenceLabel.backgroundColor = [UIColor clearColor];
    self.firstSentenceLabelTopConstraint.constant = self.currentConstantFirstSentence;
    self.secondSentenceLabelTopConstraint.constant = self.currentConstantSecondSentence;
    self.sentenceCountLabel.hidden = NO;
    self.textField.hidden = NO;
    self.storeTextButton.hidden = NO;
}

- (void)animateLabels {
    self.view.backgroundColor = [UIColor blackColor];
    self.sentenceCountLabel.hidden = YES;
    self.textField.hidden = YES;
    self.storeTextButton.hidden = YES;
    self.sentenceCountLabel.text = @"No sentence stored.";
    [self.storeTextButton setTitle:@"Store Text" forState:UIControlStateNormal];
    
    CGFloat targetConstantFirstSentence = self.currentConstantFirstSentence + self.view.frame.size.height;
    CGFloat targetConstantSecondSentence = self.currentConstantSecondSentence + self.view.frame.size.height;
    
    [self.view layoutSubviews];
    
    self.firstSentenceLabel.layer.zPosition = 10;
    self.firstSentenceLabel.backgroundColor = [UIColor blueColor];
    [UIView animateWithDuration:5 animations:^{
        self.firstSentenceLabelTopConstraint.constant = targetConstantFirstSentence;
        self.firstSentenceLabel.text = self.sentenceOne;
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
        self.secondSentenceLabel.layer.zPosition = 9;
        self.secondSentenceLabel.backgroundColor = [UIColor blueColor];
    }];
    
    [UIView animateWithDuration:5 delay:5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.secondSentenceLabelTopConstraint.constant = targetConstantSecondSentence;
        self.secondSentenceLabel.text = self.sentenceTwo;
        [self.view layoutSubviews];
    } completion:^(BOOL finished){
        if (finished) {
            [self resetState];
        } else {
            NSLog(@"Whoa!");
        }
    }];
}

- (IBAction)storeTextIntoSentence:(UIButton *)sender {
    if (self.sentenceOne != nil && self.sentenceTwo != nil) {
        [self animateLabels];
    } else {
        if (self.sentenceOne == nil) {
            self.sentenceOne = self.textField.text;
            self.sentenceCountLabel.text = @"One sentence stored.";
        } else {
            self.sentenceTwo = self.textField.text;
            self.sentenceCountLabel.text = @"Two sentences stored.";
            [self.storeTextButton setTitle:@"Play Story" forState:UIControlStateNormal];
        }
    }
}

@end
