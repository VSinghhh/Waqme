//
//  HomeViewController.h
//  demowaqme
//
//  Created by Bilal Nasir on 02/09/2014.
//  Copyright (c) 2014 axonshare. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface HomeViewController : UIViewController<UIWebViewDelegate>
{
    
}

@property (nonatomic,retain)MBProgressHUD* indicatorView;
@end
