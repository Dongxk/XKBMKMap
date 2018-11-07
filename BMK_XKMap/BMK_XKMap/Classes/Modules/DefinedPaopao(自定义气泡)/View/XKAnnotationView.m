//
//  XKAnnotationView.m
//  JZFP_GS
//
//  Created by 董向坤 on 2018/10/30.
//  Copyright © 2018 xiao_kun. All rights reserved.
//

#import "XKAnnotationView.h"

@interface XKAnnotationView ()

@end

@implementation XKAnnotationView

/*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  - (void)drawRect:(CGRect)rect {
  // Drawing code
  }
  */

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier customView:(UIView *)detailView WithData:(NSDictionary *)dataDict WithTag:(NSInteger)tag{
    
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        if (self) {
            
            [self setBounds:CGRectMake(0, 0, 100.f, 100.f)];
            self.canShowCallout = YES;
            self.centerOffset = CGPointMake(0, 0); //设置中心点偏移
            detailView.tag = tag;
            
            [self configCellWithData:dataDict];
            [self addSubview: detailView];
        }
    }
    return self;
}


- (void)configCellWithData:(NSDictionary *)data{
  
    self.image = [UIImage imageNamed:@"location"];
}


@end

