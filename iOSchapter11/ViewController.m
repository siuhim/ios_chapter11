//
//  ViewController.m
//  iOSchapter11
//
//  Created by Jimmy Tang on 3/31/14.
//  Copyright (c) 2014 Jimmy Tang. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

@interface ViewController() <
ImageCaptureDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>
@end

@implementation ViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        MyScene * scene = [MyScene sceneWithSize:skView.bounds.size];
        scene.delegate = self;
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark ImageCaptureDelegate methods
- (void)requestImagePicker
{
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES
                     completion:nil];
}

#pragma mark UIImagePickerControllerDelegate methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1
    UIImage *image =
    [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //2
    [picker dismissViewControllerAnimated:YES completion:^{
        //3
        SKTexture *imageTexture =[SKTexture textureWithImage:image];
        //4
        SKView *view = (SKView *)self.view;
        MyScene *currentScene = (MyScene *)[view scene];
        //Place core image code here
        [currentScene setPhotoTexture:imageTexture];
    }];
}

@end
