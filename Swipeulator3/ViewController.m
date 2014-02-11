//
//  ViewController.m
//  Swipeulator3
//
//  Created by Mark Hartnady on 11/02/2014.
//  Copyright (c) 2014 Bilnady Inc. All rights reserved.
//

#import "ViewController.h"
#import "BackGround.h"
#import "DDMathParser/DDMathParser.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *viewImage;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap;
@property (strong, nonatomic) IBOutlet UILabel *outputText;
@property (strong, nonatomic) IBOutlet UILabel *calcDisplay;

@end

@implementation ViewController

BOOL mustReset = NO;

-(void)viewWillAppear:(BOOL)animated
{
    CAGradientLayer *bgLayer = [Background blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.swipe];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAll;
}

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
- (IBAction)showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer {
	
	CGPoint location = [recognizer locationInView:self.view];
	[self drawImageForGestureRecognizer:recognizer atPoint:location];
	
	[UIView animateWithDuration:0.5 animations:^{
        self.viewImage.alpha = 0.0;
    }];
    
    NSLog(@"Tap");
}

/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */
- (IBAction)showGestureForSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
    
    NSMutableString* tmp = [[NSMutableString alloc] initWithString:self.calcDisplay.text];
    
	CGPoint location = [recognizer locationInView:self.view];
	[self drawImageForGestureRecognizer:recognizer atPoint:location];
    
    if (location.x > 113.0 && location.x < 192.0 && location.y > 395.0 && location.y < 475.0 ) {
        
        if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
            location.x -= 220.0;
            [tmp appendString:@"+"];
        }
        else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
            location.x += 220.0;
            [tmp appendString:@"-"];
        }
        else if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
            [tmp appendString:@"/"];
        }
        else {
            [tmp appendString:@"x"];
        }
        
        self.calcDisplay.text = tmp;
    }
    
	[UIView animateWithDuration:0.5 animations:^{
        self.viewImage.alpha = 0.0;
        self.viewImage.center = location;
    }];
    
    NSLog(@"Swipe");
}

- (IBAction)showGestureForLongPressRecognizer:(UILongPressGestureRecognizer *)sender {
    self.calcDisplay.text = @"";
}


- (void)drawImageForGestureRecognizer:(UIGestureRecognizer *)recognizer atPoint:(CGPoint)centerPoint {
    
//	NSString *imageName;
//    
//    if ([recognizer isMemberOfClass:[UITapGestureRecognizer class]]) {
//        imageName = @"tap";
//        //msg = @"Tap";
//    }
//    else if ([recognizer isMemberOfClass:[UISwipeGestureRecognizer class]]) {
//        imageName = @"swipe";
//        //msg = @"Swipe";
//    }
    
//	self.viewImage.image = [UIImage imageNamed:imageName];
//	self.viewImage.center = centerPoint;
//	self.viewImage.alpha = 1.0;
    
    CGPoint location = [recognizer locationInView:self.view];
    location.y += 25.0;
    //location.x += 40.0;
    
    NSMutableString* tmp = [[NSMutableString alloc] initWithString:self.calcDisplay.text];
    
    if (mustReset) {
        tmp = [[NSMutableString alloc] initWithString:@""];
        mustReset = NO;
    }
    
    if (location.x > 20.0 && location.x < 90.0 && location.y > 330.0 && location.y < 410.0)
    {
        [tmp appendString:@"1"];
    } else if (location.x > 113.0 && location.x < 192.0 && location.y > 330.0 && location.y < 410.0)
    {
        [tmp appendString:@"2"];
    } else if (location.x > 205.0 && location.x < 284.0 && location.y > 330.0 && location.y < 410.0)
    {
        [tmp appendString:@"3"];
    } else if (location.x > 20.0 && location.x < 90.0 && location.y > 240.0 && location.y < 317.0)
    {
        [tmp appendString:@"4"];
    } else if (location.x > 113.0 && location.x < 192.0 && location.y > 240.0 && location.y < 317.0)
    {
        [tmp appendString:@"5"];
    } else if (location.x > 205.0 && location.x < 284.0 && location.y > 240.0 && location.y < 317.0)
    {
        [tmp appendString:@"6"];
    } else if (location.x > 20.0 && location.x < 90.0 && location.y > 150.0 && location.y < 230.0)
    {
        [tmp appendString:@"7"];
    } else if (location.x > 113.0 && location.x < 192.0 && location.y > 150.0 && location.y < 230.0)
    {
        [tmp appendString:@"8"];
    } else if (location.x > 205.0 && location.x < 284.0 && location.y > 150.0 && location.y < 230.0)
    {
        [tmp appendString:@"9"];
    } else if (location.x > 20.0 && location.x < 90.0 && location.y > 420.0 && location.y < 500.0)
    {
        [tmp appendString:@"0"];
    }
//    else if (location.x > 113.0 && location.x < 192.0 && location.y > 420.0 && location.y < 500.0)
//    {
//        [tmp appendString:@"+"];
//    }
    else if (location.x > 205.0 && location.x < 284.0 && location.y > 420.0 && location.y < 500.0)
    {

        NSNumber *result = [tmp numberByEvaluatingString];
        [tmp appendString:[[NSMutableString alloc]initWithFormat:@"=%@",result ]];
        mustReset = YES;
        
    }
    
    self.calcDisplay.text = tmp;
 

}

@end
