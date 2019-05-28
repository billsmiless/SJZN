//
//  main.m
//  DSComponents
//
//  Created by cgw on 2019/2/14.
//  Copyright © 2019 bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSArray *names = @[@"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_baoguang1@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_baoguang1@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_bibo@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_bibo@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_hdr@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_hdr@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_huaijiu@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_huaijiu@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_katong@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_katong@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_lengdiao@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_lengdiao@3x.JPG",
                        
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_liunian@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_liunian@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_mengan@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_mengan@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_original@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_original@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_richu@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_richu@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_sumiao@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_sumiao@3x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_yunying@2x.JPG",
                        @"/Users/cgw/Desktop/filter/filter_baoguang.imageset/jpgs/filter_yunying@3x.JPG"];
    
    for( NSInteger i=0; i<names.count; i++ ){
        NSString *fp = names[i];
        NSString *lastCom = [fp lastPathComponent];
        NSString *fileName = [lastCom componentsSeparatedByString:@"."][0];
        
        UIImage *img = [UIImage imageNamed:fp];
        NSString *path = [[@"/Users/cgw/Desktop/filter/filter_baoguang.imageset/pngs/" stringByAppendingString:fileName] stringByAppendingString:@".png"];
        [UIImageJPEGRepresentation(img, 1) writeToFile:path atomically:YES];
    }
    
    return 0;
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
