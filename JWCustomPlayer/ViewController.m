//
//  ViewController.m
//  JWCustomPlayer
//
//  Created by Karim Mourra on 12/23/15.
//  Copyright © 2015 Karim Mourra. All rights reserved.
//

#import "ViewController.h"
#import <JWPlayer-iOS-SDK/JWPlayerController.h>

#define videoFile @"http://content.bitsontherun.com/videos/bkaovAYt-52qL9xLP.mp4"

@interface ViewController () <JWPlayerDelegate>

@property (nonatomic) JWPlayerController *player;
@property (nonatomic) UILabel *logo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPlayer];
    [self setUpLogo];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.view addSubview:self.player.view];
    [self.player.view addSubview:self.logo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPlayer
{
    JWConfig* config = [[JWConfig alloc]initWithContentUrl:videoFile];
    config.image = @"http://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg";
    config.size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
    config.cssSkin = @"http://p.jwpcdn.com/iOS/Skins/ethan.css";
    config.autostart = YES;
    config.repeat = YES;
    config.stretch = JWStretchExactFit;
    
    self.player = [[JWPlayerController alloc]initWithConfig:config];
    self.player.forceLandscapeOnFullScreen = YES;
    self.player.forceFullScreenOnLandscape = YES;
    self.player.view.center = self.view.center;
    self.player.delegate = self;
}

- (void)setUpLogo
{
    CGRect logoFrame = [self calculateLogoFrame:self.player.view.frame.size];
    self.logo = [[UILabel alloc]initWithFrame:logoFrame];
    [self.logo setText:@"Logo"];
    [self.logo setTextAlignment:NSTextAlignmentCenter];
    [self.logo setTextColor:[UIColor whiteColor]];

    [self.logo setBackgroundColor:[UIColor blueColor]];
    self.logo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.logo.userInteractionEnabled = NO;
}

- (CGRect)calculateLogoFrame:(CGSize)safeRegion
{
    CGFloat logoWidth = 100;
    CGFloat logoHeight = 40;
    CGFloat logoX = safeRegion.width - logoWidth - 10;
    CGFloat logoY = safeRegion.height - logoHeight - 10;
    return CGRectMake(logoX, logoY, logoWidth, logoHeight);
}

-(void)onTime:(double)position ofDuration:(double)duration
{
    if (position <= 1
        && (self.player.safeRegion.size.height != self.player.view.frame.size.height)) {
        [self.logo removeFromSuperview];
        CGRect logoFrame = [self calculateLogoFrame:self.player.safeRegion.size];
        self.logo.frame = logoFrame;
        [self.player.view addSubview:self.logo];
    }
}

@end
