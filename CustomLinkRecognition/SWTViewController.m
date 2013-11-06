//
//  SWTViewController.m
//  CustomLinkRecognition
//
//  Created by Markus on 11.06.13.
//  Copyright (c) 2013 nxtbgthng. All rights reserved.
//

#import "SWTViewController.h"

@interface SWTViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation SWTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.view.userInteractionEnabled = YES;
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectInset(self.view.bounds, 40, 40)];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.textView.font = [UIFont systemFontOfSize:16.0];
    self.textView.selectable = NO;
    [self.view addSubview:self.textView];

    self.textView.text = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
    self.textView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    [self.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
}

- (void)tap:(UITapGestureRecognizer*)recognizer;
{
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        CGPoint touch = [recognizer locationInView:recognizer.view];
        [self highlightWordAtLocation:touch];
    }
}

- (void)highlightWordAtLocation:(CGPoint)location;
{
    location.x -= self.textView.contentInset.left;
    location.y -= self.textView.contentInset.top + 10; // textView stars text at 10px
    
    int gIndex = [self.textView.layoutManager glyphIndexForPoint:location
                                                 inTextContainer:self.textView.textContainer
                                  fractionOfDistanceThroughGlyph:nil];
    
    int cIndex = [self.textView.layoutManager characterIndexForGlyphAtIndex:gIndex];
    NSInteger length = self.textView.text.length;
    NSInteger position = MIN(MAX(0, cIndex),length-1);
    NSRange before = [self.textView.text rangeOfString:@" " options:NSBackwardsSearch range:NSMakeRange(0, position+1)];
    NSRange after = [self.textView.text rangeOfString:@" " options:0 range:NSMakeRange(position, length-position)];
    NSInteger start = (before.location == NSNotFound) ? 0 : before.location;
    NSInteger end = (after.location == NSNotFound) ? length-1 : after.location;
    NSRange wordRange = NSMakeRange(start, end-start);

    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:self.textView.text
                                                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
    [atStr setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName:[UIColor redColor]} range:wordRange];
    self.textView.attributedText = atStr;
}

@end
