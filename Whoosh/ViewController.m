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
@property (nonatomic, strong) IBOutlet UIButton * storeTextButton;
@property (strong, nonatomic) IBOutlet UILabel * firstSentenceLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *firstSentenceLabelTopConstraint;
@property (strong, nonatomic) IBOutlet UILabel * secondSentenceLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondSentenceLabelTopConstraint;
@property (nonatomic, strong) NSString * currentSentence;
@property (nonatomic, strong) NSString * sentenceOne;
@property (nonatomic, strong) NSString * sentenceTwo;

- (IBAction)storeTextIntoSentence:(UIButton *)sender;

- (void)animateLabels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentSentence = nil;
    self.sentenceOne = nil;
    self.sentenceTwo = nil;
    self.firstSentenceLabel.adjustsFontSizeToFitWidth = true;
    self.firstSentenceLabel.layer.zPosition = -1;
    self.secondSentenceLabel.adjustsFontSizeToFitWidth = true;
    self.secondSentenceLabel.layer.zPosition = -2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.currentSentence = textField.text;
}

- (void)animateLabels {
    self.view.backgroundColor = [UIColor blackColor];
    self.sentenceCountLabel.text = @"No sentence stored.";
    [self.storeTextButton setTitle:@"Store Text" forState:UIControlStateNormal];
    
    CGFloat currentConstantFirstSentence = self.firstSentenceLabelTopConstraint.constant;
    CGFloat targetConstantFirstSentence = currentConstantFirstSentence + self.view.frame.size.height;
    CGFloat currentConstantSecondSentence = self.firstSentenceLabelTopConstraint.constant;
    CGFloat targetConstantSecondSentence = currentConstantSecondSentence + self.view.frame.size.height;
    
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
            self.currentSentence = nil;
            self.sentenceOne = nil;
            self.sentenceTwo = nil;
            self.firstSentenceLabel.layer.zPosition = -1;
            self.firstSentenceLabel.backgroundColor = [UIColor clearColor];
            self.secondSentenceLabel.layer.zPosition = -1;
            self.secondSentenceLabel.backgroundColor = [UIColor clearColor];
            self.firstSentenceLabelTopConstraint.constant = currentConstantFirstSentence;
            self.secondSentenceLabelTopConstraint.constant = currentConstantSecondSentence;
        } else {
            NSLog(@"Whoa!");
        }
    }];
}

- (IBAction)storeTextIntoSentence:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"Play Story"] && self.sentenceOne != nil && self.sentenceTwo != nil) {
        [self animateLabels];
    } else {
        if ([sender.currentTitle isEqualToString:@"Store Text"] && (self.sentenceOne == nil || self.sentenceTwo == nil)) {
            if (self.sentenceOne == nil) {
                self.sentenceOne = self.currentSentence;
                self.sentenceCountLabel.text = @"One sentence stored.";
            } else if (self.sentenceTwo == nil) {
                self.sentenceTwo = self.currentSentence;
                self.sentenceCountLabel.text = @"Two sentences stored.";
                [self.storeTextButton setTitle:@"Play Story" forState:UIControlStateNormal];
            }
        }}
}

@end
